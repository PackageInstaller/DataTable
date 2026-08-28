---
--- Created by Eric.
--- DateTime: 2022/6/11 17:50
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local MediumPTActivityComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.MediumPTActivityComponent)

------------ import ------------

------------ define ------------
local switchStatus = {
    Can = 2,
    Not = 1,
}
------------ define ------------


--- from: Assets/BundleResources/Prefabs/Common/CommonActivityListDialog.prefab
---@class CommonActivityListCell
---@field Env                           	CommonActivityListCell
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field Text                          	TMPro.TextMeshProUGUI
---@field Underway                      	UnityEngine.RectTransform
---@field Complete                      	UnityEngine.RectTransform
---@field FontStyleButton               	UnityEngine.RectTransform
---@field CommonGoodsList               	UnityEngine.RectTransform
---@field Fill                          	Game.Native.Common.UISwitchImage
---@field SliderComplete                	UnityEngine.UI.Slider
---@field TextDescribe                  	UnityEngine.UI.Text
---@field ImgIconActivity               	Engine.UI.RawImageAlterable
---@field ImgBar2                       	Game.Native.Common.UISwitchImage
---@field ImgBar                        	Game.Native.Common.UISwitchImage
local CommonActivityListCell = Class("CommonActivityListCell")
function CommonActivityListCell:__init()
    self.btnAction = nil

end

function CommonActivityListCell:__delete()
    self.btnAction = nil

    self.controller = nil
end

---SetCallBack
---设置单击回调函数
function CommonActivityListCell:SetBtnCallBack(cb)
    self.btnAction = cb
end

function CommonActivityListCell:Awake()
    SetButtonAction(self.FontStyleButton, function()
        if type(self.btnAction) == 'function' then
            self.btnAction()
        end
    end)
end

function CommonActivityListCell:FreshBaseUI(data)
    data.status = checkNumber(data.status)
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting2550, "MediumPTCumulativeRewardVo", data.id)
    local canGet = data.status == Constants.GetStatus.Can
    local hasGet = data.status == Constants.GetStatus.Has
    local notGet = data.status == Constants.GetStatus.Not
    self.ImgBar.Status = canGet and switchStatus.Can or switchStatus.Not
    self.ImgBar2.Status = canGet and switchStatus.Can or switchStatus.Not

    local activityConf = MediumPTActivityComponent.activityConf
    local currencyVo = GoodsConfMgr:GetGoodsVoById(activityConf.ptItem)
    self.ImgIconActivity:LoadSprite(currencyVo.photoPath)

    self.TextDescribe.text = localize("累计获得")
    local progress = MediumPTActivityComponent.rewardsPoint / vo.needNum
    self.SliderComplete.value = progress
    self.Fill.Status = canGet and switchStatus.Can or switchStatus.Not
    self.Text.text = string.format("<color=#545454><size=30>%d</size></color>/%d", MediumPTActivityComponent.rewardsPoint, vo.needNum)
    local rewardEnv = CfUtils.GetLuaScr(self.CommonGoodsList, "Game.Behaviours.CommonGoodsList")
    local rewards = parse_rewards(vo.reward, vo.rewardNum)
    rewardEnv:FreshBaseUI(rewards)

    KTool.SetActive(self.FontStyleButton, canGet)
    KTool.SetActive(self.Complete, hasGet)
    KTool.SetActive(self.Underway, notGet)
end


function CommonActivityListCell:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return CommonActivityListCell