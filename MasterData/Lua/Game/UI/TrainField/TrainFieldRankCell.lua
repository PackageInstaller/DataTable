---
--- Created by Eric.
--- DateTime: 2022/2/22 14:02
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
------------ import ------------

------------ define ------------

------------ define ------------


--- from: Assets/BundleResources/Prefabs/TrainField/TrainFieldRankDialog.prefab
---@class TrainFieldRankCell
---@field Env                           	TrainFieldRankCell
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field TextRound                     	TMPro.TextMeshProUGUI
---@field ImgMySelf                     	UnityEngine.RectTransform
---@field BtnCheck                      	UnityEngine.RectTransform
---@field TextDamageTotal               	TMPro.TextMeshProUGUI
---@field TextLevelNumber               	TMPro.TextMeshProUGUI
---@field TextName                      	UnityEngine.UI.Text
---@field CommonPlayerHeadNode          	Engine.Modules.LuaBehaviour
---@field TextNumber                    	TMPro.TextMeshProUGUI
---@field ImgRank2                      	Game.Native.Common.UISwitchImage
---@field ImgRank                       	Game.Native.Common.UISwitchImage
local TrainFieldRankCell = Class("TrainFieldRankCell")
function TrainFieldRankCell:__init()
    self.btnAction = nil

end

function TrainFieldRankCell:__delete()
    self.btnAction = nil

    self.controller = nil
end

-----SetCallBack
-----设置单击回调函数
--function TrainFieldRankCell:SetBtnCallBack(cb)
--    self.btnAction = cb
--end

function TrainFieldRankCell:Awake()
    if isNull(self.CommonPlayerHeadNode.Env) then
        self.CommonPlayerHeadNode:Init()
    end
    SetButtonAction(self.BtnCheck, function ()
        if type(self.btnAction) == 'function' then
            self.btnAction()
        end
    end)
end

function TrainFieldRankCell:FreshBaseUI(data)
    --printInfo("data-->>"..table.dump(data))
    data.order = checkNumber(data.order)
    data.score = checkNumber(data.score)
    local status = data.order <= 3 and data.order or 4
    local hasTeam = (not isNull(data.team)) and table.count(data.team) > 0
    if not isNull(self.ImgMySelf) then
        KTool.SetActive(self.ImgMyself, checkNumber(data.playerId) == checkNumber(GameUtils.GetPlayerId()))
    end
    CfUtils.SetUISwitchText(self.TextNumber.transform, status)
    self.ImgRank.Status = status
    if self.ImgRank2 then
        self.ImgRank2.Status = status
    end
    if data.score > 0 then
        self.TextNumber.text = data.order
    end
    self.CommonPlayerHeadNode.Env:FreshAvatarFrame(data.avatar, data.avatarFrame)
    self.TextName.text = data.name
    self.TextLevelNumber.text = localize("Lv._num_", {_num_ = data.level})
    self.TextDamageTotal.text = data.score
    self.TextRound.text = data.rounds
    self.btnAction = function()
        local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
        GameUtils.ShowCommonTeamsTipsBoard(self.BtnCheck.gameObject, data.team, nil, data.questId, data.name)
    end
end

function TrainFieldRankCell:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return TrainFieldRankCell