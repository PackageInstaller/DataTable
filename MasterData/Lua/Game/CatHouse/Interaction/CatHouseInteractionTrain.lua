---
--- Created by Eric.
--- DateTime: 2022/3/16 10:34
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local ConstantsCatHouse = import("Game.CatHouse.ConstantsCatHouse")
local UIModule = CS.Engine.UI.UIModule

------------ import ------------

------------ define ------------
local DESTROY_EVENT_NAME = "DESTROY_EVENT_NAME"
------------ define ------------


---@class CatHouseInteractionTrain
---@field CommonBtnConsumePop           	UnityEngine.RectTransform
---@field FontStyleButton2              	UnityEngine.RectTransform
---@field FontStyleButton               	UnityEngine.RectTransform
---@field Text2                         	TMPro.TextMeshProUGUI
---@field FrameNode                     	UnityEngine.RectTransform
---@field pos4                          	UnityEngine.RectTransform
---@field pos3                          	UnityEngine.RectTransform
---@field pos2                          	UnityEngine.RectTransform
---@field pos1                          	UnityEngine.RectTransform
local CatHouseInteractionTrain = Class("CatHouseInteractionTrain")
function CatHouseInteractionTrain:__init()
    self.trainTimeLimit = nil
    self.trainConsumeId = nil
    self.trainConsumeNum = nil
    self.trainCellList = {}
    self.rolesData = {}
    self.catData = {}
    self.confirmAction = nil
    self.quickFormationAction = nil
    self.isDestroyed = false
    self.onDestroy = Events.AddListener(DESTROY_EVENT_NAME, function()
        if not self.isDestroyed then
            self:OnDestroy()
        end
    end)
end

function CatHouseInteractionTrain:__delete()
    if self.isDestroyed then
        Events.RemoveListener(DESTROY_EVENT_NAME, self.onDestroy)
    end
    self.onDestroy = nil
    self.trainTimeLimit = nil
    self.trainConsumeId = nil
    self.trainConsumeNum = nil
    self.trainCellList = nil
    self.rolesData = nil
    self.catData = nil
    self.confirmAction = nil
    self.quickFormationAction = nil

    self.controller = nil
end

function CatHouseInteractionTrain:SetQuickFormationCB(cb)
    self.quickFormationAction = cb
end

function CatHouseInteractionTrain:SetConfirmTrainCB(cb)
    self.confirmAction = cb
end

function CatHouseInteractionTrain:Awake()
    self.EventSetTrainCell = Events.AddListener(Constants.EventNames.CatHouseCatTrainRolesSet, Bind(self, self.SetTrainCell))
    self.trainTimeLimit = checkNumber(CfUtils.GetCfVo(AutoIds.IdSetting1903, "BaseArgVo", ConstantsCatHouse.Params.TrainTimeLimit).num)
    self.trainConsumeId = checkNumber(CfUtils.GetCfVo(AutoIds.IdSetting1903, "BaseArgVo", ConstantsCatHouse.Params.TrainConsumeId).num)
    self.trainConsumeNum = checkNumber(CfUtils.GetCfVo(AutoIds.IdSetting1903, "BaseArgVo", ConstantsCatHouse.Params.TrainConsumeNum).num)
    self:SetTrainCell({})
    SetButtonAction(self.FontStyleButton, function ()
        self.quickFormationAction()
    end)
    SetButtonAction(self.FontStyleButton2, function ()
        self.confirmAction(self.rolesData)
    end)
end

---@param data table 猫数据
function CatHouseInteractionTrain:FreshBaseUI(data)
    self.catData = data
    self.Text2.text = self.trainTimeLimit - checkNumber(data.trainingTimes)

end

function CatHouseInteractionTrain:GetTrainCell()
    return self.rolesData
end


function CatHouseInteractionTrain:SetTrainCell(rolesData)
    self.rolesData = rolesData
    KTool.SetActive(self.CommonBtnConsumePop, false)
    for i = 1, 4 do
        local go
        go = self.trainCellList[i]
        if not go then
            go = CfUtils.InstantiateGo(self.FrameNode, self["pos"..i].transform.gameObject)
            go.name = "Node"..i
            go.transform.localPosition = Vector3.zero
            self.trainCellList[i] = go.gameObject
        end
        local env = CfUtils.GetLuaScr(go, "Game.CatHouse.Interaction.CatHouseInteractionTrainCell")
        if env then
            local roleData = rolesData[i]--当前位置没有角色直接传空数据
            local hasSelect = table.count(checkTable(roleData)) > 0
            if hasSelect then
                KTool.SetActive(self.CommonBtnConsumePop, true)
                local consumeEnv = CfUtils.GetLuaScr(self.CommonBtnConsumePop, "Game.UI.Common.CommonBtnConsumePop")
                if consumeEnv then
                    consumeEnv:RefreshUI(self.trainConsumeId, self.trainConsumeNum, false)
                end
            end
            env:FreshBaseUI(roleData)
            env:SetBtnCallBack(function ()
                UIModule.OpenDialog({id = Constants.UITypeIds.UIFightTeamCardChoose, parameters = {chooseCardStatu = Constants.ChooseCardStatus.CatHouseTrain, catData = self.catData, catRolesData = self.rolesData}}, {
                    --{ id = Constants.UITypeIds.CatHouseMainDialog},
                    --{ id = Constants.UITypeIds.CatHouseInteractionDialog}
                })
                Events.Broadcast(Constants.EventNames.CatHouseCatTrainRolesSelectJump, true)
            end)
        end
        KTool.SetActive(go, true)
    end
end

function CatHouseInteractionTrain:OnDestroy()
    if self then
        self.isDestroyed = true
        Events.RemoveListener(Constants.EventNames.CatHouseCatTrainRolesSet, self.EventSetTrainCell)
        self.EventSetTrainCell = nil
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end
end

return CatHouseInteractionTrain