--[[ 
-----------------------------------------------------
@filename       : FavorableVoiceItem
@Description    : 战员档案cvitem
@date           : 2021-08-20 15:47:15
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.favorable.view.item.FavorableVoiceItem', Class.impl(BaseReuseItem))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("favorable/item/FavorableVoiceItem.prefab")

EVENT_PLAYING = "EVENT_PLAYING"

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
    self.mCurProgress = 0.5
    self.voiceLoop = nil
end

-- 初始化
function configUI(self)
    self.mImgBg = self:getChildGO("mImgBg")
    self.mImgPro = self:getChildTrans("mImgPro")
    self.mImgPlayer = self:getChildGO("mImgPlayer")
    self.mGroupLock = self:getChildGO("mGroupLock")
    self.mGroupActive = self:getChildGO("mGroupActive")
    self.DOTweenAni = self.UIObject:GetComponent(ty.UIDoTween)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtCondition = self:getChildGO("mTxtCondition"):GetComponent(ty.Text)
    self.mImgProBg = self:getChildGO("mImgProBg"):GetComponent(ty.RectTransform)
end

--激活
function active(self)
    super.active(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    if self.tweenTimeSn then
        LoopManager:removeTimerByIndex(self.tweenTimeSn)
        self.tweenTimeSn = nil
    end
    self:stopPlay()
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mGroupActive, self.onClick)
end

function setData(self, cusParent, cusData, cusHeroId, cusHeroTid)
    self:setParentTrans(cusParent)
    self.data = cusData
    self.mTxtName.text = cusData:getTitle()
    if cusData.type == 0 then
        self.mTxtCondition.text = _TT(41719, cusData.relationLv)
    else
        local fashionConfigVo = fashion.FashionManager:getHeroFashionConfigVo(fashion.Type.CLOTHES, cusHeroTid, cusData.relationLv)
        self.mTxtCondition.text = _TT(41729, fashionConfigVo:getName())
    end
    gs.TransQuick:SizeDelta01(self.mImgPro, 0)
    self.heroVo = hero.HeroManager:getHeroVo(cusHeroId)
    self:setActive(false)
    self.tweenTimeSn = LoopManager:addTimer(self.data.tweenId * 0.06, 0, self, function()
        self:setActive(true)
        self.DOTweenAni:BeginTween()
        LoopManager:removeTimerByIndex(self.tweenTimeSn)
        self.tweenTimeSn = nil
    end)
    if (self.heroVo) then
        if cusData.type == 0 then
            self.favorableLevel = self.heroVo.favorableLevel or 0
            self:setLock(cusData.relationLv > self.favorableLevel)
        else
            local _, state = fashion.FashionManager:getHeroFashionVo(fashion.Type.CLOTHES, cusHeroId, cusData.relationLv)
            self:setLock(state == fashion.State.LOCK)
        end
    else
        self:setLock(true)
    end
end

function onClick(self)
    if not self.isLock then
        if self.mTween then
            self.mTween:Kill()
            self.mTween = nil
        end
        
        AudioManager:preloadCvByCvId(self.data.voiceId)

        if self.isPlaying then
            self.isPlaying = false
            -- gs.TransQuick:SizeDelta01(self.mImgPro, 0)
            self.mImgIcon:SetImg(UrlManager:getPackPath("heroFavorable/hero_favorable_26.png"))
        else
            self.isPlaying = true
            -- gs.TransQuick:SizeDelta01(self.mImgPro, 0)
            self.mImgIcon:SetImg(UrlManager:getPackPath("heroFavorable/hero_favorable_25.png"))
            self:dispatchEvent(self.EVENT_PLAYING, { item = self })
        end
        self.mImgPlayer:SetActive(self.isPlaying)

        local finishAniCall = function()
            favorable.FavorableManager:setNowVoiceTime(0)
            self:reset()
        end

        local startActionCall = function()
            local time = favorable.FavorableManager:getNowVoiceTime()
            -- self.mTime = math.floor(time)
            -- self.mCurProgress = 0.5
            if (time == 0) then
                self:reset()
                return
            end
            self.voiceLoop = LoopManager:addTimer(time, 1, self, finishAniCall)
        end
        GameDispatcher:dispatchEvent(EventName.HERO_FILES_SHOW_VOICE, { cvId = self.data.voiceId, state = self.isPlaying, startCall = startActionCall, finishCall = finishAniCall })
    end
end

function stopPlay(self)
    self:reset()
    GameDispatcher:dispatchEvent(EventName.HERO_FILES_SHOW_VOICE, { cvId = self.data.voiceId, state = self.isPlaying })
end

function reset(self)
    self.isPlaying = false
    if self.voiceLoop then
        LoopManager:removeTimerByIndex(self.voiceLoop)
        self.voiceLoop = nil
    end
    self.mImgPlayer:SetActive(false)
    gs.TransQuick:SizeDelta01(self.mImgPro, 0)
    self.mImgIcon:SetImg(UrlManager:getPackPath("heroFavorable/hero_favorable_26.png"))
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