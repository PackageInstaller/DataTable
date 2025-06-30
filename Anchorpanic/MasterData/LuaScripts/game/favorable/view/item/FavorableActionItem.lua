--[[ 
-----------------------------------------------------
@filename       : FavorableActionItem
@Description    : 战员档案动作item
@date           : 2021-08-20 15:47:15
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.favorable.view.item.FavorableActionItem', Class.impl(BaseReuseItem))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("favorable/item/FavorableActionItem.prefab")

EVENT_PLAYING = "EVENT_PLAYING"

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
    self.isPlaying = false
    self.isLock = true
    self.aniLoop = nil
    self.mIsAgain = false
end

-- 初始化
function configUI(self)
    self.mImgBg = self:getChildGO("mImgBg")
    self.mGroupLock = self:getChildGO("mGroupLock")
    self.mGroupActive = self:getChildGO("mGroupActive")
    self.DOTweenAni = self.UIObject:GetComponent(ty.UIDoTween)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtCondition = self:getChildGO("mTxtCondition"):GetComponent(ty.Text)
end

--激活
function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_FAVORABLE_ACTIONSTART, self.updateAcitionState, self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_FAVORABLE_ACTIONSTART, self.updateAcitionState, self)
    if self.tweenTimeSn then
        LoopManager:removeTimerByIndex(self.tweenTimeSn)
        self.tweenTimeSn = nil
    end
    self:reset()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mGroupActive, self.onClick)
end


function setData(self, cusParent, cusData, cusHeroId, cusHeroTid)
    self:setParentTrans(cusParent)
    self.data = cusData
    self.mTxtName.text = cusData:getTitle()
    self.mTxtCondition.text = _TT(41719, cusData.relationLv)
    -- gs.TransQuick:SizeDelta01(self.mImgPro, 0)

    self.heroVo = hero.HeroManager:getHeroVo(cusHeroId)

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
end

function onClick(self)
    if not self.isLock then
                
        if self.isPlaying then
            self.isPlaying = false
            -- gs.TransQuick:SizeDelta01(self.mImgPro, 0)
            self.mImgIcon:SetImg(UrlManager:getPackPath("heroFavorable/hero_favorable_26.png"), false)
        else
            self.isPlaying = true

            -- gs.TransQuick:SizeDelta01(self.mImgPro, 0)
            self.mImgIcon:SetImg(UrlManager:getPackPath("heroFavorable/hero_favorable_25.png"), false)
            self:dispatchEvent(self.EVENT_PLAYING, { item = self })
        end
        local finishAniCall = function()
            self:reset()
        end

        local startActionCall = function()
            local time = favorable.FavorableManager:getNowActionTime()
            if time <= 0 then
                self.mIsAgain = true
            else
                self.aniLoop = LoopManager:addTimer(time, 1, self, finishAniCall)
            end
        end
        GameDispatcher:dispatchEvent(EventName.HERO_FILES_SHOW_ACTION, { actName = self.data.action, cvId = self.data.cvId, state = self.isPlaying, startCall = startActionCall, finishCall = finishAniCall })
    end
end

function stopPlay(self)
    self:reset()
    GameDispatcher:dispatchEvent(EventName.HERO_FILES_SHOW_ACTION, { actName = self.data.action, cvId = self.data.cvId, state = self.isPlaying })
end

function reset(self)
    self.isPlaying = false
    if self.aniLoop then
        LoopManager:removeTimerByIndex(self.aniLoop)
        self.aniLoop = nil
    end
    if self.mAniLoop then
        LoopManager:removeTimerByIndex(self.mAniLoop)
        self.mAniLoop = nil
    end
    -- gs.TransQuick:SizeDelta01(self.mImgPro, 0)
    self.mImgIcon:SetImg(UrlManager:getPackPath("heroFavorable/hero_favorable_26.png"), false)
end

function updateAcitionState(self, name)
    if self.mIsAgain and (self.data.action == name) then
        self.mIsAgain = false
        local time = favorable.FavorableManager:getNowActionTime()
        self.mAniLoop = LoopManager:addTimer(time, 1, self, self.reset)
    end
end

function setLock(self, isLock)
    self.isLock = isLock
    self.mImgBg:SetActive(not isLock)
    self.mGroupLock:SetActive(isLock)
    self.mTxtName.color = isLock and gs.ColorUtil.GetColor("82898cff") or gs.ColorUtil.GetColor("202226ff")
    self.mImgIcon.color = isLock and gs.ColorUtil.GetColor("82898cff") or gs.ColorUtil.GetColor("202226ff")
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]