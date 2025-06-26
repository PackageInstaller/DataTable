--[[ 
-----------------------------------------------------
@filename       : HeroEquipItem
@Description    : 新装备格子（安装、培养界面用）
@date           : 2022-08-11 11:29:50
@Author         : Jacob
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("hero.HeroEquipItem", Class.impl(BaseGrid))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("commonGrid/EquipGrid.prefab")


--构造函数
function ctor(self)
    super.ctor(self)
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
    -- 拥有数量
    self.mHasCount = 0
    -- 需要数量
    self.mNeedCount = 0

end

function configUI(self)
    -- 基础
    self.mImgColorBg = self:getChildGO("mImgColorBg"):GetComponent(ty.AutoRefImage)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    -- 归属战员
    self.mGroupHero = self:getChildGO("mGroupHero")
    self.mImgHeroIcon = self:getChildGO("mImgHeroIcon"):GetComponent(ty.AutoRefImage)

    -- 锁住
    self.mImgLock = self:getChildGO("mImgLock"):GetComponent(ty.AutoRefImage)
    -- 新的标识
    self.mImgNew = self:getChildGO("mImgNew")

    -- 强化等级
    self.mTxtLvl = self:getChildGO("mTxtLvl"):GetComponent(ty.Text)

    -- 改造
    self.mGroupRemake = self:getChildGO("mGroupRemake")
    self.mGroupBottom = self:getChildGO("mGroupBottom")
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)

    --self.mImgColorBg.raycastTarget = true

    if self.mPropsVo then
        self.mPropsVo:removeEventListener(self.mPropsVo.UPDATE_EQUIP_DETAIL_DATA, self.updateData, self)
    end
    GameDispatcher:removeEventListener(EventName.HERO_LIST_INIT, self.updateHeroIcon, self)

    if (self.mEndTimeloopSn) then
        self:removeTimerByIndex(self.mEndTimeloopSn)
        self.mEndTimeloopSn = nil
    end
end


--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    super.addAllUIEvent(self)
end

-- 设置数据
function setData(self, cusData, cusParent)
    self:setParentTrans(cusParent)
    self.mPropsVo = cusData

    self.mPropsVo:addEventListener(self.mPropsVo.UPDATE_EQUIP_DETAIL_DATA, self.updateData, self)
    self:updateData()
end

function getData(self)
    return self.mPropsVo
end

-- 更新数据
function updateData(self)
    super.updateData(self)

    self:updateName()
    self:updateColorBg()
    self:updatePropsIcon()
    self:updateCount()

    self:updateLockState()
    self:updateEquipRemakeIcon()
    self:updateSlotBg()
    self:updateIsNew()
    self:updateHeroIcon()
    self:updateEquipStrengthenLvl()
end



-- 点击触发
function onClickHandler(self)
    if (self.mCallFun and self.mCallObj) then
        -- 调用外部处理
        if self.mParams then
            self.mCallFun(self.mCallObj, self.mPropsVo, unpack(self.mParams))
        else
            self.mCallFun(self.mCallObj, self.mPropsVo)
        end
    else
        -- 内部默认处理
        self:onDefaultClickHandler()
    end
end

function onDefaultClickHandler()
    TipsFactory:equipTips(self.mPropsVo, { tips.EquipTips.BtnType.BUILD_EQUIP, tips.EquipTips.BtnType.UNLOAD_EQUIP }, { rectTransform = self:getIconRect() }, false)
end

------------------------------------------------------------------------
-- 设置自定义道具名
function setName(self, cusName)
    self.mCustomName = cusName
    self:updateName()
end

-- 设置是否显示道具名
function setIsShowName(self, isShowName)
    self.mIsShowName = isShowName
    self:updateName()
end

-- 设置是否显示颜色背景状态
function setShowColorBgState(self, isShow)
    self.mIsShowColorBg = isShow
    self:updateColorBg()
end

-- 设置战员归属显示
function setShowHeroIcon(self, isShow)
    self.mIsShowHeroIcon = isShow
    self:updateHeroIcon()
end

-- 设置强化等级
function setShowEquipStrengthenLvl(self, isShow)
    self.mIsShowEquipStrengthenLvl = isShow
    self:updateEquipStrengthenLvl()
end

----------------------------------------------------------------------

-- 设置道具名
function updateName(self)
    if (self.mIsShowName == true) then
        self.mTxtName.gameObject:SetActive(true)
        if (self.mCustomName == nil) then
            self.mTxtName.text = self.mPropsVo:getName()
        else
            self.mTxtName.text = self.mCustomName
        end
    else
        self.mTxtName.gameObject:SetActive(false)
    end

end

-- 更新道具图标
function updatePropsIcon(self)
    self.mImgIcon:SetImg(UrlManager:getPropsIconUrl(self.mPropsVo.tid), true)
end

-- 更新背景图
function updateColorBg(self)
    if self.mIsShowColorBg then
        if self.mPropsVo.type == PropsType.EQUIP then
            self.mImgColorBg:SetImg(UrlManager:getEquipBgUrl(self.mPropsVo.color), false)
        elseif self.mPropsVo.type == PropsType.ORDER then
            self.mImgColorBg:SetImg(UrlManager:getOrderBgUrl(), false)
        else
            self.mImgColorBg:SetImg(UrlManager:getPropsBgUrl(self.mPropsVo.color), false)
        end
    end
    self.mImgColorBg.gameObject:SetActive(self.mIsShowColorBg)
end

-- 更新右下角数量
function updateCount(self)
    self.mGroupBottom:SetActive(false)
end

-- 更新 新 标识
function updateIsNew(self)
    self.isNew = false
    self.mImgNew:SetActive(self.isNew)
end

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
            local iconUrl =  UrlManager:getHeroBodyImgUrl(heroVo:getHeroModel())
            --UrlManager:getHeroHeadUrl(heroVo.tid)
            self.mImgHeroIcon:SetImg(iconUrl, false)
            self.mGroupHero:SetActive(true)
        end
    else
        self.mGroupHero:SetActive(false)
    end
end


-- 更新装备强化等级
function updateEquipStrengthenLvl(self)
    if self.mIsShowEquipStrengthenLvl ~= false then
        self.mTxtLvl.gameObject:SetActive(true)
        self.mTxtLvl.text = "LV." .. HtmlUtil:size(self.mPropsVo.strengthenLvl, 20)
    else
        self.mTxtLvl.gameObject:SetActive(false)
    end
end

-- 更新角标,显示部位
function updateSlotBg(self)
    self.mImgColor:SetImg(UrlManager:getEquipSlot(self.mPropsVo.subType), false)
end

-- 更新装备改造属性标识
function updateEquipRemakeIcon(self)
    local canRemakeCount = equipBuild.EquipRemakeManager:getRemakeCount(self.mPropsVo.tid)
    if (canRemakeCount > 0) then
        self.mGroupRemake:SetActive(true)
        local remakePosAttrList, remakePosAttrDic = self.mPropsVo:getRemakeAttr()
        if (remakePosAttrList and #remakePosAttrList > 0) then
            for i = 1, canRemakeCount do
                local color = ""
                local imgUrl = ""
                local attrData = remakePosAttrDic[i]
                local img = self:getChildGO("mImgRemake_" .. i):GetComponent(ty.AutoRefImage)
                if (attrData == nil) then
                    -- 灰
                    color = "474C50FF"
                    img:GetComponent(ty.CanvasGroup).alpha = 1
                else
                    local key = attrData.key
                    local value = attrData.value
                    local maxValue = attrData.maxValue
                    if (value >= maxValue) then
                        -- 蓝
                        color = "00F6FFFF"
                        img:GetComponent(ty.CanvasGroup).alpha = 1
                    else
                        -- 白
                        color = "474C50FF"
                        img:GetComponent(ty.CanvasGroup).alpha = 1
                    end
                end

                img.color = gs.ColorUtil.GetColor(color)
            end
        else
            self.mGroupRemake:SetActive(false)
        end
    else
        self.mGroupRemake:SetActive(false)
    end
end

-- 更新道具上锁状态
function updateLockState(self)
    self.mImgLock.gameObject:SetActive(false)
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]