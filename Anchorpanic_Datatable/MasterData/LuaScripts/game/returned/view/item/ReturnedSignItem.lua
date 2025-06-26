--[[ 
-----------------------------------------------------
@filename       : ReturnedSignItem
@Description    : 回归活动签到
@date           : 2023-11-01 14:13:54
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.returned.view.item.ReturnedSignItem', Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mImgItemNomal = self:getChildGO("mImgItemNomal")
    self.mImgItemCan = self:getChildGO("mImgItemCan")
    self.mImgReceive = self:getChildGO("mImgReceive")
    self.mImgDay = self:getChildGO("mImgDay"):GetComponent(ty.AutoRefImage)
    self.mImgProps = self:getChildGO("mImgProps"):GetComponent(ty.AutoRefImage)
    self.mTxtCount = self:getChildGO("mTxtCount"):GetComponent(ty.Text)
    self.mImgTips = self:getChildGO("mImgTips")
    self.mImgGet = self:getChildGO("mImgGet")
    self.mBtnClick = self:getChildGO("mBtnClick")
end

function setData(self, param)
    super.setData(self, param)

    self.mImgDay:SetImg(UrlManager:getPackPath(string.format("returned/Regression_%s.png", param.id)), true)
    self.mImgProps:SetImg(UrlManager:getPropsIconUrl(param.tid), false)
    self.mTxtCount.text = param.num

    local loginDay = returned.ReturnedManager.loginDay
    self.mImgTips:SetActive(param.id - loginDay == 1)

    local isReceive = self:getIsReceive()
    self.mImgItemNomal:SetActive(self:getData().id > loginDay or isReceive == true)
    self.mImgItemCan:SetActive(self:getData().id <= loginDay and isReceive == false)
    self.mImgReceive:SetActive(self:getData().id <= loginDay and isReceive == true)
end

--激活
function active(self)
    super.active(self)

end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClick, self.onClick)
end

function onClick(self)
    local loginDay = returned.ReturnedManager.loginDay
    local isReceive = self:getIsReceive()

    if isReceive or (self:getData().id > loginDay or isReceive == true) then
        local propsConfigVo = props.PropsManager:getPropsConfigVo(self:getData().tid)
        TipsFactory:propsTips({ propsVo = propsConfigVo }, { rectTransform = self.mImgProps.transform })
    else
        GameDispatcher:dispatchEvent(EventName.REQ_RETURNED_SIGN_GAIN, self:getData().id)
    end
end

-- 是否已领取
function getIsReceive(self)
    local isReceive = returned.ReturnedManager:getReturnedSignIsReceive(self:getData().id)
    return isReceive
end


return _M