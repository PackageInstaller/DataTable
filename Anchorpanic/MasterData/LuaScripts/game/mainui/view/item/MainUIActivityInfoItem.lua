--[[ 
-----------------------------------------------------
@filename       : MainUIActivityInfoItem
@Description    : 主界面活动轮播信息
@date           : 2020-12-09 19:39:31
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.mainui.view.MainUIActivityInfoItem', Class.impl("lib.component.BaseContainer"))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("mainui/MainUIActivityInfoItem.prefab")

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
    self.mImgItem = self:getChildGO("mImgItem")
end

--激活
function active(self)
    super.active(self)
    self:addOnClick(self.mImgItem, self.onClick)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:removeOnClick(self.mImgItem, self.onClick)
end

function setData(self, cusParent, cusBillboardData)
    self:setParentTrans(cusParent)
    self.billboardData = cusBillboardData
    if self.billboardData then
        local sp = gs.ResMgr:LoadSprite(string.format("arts/ui/bg/billboard/billboard_bg_%d_har.jpg", self.billboardData.illustration))
        if not sp then
            -- logError(string.format("=========轮播id%s 没有提交和谐资源，和策划核对后补上", self.billboardData.illustration))
            logError(string.format("=========轮播id%s 没有提交和谐资源，和策划核对后补上", self.billboardData.illustration))
            self.mImgItem:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getBgPath("activityTarget/activity_bg_02.png")) -- 这里是故意设置错误图片，提示错误，需要注意错误。请勿删除代码
        else

            local url = (RefMgr:getSpecialConfig() and sdk.SdkManager:getIsChannelHarmonious()) and string.format("billboard/billboard_bg_%d_har.jpg", self.billboardData.illustration) or string.format("billboard/billboard_bg_%d.jpg", self.billboardData.illustration)

            self.mImgItem:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getBgPath(url))
        end
        self.mImgItem:SetActive(true)
    else
        self.mImgItem:SetActive(false)
    end
end

function onClick(self)
    if self.billboardData then
        GameDispatcher:dispatchEvent(EventName.ACTIVITY_CLICK_BROADCAST)
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = self.billboardData.uicode, param = self.billboardData.codeParam })
    end
end

-- 添加到父节点 cusSiblingIndex 添加显示层级
function addOnParent(self, cusSiblingIndex)
    if self.UIObject == nil then
        self.UIObject = gs.GOPoolMgr:Get(self.UIRes)
        if self.UIObject then
            self.UITrans = self.UIObject.transform
            self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(self.UIObject)
            self:configUI()
        end
    end

    super.addOnParent(self, cusSiblingIndex)
end

-- 更新红点
function updateBubble(self, isBubble)
    if (isBubble) then
        RedPointManager:add(self.UITrans, nil, 114, 25)
    else
        RedPointManager:remove(self.UITrans)
    end
end

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function poolRecover(self)
    self:updateBubble(false)
    if self.UIObject then
        gs.GOPoolMgr:Recover(self.UIObject, self.UIRes)
    end

    self.UIObject = nil
    self.UITrans = nil
    self.m_childGos = nil
    self.m_childTrans = nil
    self:__deActive()

    LuaPoolMgr:poolRecover(self)
end

function getWidth(self)
    return self.UITrans.rect.width
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]