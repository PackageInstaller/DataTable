--[[ SetActive
-----------------------------------------------------
@filename       : ActivitySubscribeGift
@Description      关注领取奖励
@date           : 2023-06-23 
@Author         : tonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.activity.view.ActivitySubscribeGift', Class.impl(TabSubView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("activity/ActivitySubscribeGift.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1-- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mImgWeiBoBg_01 = self:getChildGO("mImgWeiBoBg_01"):GetComponent(ty.Image)
    self.mImgWeiBoBg_02 = self:getChildGO("mImgWeiBoBg_02"):GetComponent(ty.Image)
    self.mImgWechatBg_01 = self:getChildGO("mImgWechatBg_01"):GetComponent(ty.Image)
    self.mImgWechatBg_02 = self:getChildGO("mImgWechatBg_02"):GetComponent(ty.Image)
end

--激活
function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({})
    activity.ActitvityExtraManager:addEventListener(activity.ActitvityExtraManager.UPDATE_SUBCTRIBE_MSG, self.updateView, self)
    GameDispatcher:addEventListener(EventName.FIVE_RESET, self.onFiveReset, self)
    self:updateView(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })
    activity.ActitvityExtraManager:removeEventListener(activity.ActitvityExtraManager.UPDATE_SUBCTRIBE_MSG, self.updateView, self)
    GameDispatcher:removeEventListener(EventName.FIVE_RESET, self.onFiveReset, self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:setBtnLabel(self:getChildGO("mBtnRec_01"), 3, "领取")
    self:setBtnLabel(self:getChildGO("mBtnRec_02"), 3, "领取")
    self:setBtnLabel(self:getChildGO("mBtnSubscribe1"), 91001, "关注")
    self:setBtnLabel(self:getChildGO("mBtnSubscribe2"), 91001, "关注")
end


function addAllUIEvent(self)
    self:addUIEvent(self:getChildGO("mBtnSubscribe1"), function()
        local subcribeVo = activity.ActitvityExtraManager:getConfigVoById(1)
        sdk.SdkManager:jumpBrowserWebView(subcribeVo.url)
        activity.ActitvityExtraManager:sendSubscribeRequest(1)
    end)
    self:addUIEvent(self:getChildGO("mBtnSubscribe2"), function()
        GameDispatcher:dispatchEvent(EventName.OPEN_ACTIVITY_WECHAT)
    end)
    for i = 1, 2 do
        self:addUIEvent(self:getChildGO("mBtnRec_0" .. i), function()
            activity.ActitvityExtraManager:sendReceiveRequest(i)
        end)

    end

end

-- 更新 View 界面
function updateView(self)
    for idx, state in pairs(activity.ActitvityExtraManager.subscribeMsgDic) do
        self:getChildGO("mBtnSubscribe" .. idx):SetActive(state == 0)
        self:getChildGO("mBtnRec_0" .. idx):SetActive(state == 1)
        self:getChildGO("mBtnReceived" .. idx):SetActive(state == 2)
        if state == 2 then
            if idx == 1 then
                self.mImgWeiBoBg_01.color = gs.ColorUtil.GetColor("949494FF")
                self.mImgWeiBoBg_02.color = gs.ColorUtil.GetColor("9E9E9EFF")
            else
                self.mImgWechatBg_01.color = gs.ColorUtil.GetColor("949494FF")
                self.mImgWechatBg_02.color = gs.ColorUtil.GetColor("9E9E9EFF")
            end
        else
            if idx == 1 then
                self.mImgWeiBoBg_01.color = gs.ColorUtil.GetColor("FFFFFFFF")
                self.mImgWeiBoBg_02.color = gs.ColorUtil.GetColor("FFFFFFFF")
            else
                self.mImgWechatBg_01.color = gs.ColorUtil.GetColor("FFFFFFFF")
                self.mImgWechatBg_02.color = gs.ColorUtil.GetColor("FFFFFFFF")
            end
        end
    end
end

--五点重置
function onFiveReset(self)
    GameDispatcher:dispatchEvent(EventName.ACTIVITY_CLOSE)
end

return _M