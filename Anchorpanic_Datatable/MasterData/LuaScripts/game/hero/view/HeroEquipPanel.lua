module("hero.HeroEquipPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("hero/HeroEquipPanel.prefab")
-- panelType = 1 -- 窗口类型 1 全屏 2 弹窗
-- destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

-- 罗马数字
PropsEquipSubTypeStr = { "Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ", "Ⅵ" }

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(53601))
    self:setUICode(LinkCode.HomePage)
    self:setBg("", false)
end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.mCurHeroId = nil
    self.mSlotObjDic = nil
    self.mEquipSlotDic = {}
    self.mCurrentClickPos = nil
    self.mIsOpenEquipPlan = nil
    self.mMaxPos = 6

    self.mAttrDic = {}
    self.mSuitDic = {}
    self.isClick = false
end

function configUI(self)
    super.configUI(self)

    self.mBtnBackList = self:getChildGO("mBtnBackList")
    self.mHeroBgFrame = self:getChildGO("mHeroBgFrame")

    self.mBtnBackListIcon = self.mBtnBackList:GetComponent(ty.AutoRefImage)
    self.mImgHeroBar = self:getChildGO("mImgHeroBar"):GetComponent(ty.Image)
    self.mGroupSlot = self:getChildGO("mGroupSlot")
    self.mSlotObjDic = {}
    for pos = 1, self.mMaxPos do
        local go = self:getChildGO("NodeSlot_" .. pos)
        local imgSelected = go.transform:Find('ImgSelected').gameObject
        local bar = go.transform:Find("mImgBg_1/mImgBar"):GetComponent(ty.Image)
        self.mSlotObjDic['Slot_' .. pos] = { go = go, image = go:GetComponent(ty.AutoRefImage), imgSelected = imgSelected, bar = bar }
        go.transform:Find('ImgIdxTap/TextIdx'):GetComponent(ty.Text).text = PropsEquipSubTypeStr[pos]
    end

    self.mGroupAttr = self:getChildGO("mGroupAttr")
    self.mImgBg = self:getChildTrans("mImgBg")
    self.mBtnRayCast = self:getChildGO("mBtnRayCast")
    -------------------left---------------------------
    self.mClick = self:getChildGO("mClick")
    self.mBaseInfoGroup = self:getChildTrans("mBaseInfoGroup"):GetComponent(ty.RectTransform)
    self.mBtnAttrInfo = self:getChildGO("mBtnAttrInfo")
    self.mTupoContent = self:getChildTrans("mTupoContent")
    self.mTuPoAttrItem = self:getChildGO("mTuPoAttrItem")
    self.mTxtAddNull = self:getChildGO("mTxtAddNull")
    self.mTxtAddNull2 = self:getChildGO("mTxtAddNull2")
    self.mRemakeContent = self:getChildTrans("mRemakeContent")
    self.mRemakeItem = self:getChildGO("mRemakeItem")
    -------------------mid-------------------
    self.mMidGroup = self:getChildTrans("mMidGroup"):GetComponent(ty.RectTransform)
    self.mLeftMidNode = self:getChildTrans("mLeftMidNode")
    -------------------right-----------------
    self.mRightContent = self:getChildGO("mRightContent")
    self.mEmptySuitNode = self:getChildGO("mEmptySuitNode")
    self.mSuitContent = self:getChildTrans("mSuitContent")
    self.mSuitItem = self:getChildGO("mSuitItem")
    self.mContrastNode = self:getChildTrans("mContrastNode")
    self.mBtnOneKeyDressUp = self:getChildGO("mBtnOneKeyDressUp")
    self.mBtnOneKeyPutOff = self:getChildGO("mBtnOneKeyPutOff")
    self.mTxtEmpty2 = self:getChildGO("mTxtEmpty2"):GetComponent(ty.Text)

    self.mAnim = self.UIObject:GetComponent(ty.Animator)

    -- 模组方案
    self.mBtnEquipPlane = self:getChildGO("mBtnEquipPlane")
    self.mMatchEquipPlanTip = self:getChildGO("mMatchEquipPlanTip"):GetComponent(ty.Text)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self.mTxtAttrEmptyTip.text = _TT(62)
    self:setBtnLabel(self.mBtnOneKeyDressUp, 4379, "一键安装")
    self:setBtnLabel(self.mBtnEquipPlane, 1419, "模组方案")
    self.mTxtEmpty2.text = _TT(4385)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnBackList, self.onClickBackListHandler)
    self:addUIEvent(self.mBtnAttrInfo, self.onClickAttrInfoHandler)

    self:addUIEvent(self.mClick, self.onClickEmptyHandler)
    self:addUIEvent(self.mBtnEquipPlane, self.onClickEquipPlaneHandler)
    self:addUIEvent(self.mBtnOneKeyDressUp, self.onOneKeyDressUp)
    self:addUIEvent(self.mBtnOneKeyPutOff, self.onOneKeyPutOff)
    for pos = 1, self.mMaxPos do
        self:addUIEvent(self.mSlotObjDic['Slot_' .. pos].go, self.onClickSlotHandler, nil, pos, true)
    end
end

function active(self, args)
    super.active(self, args)
    -- 装备列表变更
    -- hero.HeroEquipManager:addEventListener(hero.HeroEquipManager.HERO_EQUIP_LIST_UPDATE, self.onEquipUpdateHandler, self)
    hero.HeroManager:addEventListener(hero.HeroManager.HERO_EQUIP_ALL_TOTAL_ATTR_UPDATE, self.onEquipUpdateHandler, self)
    -- 选择了装备子页签
    hero.HeroEquipManager:addEventListener(hero.HeroEquipManager.HERO_EQUIP_TAB_VIEW_SELECT_EQUIP, self.onEquipTabViewChangeHandler, self)
    hero.HeroEquipManager:addEventListener(hero.HeroEquipManager.HERO_EQUIP_MATERIAL_VIEW_SELECT_EQUIP, self.onMaterialSelectHandlerHandler, self)
    hero.HeroEquipManager:addEventListener(hero.HeroEquipManager.HERO_BAG_EQUIP_SELECT, self.onSelectEquipHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_BRACELETS_TIPS, self.updateInfoTips, self)
    GameDispatcher:addEventListener(EventName.UPDATE_HEAD_CHANGE, self.onHeadUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.HERO_DATA_UPDATE, self.onHeroDataUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_BRACELETS_CONTRAST_TIPS, self.updateEquipConstrast, self)
    GameDispatcher:addEventListener(EventName.CLOSE_BRACELETS_CONTRAST_TIPS, self.onCloseEquipConstrastHandler, self)
    GameDispatcher:addEventListener(EventName.CLICK_UNLOAD_EQUIP, self.__onClickOffHandler, self)

    MoneyManager:setMoneyTidList({})
    gs.RenderSettings.fog = false

    self:customEquipUpdate(true)

    self.mCurrentClickPos = hero.HeroEquipManager:getPos()
    if (self.mCurrentClickPos) then
        self:onClickSlotHandler(self.mCurrentClickPos, true, true)
    elseif (self.mIsOpenEquipPlan) then
        self.mIsOpenEquipPlan = nil
    else
        UISceneBgUtil:create3DBg("arts/sceneModule/ui_mozu_01/prefabs/ui_mozu_01.prefab")
        PostHandler:setBloomValue(gs.CameraMgr:GetDefSceneCameraTrans(), 0.61, nil, 4.6, 1.5, 0.7, 0.236)
        self.mAnim:SetTrigger("show")
    end
    self:updateGuide()

end

function close(self)
    super.close(self)
end

function onClickClose(self)
    super.onClickClose(self)
    self.mCurrentClickPos = nil
    self.mIsOpenEquipPlan = nil
    hero.HeroEquipManager:setPos(nil)

    if (self.isClick) then
        self:onClickEmptyHandler()
    end

    UISceneBgUtil:reset()
    PostHandler:resetBloomValue()
end
-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    super.onCloseAllCall(self)

    self.mCurrentClickPos = nil
    self.mIsOpenEquipPlan = nil
    hero.HeroEquipManager:setPos(nil)

    if (self.isClick) then
        self:onClickEmptyHandler()
    end

    UISceneBgUtil:reset()
    PostHandler:resetBloomValue()
end

function updateGuide(self)
    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    if curHeroVo.tid == 1110 then
        self:setGuideTrans("Equip_Load_2", self:getChildTrans("NodeSlot_1"))
        self:setGuideTrans("Equip_Load_5", self:getChildTrans("NodeSlot_2"))
    end
end

function deActive(self)
    if self.materialPanel then
        self.materialPanel:close()
    end

    for k, v in pairs(self.mSlotObjDic) do
        RedPointManager:remove(v.go.transform:Find("GridNode"))
    end
    self:clearAttrItem()
    self:clearSuitItem()
    self:clearEquipSlotItems()

    if self.equipContrast then
        self.equipContrast:close()
        self.equipContrast = nil
    end

    hero.HeroEquipManager:setPos(self.mCurrentClickPos)
    equipBuild.EquipBuildManager:setNowSelectEquip(nil)
    super.deActive(self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })

    hero.HeroManager:removeEventListener(hero.HeroManager.HERO_EQUIP_ALL_TOTAL_ATTR_UPDATE, self.onEquipUpdateHandler, self)
    -- hero.HeroEquipManager:removeEventListener(hero.HeroEquipManager.HERO_EQUIP_LIST_UPDATE, self.onEquipUpdateHandler, self)
    hero.HeroEquipManager:removeEventListener(hero.HeroEquipManager.HERO_EQUIP_TAB_VIEW_SELECT_EQUIP, self.onEquipTabViewChangeHandler, self)
    hero.HeroEquipManager:removeEventListener(hero.HeroEquipManager.HERO_EQUIP_MATERIAL_VIEW_SELECT_EQUIP, self.onMaterialSelectHandlerHandler, self)
    hero.HeroEquipManager:removeEventListener(hero.HeroEquipManager.HERO_BAG_EQUIP_SELECT, self.onSelectEquipHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_HEAD_CHANGE, self.onHeadUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.HERO_DATA_UPDATE, self.onHeroDataUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.OPEN_BRACELETS_CONTRAST_TIPS, self.updateEquipConstrast, self)
    GameDispatcher:removeEventListener(EventName.CLOSE_BRACELETS_CONTRAST_TIPS, self.onCloseEquipConstrastHandler, self)
    GameDispatcher:removeEventListener(EventName.CLICK_UNLOAD_EQUIP, self.__onClickOffHandler, self)
    GameDispatcher:removeEventListener(EventName.OPEN_BRACELETS_TIPS, self.updateInfoTips, self)
    RedPointManager:remove(self.mHeroBgFrame.transform)
end

function onSelectEquipHandler(self, args)
    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    local systemParam = sysParam.SysParamManager:getValue(921)[self.mCurrentClickPos]
    if curHeroVo.militaryRank < systemParam then
        gs.Message.Show(_TT(4365, systemParam))
        return
    end

    if self.equipContrast then
        self.equipContrast:close()
        self.equipContrast = nil
    end
    if (args.equipVo.heroId ~= 0) then
        -- 抢夺
        local heroVo = hero.HeroManager:getHeroVo(args.equipVo.heroId)
        UIFactory:alertMessge(_TT(1398, heroVo.name), true, function()
            --GameDispatcher:dispatchEvent(EventName.REQ_ABANDON_CYCLE)
            -- 抢夺
            GameDispatcher:dispatchEvent(EventName.REQ_HERO_ROB_EQUIP, { heroId = self.mCurHeroId, beRobbedEquipId = args.equipVo.id, beRobbedHeroId = args.equipVo.heroId })
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
    else
        -- 穿戴
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_ADD_EQUIP, { heroId = self.mCurHeroId, equipId = args.equipVo.id })
    end
end

-- 头像切换
function onHeadUpdateHandler(self)
    self:customEquipUpdate()
end

-- 战员数据更新
function onHeroDataUpdateHandler(self)
    self:customEquipUpdate()
end

--装备列表更新
function onEquipUpdateHandler(self)
    self:customEquipUpdate()
end

-- 变更了筛选页面的页签
function onEquipTabViewChangeHandler(self, args)
    self:onClickSlotHandler(args.index, true)
end

-- 一键穿戴
function onOneKeyDressUp(self)
    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)

    local max = 0
    for i = 1, 6 do
        local needRank = sysParam.SysParamManager:getValue(921)[i]
        if curHeroVo.militaryRank >= needRank then
            max = i
        end
    end

    local equipNum = 0
    for k, v in pairs(curHeroVo.equipList) do
        if v.subType < 7 then
            equipNum = equipNum + 1
        end
    end
    if equipNum >= max then
        gs.Message.Show(_TT(4380))
        return
    end

    local idList = {}
    local has = false
    for pos = 1, max do
        local equipVo = nil
        if (curHeroVo and curHeroVo.equipList) then
            for i = 1, #curHeroVo.equipList do
                if (curHeroVo.equipList[i].subType == pos) then
                    equipVo = curHeroVo.equipList[i]
                    break
                end
            end
        end
        if (equipVo == nil) then
            local equipList = bag.BagManager:getBagPagePropsList(bag.BagTabType.EQUIP, {equip.EquipSuitManager.All_SUIT_EQUIP_ID}, {pos}, nil, { isDescending = true, sortList = { bag.BagSortType.COLOR, bag.BagSortType.LVL, bag.BagSortType.REMAKE, bag.BagSortType.ID } }, bag.BagType.Equip)
            local index = 1
            for i = 1, #equipList do
                if equipList[i].heroId > 0 then
                    index = index + 1
                else
                    break
                end
            end

            if #equipList >= index then
                table.insert(idList, equipList[index].id)
            end
        end
    end

    if #idList >= 1 then
        -- self.mCurrentClickPos = 1
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_ADD_EQUIP, { heroId = self.mCurHeroId, equipId = idList })
        for i = 1, #idList do
            if read.ReadManager:isModuleRead(ReadConst.NEW_EQUIP, idList[i]) then
                GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = ReadConst.NEW_EQUIP, id = idList[i] })
            end
        end
    else
        gs.Message.Show(_TT(4382))
    end
end

-- 一键脱光
function onOneKeyPutOff(self)
    local putOff = function()
        self.mCurHeroId = hero.HeroManager:getPanelShowHeroId()
        local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
        local list = {}
        for pos = 1, 6 do
            local equipVo = nil
            if (curHeroVo and curHeroVo.equipList) then
                for i = 1, #curHeroVo.equipList do
                    if (curHeroVo.equipList[i].subType == pos) then
                        equipVo = curHeroVo.equipList[i]
                        break
                    end
                end
            end
            if (equipVo ~= nil) then
                table.insert(list, equipVo)
            end
        end

        -- self.mCurrentClickPos = 1
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_DEL_EQUIP, { equipVo = list, compatible = true })
    end
    UIFactory:alertMessge(_TT(4381), true, function()
        putOff()
    end, _TT(1), nil, true, function()
    end, _TT(2), _TT(5), nil, nil)
end

-- 点击空白处
function onClickEmptyHandler(self)
    if self.equipContrast then
        if self.equipContrast then
            self.equipContrast:close()
            self.equipContrast = nil
        end
        return
    end
    equipBuild.EquipBuildManager:setNowSelectEquip(nil)
    self.mCurrentClickPos = nil
    self:onClickSlotHandler(nil, false)
    -- self:updateGroup()
end

-- 打开模组方案界面
function onClickEquipPlaneHandler(self)
    local isAllSlotOpen = true
    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    for pos = 1, self.mMaxPos do
        local systemParam = sysParam.SysParamManager:getValue(921)[pos]
        if (curHeroVo.militaryRank < systemParam) then
            isAllSlotOpen = false
            break
        end
    end
    if (isAllSlotOpen) then
        self.mIsOpenEquipPlan = true
        GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_PLANE_PANEL, self.mCurHeroId)
    else
        gs.Message.Show(_TT(1401))
    end
end

--自定义更新操作
function customEquipUpdate(self, init)
    self:updateGroup(init)
    self:updateHeadInfo()
    self:updateSlotInfo()
    self:updateAttrAndSuitInfo()
    self:onClickSlotHandler(self.mCurrentClickPos, false, init)

    local matchEquipPlanVo = equipBuild.EquipPlanManager:getMatchHeroEquipPlan()
    if(matchEquipPlanVo)then
        self.mMatchEquipPlanTip.text = _TT(1412) .. ": " .. matchEquipPlanVo.name
    else
        self.mMatchEquipPlanTip.text = ""
    end
end

function updateGroup(self, init)
    if (not init) then
        if (self.mCurrentClickPos and not self.isClick) then
            TweenFactory:move2PosXEx(self.mBaseInfoGroup, -1093, 0.5)
            TweenFactory:move2LPosX(self.mMidGroup, -435, 0.5)
            self.isClick = true
        elseif not self.mCurrentClickPos and self.isClick then
            TweenFactory:move2PosXEx(self.mBaseInfoGroup, -476, 0.5)
            TweenFactory:move2LPosX(self.mMidGroup, 0, 0.5)
            if self.materialPanel then
                self.materialPanel:close()
            end
            self.isClick = false
        end
    end
    self.mRightContent:SetActive(not self.mCurrentClickPos)
end

function getMoveTo(self, value)
    local w, h = ScreenUtil:getScreenSize(nil)
    return w * (value / 1620)
end

-- 更新头像信息
function updateHeadInfo(self)
    self.mCurHeroId = hero.HeroManager:getPanelShowHeroId()
    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    equipBuild.EquipBuildManager:setHeroId(self.mCurHeroId)
    self.mBtnBackListIcon:SetImg(UrlManager:getHeroHeadInEquipByModel(curHeroVo:getHeroModel()), true)
    local color = "ff9e35ff"
    if curHeroVo.color == 2 then
        color = "2e95ffff"
    elseif curHeroVo.color == 3 then
        color = "ff72f1ff"
    end
    self.mImgHeroBar.color = gs.ColorUtil.GetColor(color)
    self:updateBackListBubble()
end

-- 更新位置信息
function updateSlotInfo(self)
    self:clearEquipSlotItems()

    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    local showPutOff = false
    -- local showBtnAuto = true
    for pos = 1, self.mMaxPos do
        local equipVo = nil
        local slotData = self.mSlotObjDic['Slot_' .. pos]

        local systemParam = sysParam.SysParamManager:getValue(921)[pos]
        slotData.go.transform:Find("NeedLvl/NeedLvlTxt"):GetComponent(ty.Text).text = _TT(1304, systemParam)
        slotData.go.transform:Find('NeedLvl').gameObject:SetActive(curHeroVo.militaryRank < systemParam)

        RedPointManager:remove(slotData.go.transform:Find("GridNode").transform)
        if (curHeroVo and curHeroVo.equipList) then
            for i = 1, #curHeroVo.equipList do
                if (curHeroVo.equipList[i].subType == pos) then
                    equipVo = curHeroVo.equipList[i]
                    break
                end
            end
        end
        if (equipVo) then
            local item = EquipGrid3:poolGet()
            item:setData(equipVo, slotData.go.transform:Find('GridNode').transform)
            item:setShowHeroIcon(false)
            item:setClickEnable(false)
            -- item:setPartScale(2)
            item:setIdxTap(false)
            self.mEquipSlotDic[pos] = item
            -- showBtnAuto = false
            showPutOff = true
            local color = ""
            if equipVo.color == 1 then
                color = "45cea2ff"
            elseif equipVo.color == 2 then
                color = "29acffff"
            elseif equipVo.color == 3 then
                color = "ff72f1ff"
            else
                color = "ff9e35ff"
            end
            slotData.bar.color = gs.ColorUtil.GetColor(color)
        else
            if (hero.HeroFlagManager:isHasEquipForPos(pos, curHeroVo)) then
                RedPointManager:add(slotData.go.transform:Find("GridNode").transform, nil, 57, 35)
            end
            slotData.bar.color = gs.ColorUtil.GetColor("90b1daff")
        end

        if not self.mEquipSlotDic[pos] and curHeroVo.militaryRank >= systemParam then
            slotData.go.transform:Find("mAddImg").gameObject:SetActive(true)
        else
            slotData.go.transform:Find("mAddImg").gameObject:SetActive(false)
        end
    end
    self.mBtnOneKeyPutOff:SetActive(showPutOff)
end

-- 更新属性和套装信息
function updateAttrAndSuitInfo(self)
    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    if curHeroVo:checkIsPreData() then
        return
    end
    if not curHeroVo.equipAttrDicAll then
        -- 请求英雄芯片属性数据
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_EQUIP_ALL_TOTAL_ATTR, { heroId = self.mCurHeroId })
        return
    end

    self:clearAttrItem()
    self:clearSuitItem()

    local showAttrList = { AttConst.ATTACK, AttConst.HP_MAX, AttConst.DEFENSE, AttConst.SPEED, AttConst.BASE_ATTACK_INC, AttConst.BASE_HP_INC, AttConst.DEFENSE_INC, AttConst.CRIT, AttConst.CRIT_DAMAGE }
    local showAttrData = {}
    showAttrData[AttConst.ATTACK] = { name = AttConst.getName(AttConst.ATTACK), iconImg = UrlManager:getAttrIconUrl(AttConst.ATTACK) }
    showAttrData[AttConst.HP_MAX] = { name = AttConst.getName(AttConst.HP_MAX), iconImg = UrlManager:getAttrIconUrl(AttConst.HP_MAX) }
    showAttrData[AttConst.DEFENSE] = { name = AttConst.getName(AttConst.DEFENSE), iconImg = UrlManager:getAttrIconUrl(AttConst.DEFENSE) }
    showAttrData[AttConst.SPEED] = { name = AttConst.getName(AttConst.SPEED), iconImg = UrlManager:getAttrIconUrl(AttConst.SPEED) }
    showAttrData[AttConst.BASE_ATTACK_INC] = { name = AttConst.getName(AttConst.BASE_ATTACK_INC), iconImg = UrlManager:getAttrIconUrl(AttConst.BASE_ATTACK_INC) }
    showAttrData[AttConst.BASE_HP_INC] = { name = AttConst.getName(AttConst.BASE_HP_INC), iconImg = UrlManager:getAttrIconUrl(AttConst.BASE_HP_INC) }
    showAttrData[AttConst.DEFENSE_INC] = { name = AttConst.getName(AttConst.DEFENSE_INC), iconImg = UrlManager:getAttrIconUrl(AttConst.DEFENSE_INC) }
    showAttrData[AttConst.CRIT] = { name = AttConst.getName(AttConst.CRIT), iconImg = UrlManager:getAttrIconUrl(AttConst.CRIT) }
    showAttrData[AttConst.CRIT_DAMAGE] = { name = AttConst.getName(AttConst.CRIT_DAMAGE), iconImg = UrlManager:getAttrIconUrl(AttConst.CRIT_DAMAGE) }

    for i = 1, #showAttrList do
        local key = showAttrList[i]
        local value = curHeroVo.equipAttrDicAll[key]
        value = value and value or 0
        -- if value > 0 then
        local item = SimpleInsItem:create(self.mTuPoAttrItem, self.mTupoContent, "HeroEquipPanelAttrItem")

        item:getChildGO("mTxtLockInfo"):GetComponent(ty.Text).text = AttConst.getValueStr(key, value or 0)
        item:getChildGO("mTxtAttrDes"):GetComponent(ty.Text).text = showAttrData[key].name

        self.mAttrDic[i] = item
        -- end
    end

    self.mTxtAddNull:SetActive(#self.mAttrDic == 0)

    local suitIdDic = equip.EquipManager:getEquipSuitIdDic()
    local suitList = {}
    for suitId, equipTidDic in pairs(suitIdDic) do
        local count = 0
        for slotPos, item in pairs(self.mEquipSlotDic) do
            if (equipTidDic[item:getData().tid]) then
                count = count + 1
                if (count >= 4) then
                    break
                end
            end
        end
        local suitConfigVo = equip.EquipSuitManager:getEquipSuitConfigVo(suitId)
        if (suitConfigVo and count >= 2) then
            local skillVo = fight.SkillManager:getSkillRo(suitConfigVo.suitSkillId_2)
            table.insert(suitList, { name = suitConfigVo.name, count = 2, desc = skillVo:getDescTip() })
        end
        if (suitConfigVo and count >= 4 and suitConfigVo.suitSkillId_4 ~= 0) then
            local skillVo = fight.SkillManager:getSkillRo(suitConfigVo.suitSkillId_4)
            table.insert(suitList, { name = suitConfigVo.name, count = 4, desc = skillVo:getDescTip() })
        end
    end
    table.sort(suitList, function(v1, v2)
        if v1.count == v2.count then
            return true
        end
        return v1.count < v2.count
    end)
    for k, v in pairs(suitList) do
        self:addSuitItem(v.name, v.count, v.desc, v.name .. v.count)
    end
    self.mEmptySuitNode:SetActive(table.nums(self.mSuitDic) == 0)
end

function clearAttrItem(self)
    for id, item in pairs(self.mAttrDic) do
        item:poolRecover()
    end
    self.mAttrDic = {}
end

function clearSuitItem(self)
    for id, item in pairs(self.mSuitDic) do
        item:poolRecover()
    end
    self.mSuitDic = {}
end

function clearEquipSlotItems(self)
    for slotPos, item in pairs(self.mEquipSlotDic) do
        item:poolRecover()
    end
    self.mEquipSlotDic = {}
end

function addSuitItem(self, suitName, suitCount, suitSkillDes, name)
    local item = SimpleInsItem:create(self.mSuitItem, self.mSuitContent, "HeroEquipPanelSuitItem")
    local icon = item:getChildGO("mIconSuit"):GetComponent(ty.AutoRefImage)
    local name = item:getChildGO("mTxtSuitName"):GetComponent(ty.Text)
    name.text = suitName
    local suitMenu = item:getChildGO("MenuSuit")
    local suitMenu4 = item:getChildGO("MenuSuit4piece")
    suitMenu:SetActive(suitCount == 2)
    suitMenu4:SetActive(suitCount == 4)

    local suitCountTxt, des
    if suitCount == 2 then
        suitCountTxt = item:getChildGO("mTxtTitleSuit"):GetComponent(ty.Text)
        des = item:getChildGO("mTxtSuitDes"):GetComponent(ty.Text)
    else
        suitCountTxt = item:getChildGO("mTxtTitle4Suit"):GetComponent(ty.Text)
        des = item:getChildGO("mTxtSuit4Des"):GetComponent(ty.Text)
    end
    suitCountTxt.text = _TT(1305, suitCount)
    des.text = suitSkillDes
    self.mSuitDic[name] = item
end

-- 点击了装备格子 是否显示tipss
function onClickSlotHandler(self, pos, needShowTips, init)
    self.mCurrentClickPos = pos
    self:updateItemClick(init)

    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    local args = {}
    args.heroId = self.mCurHeroId
    args.slotPos = pos
    args.equipVo = nil

    args.needShowTips = needShowTips

    if self.mEquipSlotDic[pos] then
        local data = self.mEquipSlotDic[pos]:getData()
        args.equipVo = data
    end

    if (self.mCurrentClickPos) then
        if self.materialPanel == nil then
            self.materialPanel = hero.HeroEquipMaterialPanel.new()

            local function _onDestroyPanelHandler(self)
                self.materialPanel:removeEventListener(View.EVENT_VIEW_DESTROY, _onDestroyPanelHandler, self)
                self.materialPanel = nil
            end

            self.materialPanel:addEventListener(View.EVENT_VIEW_DESTROY, _onDestroyPanelHandler, self)
        end
        self.materialPanel:open()
        self.materialPanel:setData(args)
        if needShowTips then
            self.materialPanel:showTips()
        end
        --     equipBuild.EquipBuildManager:setNowSelectEquip(args.equipVo)

        --     -- if (not self.equipTips) then
        --     --     self.equipTips = equipBuild.EquipInfoTipsItem:poolGet()
        --     -- end
        --     -- self.equipTips:setData(args.equipVo)
        --     --self.equipTips:setParent(parent)

        --     --TipsFactory:equipTips(args.equipVo, nil, { rectTransform = nil }, true)
        -- else
        --     equipBuild.EquipBuildManager:setNowSelectEquip(nil)
        -- end
    end

    if args.equipVo ~= nil and needShowTips == nil then
        if read.ReadManager:isModuleRead(ReadConst.NEW_EQUIP, args.equipVo.id) then
            GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = ReadConst.NEW_EQUIP, id = args.equipVo.id })
        end
    end
end

function updateInfoTips(self, equipVo)
    if self.materialPanel then
        local nowEquip = self.mEquipSlotDic[self.mCurrentClickPos]

        self.materialPanel:updateInfoTips(nowEquip, equipVo)

        --self.materialPanel:__setTabIndex(self.mCurrentClickPos)
    end
end

--显示比对界面
function updateEquipConstrast(self, equipVo)
    if (equipVo) then
        self.equipContrast = TipsFactory:equipContrastTips2(self.mEquipSlotDic[self.mCurrentClickPos]:getData(), equipVo)
    end
end

function onCloseEquipConstrastHandler(self)
    if self.equipContrast then
        self.equipContrast:close()
        self.equipContrast = nil
    end
end

-- 更新装备格子点击状态
function updateItemClick(self, init)
    for i = 1, self.mMaxPos do
        self.mSlotObjDic['Slot_' .. i].imgSelected:SetActive(self.mCurrentClickPos == i)
    end
    self:updateGroup(init)
end

--红点
function updateBackListBubble(self)
    if (hero.HeroFlagManager:getAllFlagExceptHero(self.mCurHeroId, hero.HeroFlagManager.FLAG_CAN_WEAR_EQUIP)) then
        RedPointManager:add(self.mHeroBgFrame.transform, nil, -27, 16.5)
    else
        RedPointManager:remove(self.mHeroBgFrame.transform)
    end
end

-- 卸下和替换
function __onClickOffHandler(self)
    local nowSelect = equipBuild.EquipBuildManager:getNowSelectEquip()
    if self.mEquipSlotDic[self.mCurrentClickPos] and self.mEquipSlotDic[self.mCurrentClickPos]:getData() == nowSelect then
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_DEL_EQUIP, { equipVo = nowSelect }) -- 卸下
    else
        self:onSelectEquipHandler({ equipVo = nowSelect })  -- 穿戴
    end
    if self.equipContrast then
        self.equipContrast:close()
        self.equipContrast = nil
    end
end

-- 打开英雄选择界面
function onClickBackListHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_SHOW_SELECT_PANEL, { redType = hero.HeroFlagManager.FLAG_CAN_WEAR_EQUIP })
end

-- 打开属性查看界面
function onClickAttrInfoHandler(self)
    local heroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    if(heroVo)then
        GameDispatcher:dispatchEvent(EventName.OPEN_HERO_EQUIP_ATTR_LIST_PANEL, { heroVo = heroVo })
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]