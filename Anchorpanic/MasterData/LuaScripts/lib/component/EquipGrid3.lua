--[[ 
-----------------------------------------------------
@filename       : EquipGrid
@Description    : 新装备格子
@date           : 2022-08-10 15:13:30
@Author         : Jacob
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("EquipGrid3", Class.impl(BaseGrid))

UIRes = UrlManager:getUIPrefabPath("commonGrid/EquipGrid3.prefab")

-- 构造函数
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
    -- 是否显示"新"标识
    self.mIsShowNew = nil
    -- 拥有数量
    self.mHasCount = 0
    -- 需要数量
    self.mNeedCount = 0

    --是否显示等级
    self.mIsShowEquipStrengthenLvl = nil

    --是否显示装备索引位置
    self.mIsShowIdx = true
    -- 是否显示锁
    -- self.mShowLock = false
end

function configUI(self)
    -- 基础
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mImgColor = self:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage)
    --self.mImgColorBg = self:getChildGO("mImgColorBg"):GetComponent(ty.AutoRefImage)
    --self.mImgColorLine = self:getChildGO("mImgColorLine"):GetComponent(ty.AutoRefImage)
    -- 归属战员
    self.mGroupHero = self:getChildGO("mGroupHero")
    --self.mImgHeroIcon = self:getChildGO("mImgHeroIcon"):GetComponent(ty.AutoRefImage)

    -- 锁住
    --self.mImgLock = self:getChildGO("mImgLock"):GetComponent(ty.AutoRefImage)
    -- 新的标识
    self.mImgNew = self:getChildGO("mImgNew")

    -- 强化等级
    self.mTxtLvl = self:getChildGO("mTxtLvl"):GetComponent(ty.Text)
    self.mImgLvBg = self:getChildGO("mImgLvBg"):GetComponent(ty.Image)

    -- 改造
    self.mGroupRemake = self:getChildGO("mGroupRemake")
    self.mImgIdxTap = self:getChildGO("mImgIdxTap")
    self.mTxtIdx = self:getChildGO("mTxtIdx"):GetComponent(ty.Text)

    -- 精炼
    self.mGroupRefine = self:getChildGO("mGroupRefine")

    -- 右下角数量
    self.mGroupBottom = self:getChildGO("mGroupBottom")
    --self.mTxtCountRight = self:getChildGO("mTxtCountRight"):GetComponent(ty.Text)

    -- 倒计时
    self.mGroupEndTime = self:getChildGO("mGroupEndTime")
    --self.mTxtEndTime = self:getChildGO("mTxtEndTime"):GetComponent(ty.Text)

end

function getData(self)
    return self.mPropsVo
end
-- 设置是否可点击
function setClickEnable(self, cusClickEnable)
    self.mClickEnable = cusClickEnable
    self.mImgIcon.raycastTarget = cusClickEnable
    self:updateClickEnable()
end

function active(self)
    super.active(self)
end

function deActive(self)
    self.mImgIcon.raycastTarget = true
    super.deActive(self)


    if self.mPropsVo then
        self.mPropsVo:removeEventListener(self.mPropsVo.UPDATE_EQUIP_DETAIL_DATA, self.updateData, self)
    end
    GameDispatcher:removeEventListener(EventName.HERO_LIST_INIT, self.updateHeroIcon, self)

    if (self.mEndTimeloopSn) then
        self:removeTimerByIndex(self.mEndTimeloopSn)
        self.mEndTimeloopSn = nil
    end
    -- gs.TransQuick:Scale(self.mImgIcon.transform, 1, 1, 1)
    -- gs.TransQuick:Scale(self.mImgColor.transform, 1, 1, 1)
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

-- 更新数据
function updateData(self)
    super.updateData(self)

    self:updateName()
    self:updateColorBg()
    self:updatePropsIcon()
    self:updateEndTime()

    self:updateLockState()
    self:updateEquipRemakeIcon()
    self:updateIdxTap()
    self:updateIsNew()
    --self:updateHeroIcon()
    --self:updataBraceletsLv()
    self:updateEquipStrengthenLvl()
    self:updateShowIdx()
end

-- function setPartScale(self, scale)
--     if (scale ~= nil) then
--         gs.TransQuick:Scale(self.mImgIcon.transform, scale, scale, scale)
--         gs.TransQuick:Scale(self.mImgColor.transform, scale, scale, scale)
--     end
-- end

-- 创建道具格子新方法（通过不定参数，推荐）
function createByData(self, args)
    local parent = args.parent
    local tid = args.tid
    local num = args.num
    local scale = args.scale or 1
    local isTween = args.isTween or false
    local showUseInTip = args.showUseInTip or true

    local vo = props.PropsManager:getTypePropsVoByTid(tid)
    vo.count = num

    local item = self:poolGet()
    item:setData(vo, parent)
    item:setTween(isTween)
    item:setScale(scale)
    item:setIsShowUseInTip(showUseInTip)
    return item
end

-- 创建道具格子
function create(self, parent, cusData, cusScale, _, cusIsShowUseInTip)
    local vo = nil
    local item = self:poolGet()
    if (cusData.__cname ~= props.PropsVo.__cname and cusData.__cname ~= props.EquipVo.__cname and cusData.__cname ~= props.OrderVo.__cname) then
        if cusData.tid and cusData.num then
            vo = props.PropsManager:getTypePropsVoByTid(cusData.tid)
            vo.count = cusData.num
        else
            vo = props.PropsManager:getTypePropsVoByTid(cusData[1])
            vo.count = cusData[2]
        end
    else
        vo = cusData
        -- PropsVo和EquipVo兼容处理
        if ((vo.__cname == props.PropsVo.__cname and vo.type ~= PropsType.PROPS) or (vo.__cname == equip.EquipVo.__cname and vo.type ~= PropsType.EQUIP)) then
            local newVo = props.PropsManager:getTypePropsVoByTid(vo.tid)
            newVo.count = vo.count
            vo = newVo
        end
    end
    item:setData(vo, parent)
    item:setScale(cusScale)
    item:setIsShowUseInTip(cusIsShowUseInTip)
    return item
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

    if self.isNew then
        self:setIsNew(false) 
        GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = ReadConst.NEW_EQUIP, id = self.mPropsVo.id })
    end
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

-- 设置是否显示右下角数量
function setIsShowCount(self, isShowCount)
    self.mIsShowCount = isShowCount
    self:updateCount()
end

-- 设置物品数量文本颜色
function setCountTextColor(self, colorStr)
    self.mCountTextColor = colorStr
    self:updateCountTextColor()
end

-- 设置打开的tip是否显示使用按钮
function setIsShowUseInTip(self, isShowUseInTip)
    self.mIsShowUseInTip = isShowUseInTip
end

-- 设置战员归属显示
function setShowHeroIcon(self, isShow)
    --self.mIsShowHeroIcon = isShow
    --self:updateHeroIcon()
end

-- 设置锁定状态
function setShowLockState(self, isShowLock)
    self.mIsShowLock = isShowLock
    self:updateLockState()
end

-- 设置强化等级
function setShowEquipStrengthenLvl(self, isShow)
    self.mIsShowEquipStrengthenLvl = isShow
    self:updateEquipStrengthenLvl()
end

-- 设置 新 标识
function setIsNew(self, isShow)
    self.mIsShowNew = isShow
    self:updateIsNew()
end

--是否显示索引位置
function setIdxTap(self,isShow)
    self.mIsShowIdx = isShow
    self:updateShowIdx()
end

-- --设置是否显示锁
-- function setShowLock(self,isShow)
--     self.mShowLock = isShow
--     self:updateShowLock()
-- end

----------------------------------------------------------------------

-- 设置道具名

function updateShowIdx(self)
    self.mImgIdxTap:SetActive(self.mIsShowIdx) 
end

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
    self.mImgIcon:SetImg(UrlManager:getPropsIconUrl(self.mPropsVo.tid), false)
end

-- 更新背景图
function updateColorBg(self)
    if self.mIsShowColorBg then
        -- if self.mPropsVo.type == PropsType.EQUIP then
        --     self.mImgColorBg:SetImg(UrlManager:getEquipBgUrl(self.mPropsVo.color), false)
        -- elseif self.mPropsVo.type == PropsType.ORDER then
        --     self.mImgColorBg:SetImg(UrlManager:getOrderBgUrl(), false)
        -- else
        --     self.mImgColorBg:SetImg(UrlManager:getPropsBgUrl(self.mPropsVo.color), false)
        -- end
        --self.mImgColorLine.color = gs.ColorUtil.GetColor(ColorUtil:getPropLineColor(self.mPropsVo.color))
    end

    -- self.mImgColor:SetImg(UrlManager:getEquipQualityUrl(self.mPropsVo.color), false)
    --self.mImgColorBg.gameObject:SetActive(self.mIsShowColorBg)
    --self.mImgColorLine.gameObject:SetActive(self.mIsShowColorBg)
end

-- 更新右下角数量
function updateCount(self)
    if (self.mIsShowCount == nil or self.mIsShowCount == true) then
        if (self.mHasNum == nil and self.mNeedNum == nil) then
            local count = self.mPropsVo.count
            if (count ~= nil and count > 1) then
                self.mGroupBottom:SetActive(true)
                --self.mTxtCountRight.text = self.mPropsVo.count
            else
                self.mGroupBottom:SetActive(false)
            end
        else
            if (self.mHasNum == nil) then
                self.mHasNum = bag.BagManager:getPropsCountByTid(self.mPropsVo.tid)
            end
            if (self.mNeedNum == nil) then
                if (self.mHasNum > 1) then
                    self.mGroupBottom:SetActive(true)
                    --self.mTxtCountRight.text = self.mHasNum
                else
                    self.mGroupBottom:SetActive(false)
                end
            else
                self.mGroupBottom:SetActive(true)
                --self.mTxtCountRight.text = self.mHasNum .. "/" .. self.mNeedNum
                -- if (self.mHasNum >= self.mNeedNum) then
                --     self.mTxtCountRight.text = "<color=#05a11b>" .. self.mHasNum .. "</color>/" .. self.mNeedNum
                -- else
                --     self.mTxtCountRight.text = "<color=#d53529>" .. self.mHasNum .. "</color>/" .. self.mNeedNum
                -- end
            end
        end
        self:updateCountTextSize()
    else
        self.mGroupBottom:SetActive(false)
    end
end

-- 更新剩余时间
function updateEndTime(self)
    -- if (not self.mPropsVo.expiredTime or self.mPropsVo.expiredTime <= 0) then
    --     -- 非限时道具
    --     self.mGroupEndTime:SetActive(false)
    -- else
    --     self.mGroupEndTime:SetActive(true)

    --     if (self.mEndTimeloopSn) then
    --         self:removeTimerByIndex(self.mEndTimeloopSn)
    --         self.mEndTimeloopSn = nil
    --     end

    --     self.mEndTimeloopSn = self:addTimer(1, 0, self.onEndTimer)
    --     self:onEndTimer()
    -- end
end

-- 有效期计时器
function onEndTimer(self)
    -- local cdTime = self.mPropsVo.expiredTime - GameManager:getClientTime()
    -- if (cdTime <= 0) then
    --     -- 已过期
    --     self.mTxtEndTime.text = "已过期"
    --     if (self.mEndTimeloopSn) then
    --         self:removeTimerByIndex(self.mEndTimeloopSn)
    --         self.mEndTimeloopSn = nil
    --     end
    -- else
    --     -- 未过期
    --     self.mTxtEndTime.text = TimeUtil.getFormatTimeBySeconds_2(cdTime)
    -- end
end

-- 更新数量文本颜色
function updateCountTextColor(self)
    --self.mTxtCountRight.color = gs.ColorUtil.GetColor(self.mCountTextColor)
end

-- 更新字号
function updateCountTextSize(self)
    -- if (self.mTxtCountRight) then
    --     self.mScale = self.mScale or 1
    --     local scale = self.mScale
    --     if (0.85 < scale and scale <= 1) then
    --         self.mTxtCountRight.fontSize = 24
    --     elseif (0.65 < scale and scale <= 0.85) then
    --         self.mTxtCountRight.fontSize = 26
    --     elseif (scale <= 0.65) then
    --         self.mTxtCountRight.fontSize = 28
    --     end
    -- end
end

-- 更新 新 标识
function updateIsNew(self)
    self.isNew = read.ReadManager:isModuleRead(ReadConst.NEW_EQUIP, self.mPropsVo.id)
    if self.mIsShowNew ~= nil then
        self.mImgNew:SetActive(self.mIsShowNew)
        return
    end
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
            local iconUrl = UrlManager:getHeroHeadUrl(heroVo.tid)
            --self.mImgHeroIcon:SetImg(iconUrl, false)
            self.mGroupHero:SetActive(true)
        end
    else
        self.mGroupHero:SetActive(false)
    end
end

-- 更新装备强化等级
function updateEquipStrengthenLvl(self)
    if self.mIsShowEquipStrengthenLvl ~= false then
        self.mImgLvBg.gameObject:SetActive(true)
        self.mTxtLvl.gameObject:SetActive(true)
        if(not self.mPropsVo.strengthenLvl) then 
            self.mPropsVo.strengthenLvl = 1
        end
        self.mTxtLvl.text = "LV." .. self.mPropsVo.strengthenLvl
    else
        self.mImgLvBg.gameObject:SetActive(false)
        self.mTxtLvl.gameObject:SetActive(false)
    end
end

-- 更新角标,显示部位
function updateIdxTap(self)
    local str = PropsEquipSubTypeStr[self.mPropsVo.subType]
    if (str) then
        self.mTxtIdx.gameObject:SetActive(true)
        self.mTxtIdx.text = str
    else
        self.mTxtIdx.gameObject:SetActive(false)
    end
end

-- 更新装备改造属性标识
function updateEquipRemakeIcon(self)
    local canRemakeCount = equipBuild.EquipRemakeManager:getRemakeCount(self.mPropsVo.tid)
    local remakePosAttrList, remakePosAttrDic = self.mPropsVo:getRemakeAttr()

    if canRemakeCount <= 0 or table.nums(remakePosAttrDic) == 0 then
        self.m_childGos["mGroupRemake"]:SetActive(false)
        return
    end

    self.m_childGos["mGroupRemake"]:SetActive(true)
    for i = 1, canRemakeCount do
        local color = ""
        local attrData = remakePosAttrDic[i]
        local imgRemakeObj = self.m_childGos["mImgRemake_" .. i]

        if attrData == nil then
            -- 没有具体的内容 直接跳过
            imgRemakeObj:SetActive(false)
            break
        else
            imgRemakeObj:SetActive(true)
        end
        local img = imgRemakeObj:GetComponent(ty.AutoRefImage)

        local key = attrData.key
        local value = attrData.value
        local maxValue = attrData.maxValue
        if (value >= maxValue) then
            -- 蓝
            color = "FFFFFFFF"
        else
            -- 白
            color = "FFFFFFFF"
        end
        img.color = gs.ColorUtil.GetColor(color)
    end
end

-- 更新道具上锁状态
function updateLockState(self)
    if (self.mIsShowLock and self.mPropsVo.isLock == 1) then
        local color = nil
        if (self.mPropsVo.type == PropsType.EQUIP or self.mPropsVo.type == PropsType.ORDER) then
            color = "4e5870ff"
        else
            color = "2F3137ff"
        end
        --self.mImgLock.color = gs.ColorUtil.GetColor(color)
        --self.mImgLock.gameObject:SetActive(true)
    else
        --self.mImgLock.gameObject:SetActive(false)
    end
end

-- 设置显示精炼等级
function updataBraceletsLv(self)
    if (self.mPropsVo.bagType == bag.BagType.Bracelets) then
        self.mGroupRefine:SetActive(true)
        local refineLvl = self.mPropsVo.refineLvl
        local refineUpLimit = sysParam.SysParamManager:getValue(SysParamType.BRACELETS_UPPER_LIMIT)
        for i = 1, refineUpLimit do
            local img = self:getChildGO("mImgRefine" .. i):GetComponent(ty.AutoRefImage)
            if (i <= refineLvl) then
                img.color = gs.ColorUtil.GetColor("ff8400ff")
            else
                img.color = gs.ColorUtil.GetColor("82898cff")
            end
        end
    else
        self.mGroupRefine:SetActive(false)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]