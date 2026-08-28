---
--- Created by Eric.
--- DateTime: 2022/2/21 10:33
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule

------------ import ------------

------------ define ------------

------------ define ------------


---@class TrainFieldTestRecordCell
---@field BtnCheck                      	UnityEngine.RectTransform
---@field BtnNotes                      	UnityEngine.RectTransform
---@field TextResult                    	TMPro.TextMeshProUGUI
---@field TextDamageMax                 	TMPro.TextMeshProUGUI
---@field TextTotalDamage               	TMPro.TextMeshProUGUI
---@field TextTime                      	UnityEngine.UI.Text
---@field TextTitle                     	UnityEngine.UI.Text
---@field ImgIconMode                   	Engine.UI.RawImageAlterable
---@field AnimRoot                      	UnityEngine.RectTransform
local TrainFieldTestRecordCell = Class("TrainFieldTestRecordCell")
function TrainFieldTestRecordCell:__init()
    --self.btnAction = nil

end

function TrainFieldTestRecordCell:__delete()
    --self.btnAction = nil

    self.controller = nil
end

---SetCallBack
---设置单击回调函数
--function TrainFieldTestRecordCell:SetBtnCallBack(cb)
--    self.btnAction = cb
--end

function TrainFieldTestRecordCell:Awake()
    --KTool.GetOrAddComponent(self.controller.gameObject, typeof(UIEventProxy)).onPointerClick = function()
    --    if type(self.btnAction) == 'function' then
    --        self.btnAction()
    --    end
    --end
end

function TrainFieldTestRecordCell:FreshBaseUI(data)
    local questData = QuestConfMgr:GetInstance():GetQuestVoById(data.questId)
    self.ImgIconMode:LoadSprite(data.icon)
    self.TextTitle.text = questData.name
    self.TextTime.text = self:GetTimeDesc(data.combatTime)
    self.TextTotalDamage.text = data.score
    self.TextDamageMax.text = data.maxHurt
    self.TextResult.text = data.rounds
    SetButtonAction(self.BtnNotes, function ()
        UIModule.OpenDialog({ id = Constants.UITypeIds.BattleStatisticPopupDialog, parameters = { data = data.statistic } })
    end)
    SetButtonAction(self.BtnCheck, function ()
        local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
        local excludeDialogs = {
            { id = Constants.UITypeIds.TrainFieldChooseModeDialog },
            { id = Constants.UITypeIds.TrainFieldTestRecordDialog },
        }
        GameUtils.ShowCommonTeamsTipsBoard(self.BtnCheck.gameObject, data.team, '', data.questId, playerComponent.playerDojo.playerName, excludeDialogs)
    end)
end

---传入离线秒数，获取对应的描述
function TrainFieldTestRecordCell:GetTimeDesc(seconds)
    seconds = checkInt(seconds)
    local desc
    if seconds < 3600 then
        desc = localize("1小时内")
    elseif seconds < 86400 then
        desc = math.floor(seconds/3600)..localize("小时前")
    elseif seconds < 2592000 then
        desc = math.floor(seconds/86400)..localize("天前")
    elseif seconds < 7776000 then
        desc = math.floor(seconds/2592000)..localize("月前")
    elseif seconds >= 7776000 then
        desc = localize("3月以上")
    end
    return desc
end

function TrainFieldTestRecordCell:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return TrainFieldTestRecordCell