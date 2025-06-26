module("BraceletsGrid", Class.impl(EquipGrid))
--手环grid   128*155
-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("commonGrid/BraceletsGrid.prefab")

function configUI(self)
    super.configUI(self)

    self.mBraceletsBg = self:getChildGO("mBraceletsBg"):GetComponent(ty.AutoRefImage)
end

function active(self)
    super.active(self)
end

function initData(self)
    super.initData(self)
    -- 是否显示名字
    self.mIsShowName = nil
    -- 显示品质底图
    self.mIsShowColorBg = true
    -- 是否显示数量
    self.mIsShowCount = nil
    -- 数量文本颜色
    self.mCountTextColor = nil
    -- 是否显示tips
    self.mIsShowUseInTip = nil
    -- 是否显示"新"标识
    self.mIsShowNew = nil
    -- 拥有数量
    self.mHasCount = 0
    -- 需要数量
    self.mNeedCount = 0

    -- 是否显示等级
    self.mIsShowEquipStrengthenLvl = nil
    -- 是否显示锁
    self.mIsShowLock = true

    self.mIsShowHeroIcon = true

end
-- 设置数据
function setData(self, cusData, cusParent)
    --  super.setData(self,cusData, cusParent)
    self:setParentTrans(cusParent)
    self.mPropsVo = cusData

    if self.mPropsVo == nil then
        self:getChildGO("mContent"):SetActive(false)
        self:getChildGO("mEmpty"):SetActive(true)
        self:setIsShowName(false)
    else
        self:updateData()
        self:getChildGO("mContent"):SetActive(true)
        self:getChildGO("mEmpty"):SetActive(false)

        self.mPropsVo:addEventListener(props.PropsVo.UPDATE, self.updateData, self)
        self.mPropsVo:addEventListener(self.mPropsVo.UPDATE_EQUIP_DETAIL_DATA, self.updateData, self)
    end

end

function deActive(self)
    self.mImgColorBg.raycastTarget = true
    super.deActive(self)
    if self.mPropsVo then
        self.mPropsVo:removeEventListener(self.mPropsVo.UPDATE_EQUIP_DETAIL_DATA, self.updateData, self)
        self.mPropsVo:removeEventListener(props.PropsVo.UPDATE, self.updateData, self)
    end
    GameDispatcher:removeEventListener(EventName.HERO_LIST_INIT, self.updateHeroIcon, self)

    if (self.mEndTimeloopSn) then
        self:removeTimerByIndex(self.mEndTimeloopSn)
        self.mEndTimeloopSn = nil
    end
end

-- 更新道具上锁状态
function updateLockState(self)
    --super.updateLockState(self)
    self.mImgLock.gameObject:SetActive(self.mIsShowLock and self.mPropsVo.isLock == 1)
    if self.mPropsVo.isLock == 1 then
        GameDispatcher:dispatchEvent(EventName.UPDATE_EQUIP_LOCK, self.mPropsVo.id)
    end
end

-- -- 更新道具图标
-- function updatePropsIcon(self)
--     self.mImgIcon:SetImg(UrlManager:getBraceletIconUrl(self.mPropsVo.tid), false)
-- end


-- -- 更新背景图
-- function updateColorBg(self)
--     super.updateColorBg(self)
--     self.mBraceletsBg.color = gs.ColorUtil.GetColor(braceletBuild.getBracelectsColor(self.mPropsVo.color))
-- end

-- 更新所属战员icon
function updateHeroIcon(self)
    if not self.mIsShowHeroIcon then
        self.mGroupHero:SetActive(false)
        return
    end
    if self.mIsShowHeroIcon and self.mPropsVo.heroId > 0 then
        local heroVo = hero.HeroManager:getHeroVo(self.mPropsVo.heroId)
        if heroVo == nil then
            GameDispatcher:addEventListener(EventName.HERO_LIST_INIT, self.updateHeroIcon, self)
        else
            GameDispatcher:removeEventListener(EventName.HERO_LIST_INIT, self.updateHeroIcon, self)
            local iconUrl = UrlManager:getHeroHeadCircularByModel(heroVo:getHeroModel())
            self.mImgHeroIcon:SetImg(iconUrl, false)
            self.mGroupHero:SetActive(true)
        end
    else
        self.mGroupHero:SetActive(false)
    end
end

return _M