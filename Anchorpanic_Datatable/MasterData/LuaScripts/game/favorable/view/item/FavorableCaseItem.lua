--[[ 
-----------------------------------------------------
@filename       : FavorableCaseItem
@Description    : 战员档案秘闻item
@date           : 2021-08-25 11:54:31
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.favorable.view.item.FavorableCaseItem', Class.impl(BaseReuseItem))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("favorable/item/FavorableCaseItem.prefab")

EVENT_CHANGE = "EVENT_CHANGE"

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
    self.isSelect = false
    self.isLock = true
end

-- 初始化
function configUI(self)
    self.mImgBg = self:getChildGO("mImgBg")
    self.mImgRed = self:getChildGO("mImgRed")
    self.mImgLine = self:getChildGO("mImgLine")
    self.mImgReward = self:getChildGO("mImgReward")
    self.mImgSelect = self:getChildGO("mImgSelect")
    self.mImgUnLock = self:getChildGO("mImgUnLock")
    self.mGroupAward = self:getChildTrans("mGroupAward")
    self.mImgContentBg = self:getChildGO("mImgContentBg")
    self.DOTweenAni = self.UIObject:GetComponent(ty.UIDoTween)
    self.mTxtLock = self:getChildGO("mTxtLock"):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mLeftIcon = self:getChildGO("mLeftIcon"):GetComponent(ty.Image)
    self.mTxtContent = self:getChildGO("mTxtContent"):GetComponent(ty.Text)
    self.mTxtReciveTips = self:getChildGO("mTxtReciveTips"):GetComponent(ty.Text)
end

--激活
function active(self)
    super.active(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.FAVORABLE_REWARD_GAIN_UPDATE, self.onRewardGainUpdate, self)
    self:removeBubble()
    if self.propsGrid ~= nil then
        self.propsGrid:poolRecover()
        self.propsGrid = nil
    end
    if self.tweenTimeSn then
        LoopManager:removeTimerByIndex(self.tweenTimeSn)
        self.tweenTimeSn = nil
    end
    self.mImgSelect:SetActive(false)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mImgBg, self.onClick)
end

function onClick(self)
    if (not self:getIsGain()) and (not self.isLock) then
        self:onRewardClick()
        return
    end
    self:dispatchEvent(self.EVENT_CHANGE, self.data.id)
end

function onRewardClick(self)
    GameDispatcher:dispatchEvent(EventName.REQ_FAVORABLE_REWARD, { heroTid = self.heroTid, id = self.data.id })
end

function setData(self, cusParent, cusData, cusHeroId, cusHeroTid)
    self:setParentTrans(cusParent)
    self.data = cusData
    self.heroId = cusHeroId
    self.heroTid = cusHeroTid
    self.heroVo = hero.HeroManager:getHeroVo(self.heroId)
    self.mTxtTitle.text = cusData:getTitle()
    if self.propsGrid ~= nil then
        self.propsGrid:poolRecover()
        self.propsGrid = nil
    end
    self.propsGrid = PropsGrid:create(self.mGroupAward, cusData:rewardList()[1], 1)
    self.propsGrid:setCallBack(self, function()
        if (not self:getIsGain()) and (not self.isLock) then
            self:onRewardClick()
        else
            self.propsGrid:onDefaultClickHandler()
        end
    end)
    self:removeBubble()
    self:setActive(false)
    self.tweenTimeSn = LoopManager:addTimer(self.data.tweenId * 0.06, 0, self, function()
        self:setActive(true)
        self.DOTweenAni:BeginTween()
        LoopManager:removeTimerByIndex(self.tweenTimeSn)
        self.tweenTimeSn = nil
    end)

    if (self.heroVo) then
        self.favorableLevel = self.heroVo.favorableLevel or 0
        self:setLock(cusData.relationLv > self.favorableLevel)
    else
        self:setLock(true)
    end

    GameDispatcher:addEventListener(EventName.FAVORABLE_REWARD_GAIN_UPDATE, self.onRewardGainUpdate, self)
end

function setSelect(self, isSelect)
    self.isSelect = isSelect
    self.mImgSelect:SetActive(self.isSelect)
    if self.isSelect then
        GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DETAIL_DES_TIPS, { title = self.data:getTitle(), des = self.data:getDesc(), finishCall = function()
            self:setSelect(false)
        end })
    end
end

function setLock(self, isLock)
    self.isLock = isLock
    self.mImgLine:SetActive(false)
    self.mImgBg:SetActive(not isLock)
    self.mImgUnLock:SetActive(isLock)
    self.mImgContentBg:SetActive(isLock)
    self.mTxtTitle.color = isLock and gs.ColorUtil.GetColor("82898Cff") or gs.ColorUtil.GetColor("202226ff")
    self.mLeftIcon.color = isLock and gs.ColorUtil.GetColor("404548ff") or gs.ColorUtil.GetColor("ffffffff")
    local width = 330.6
    self.mTxtReciveTips.text = _TT(47012)
    self.mTxtReciveTips.gameObject:SetActive(not self:getIsGain())
    if self.propsGrid then
        self.propsGrid:setIsShowCanRec(false)
    end
    if isLock then
        self.mTxtLock.text = _TT(41719, self.data.relationLv)
    else
        if (self:getIsGain()) then
            if self.propsGrid ~= nil then
                self.propsGrid:poolRecover()
                self.propsGrid = nil
            end
            self.mImgLine:SetActive(true)
        else
            self.propsGrid:setIsShowCanRec(true)
            width = width - (self.mGroupAward.rect.width * self.mGroupAward.localScale.x) - 5
        end
    end
    local curStr = string.gsub(self.data:getDesc(), "\n", "　")
    local strlenth = string.len(curStr)
    local str = curStr
    if strlenth > 40 then
        local maxLen = (not self:getIsGain()) and 13 or 17
        str = string.omit(str, maxLen)
    end
    self.mTxtContent.text = str
    gs.TransQuick:SizeDelta01(self.mTxtContent.gameObject.transform, width)
end
-- 奖励领取更新
function onRewardGainUpdate(self, dataId)
    if self:getIsGain() then
        self:removeBubble()
        self:setLock(false)
    end
end

function getIsGain(self)
    if self.data:getTitle() == _TT(47011) then
        return true
    end
    return favorable.FavorableManager:checkCaseRewardGain(self.heroTid, self.data.id)
end

-- 加红点
function addBubble(self)
    RedPointManager:add(self.mImgBg.transform, nil, 230.5, 44)
end
-- 移除红点
function removeBubble(self)
    RedPointManager:remove(self.mImgBg.transform)
end

function poolRecover(self)
    super.poolRecover(self)
    if self.propsGrid ~= nil then
        self.propsGrid:poolRecover()
        self.propsGrid = nil
    end
    GameDispatcher:removeEventListener(EventName.FAVORABLE_REWARD_GAIN_UPDATE, self.onRewardGainUpdate, self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]