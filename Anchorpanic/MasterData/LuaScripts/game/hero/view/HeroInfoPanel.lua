module("hero.HeroInfoPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("hero/HeroInfoPanel.prefab")
destroyTime = -1 -- 自动销毁时间-1默认

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(52005))
    self:setBg("", false)
    self:setUICode(LinkCode.HeroCulture)

    self:setGuideTrans("guide_BtnClose_HeroInfoPanel", self.gBtnClose.transform)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mCurHeroId = nil
    -- 是否打开了相机截图预览
    self.mIsShowPreview = nil
end

function configUI(self)
    super.configUI(self)
    self.mModelClicker = self:getChildGO("mClickerArea")
    self.mModelPlayer = ModelScenePlayer.new()

    self.mBtnLast = self:getChildGO("mBtnLast")
    self.mBtnNext = self:getChildGO("mBtnNext")
    self.mGroupContent = self:getChildGO("mGroupContent")

    -- 左边区域
    self.mGoJob = self:getChildGO("mImgJob")
    self.mBtnHelper = self:getChildGO("mBtnHelper")
    
    self.mImgJob = self.mGoJob:GetComponent(ty.AutoRefImage)
    self.mTxtLvl_1 = self:getChildGO("mTxtLvl_1"):GetComponent(ty.Text)
    self.mTxtPower = self:getChildGO("mTxtPower"):GetComponent(ty.Text)
    self.mTxtHelper = self:getChildGO("TextHelper"):GetComponent(ty.Text)
    self.mTxtDefine = self:getChildGO("mTxtDefine"):GetComponent(ty.Text)
    self.mTxtHeroName = self:getChildGO("mTxtHeroName"):GetComponent(ty.Text)
    self.mImgHelper = self:getChildGO("ImgHelper"):GetComponent(ty.AutoRefImage)
    -- 右边区域
    self.mBtnLock = self:getChildGO("mBtnLock")
    self.mBtnLike = self:getChildGO("mBtnLike")
    self.mBtnSkill = self:getChildGO("mBtnSkill")
    self.mBtnEquip = self:getChildGO("mBtnEquip")
    self.mBtnCamera = self:getChildGO("mBtnCamera")
    self.mBtnDevelop = self:getChildGO("mBtnDevelop")
    self.mGoLikeSelect = self:getChildGO("GoLikeSelect")
    self.mBtnBracelets = self:getChildGO("mBtnBracelets")
    self.mGoLikeUnSelect = self:getChildGO("GoLikeUnSelect")
    self.mBtnEquipUnOpen = self:getChildGO("mBtnEquipUnOpen")
    self.mImgGoLockSelect = self:getChildGO("mImgGoLockSelect")
    self.mImgGoHasBracelets = self:getChildGO("mImgGoHasBracelets")
    self.mImgGoLockUnSelect = self:getChildGO("mImgGoLockUnSelect")
    self.mImgGoUnHasBracelets = self:getChildGO("mImgGoUnHasBracelets")
    self.mBtnCamera:SetActive(false)

    -- 相机预览区域
    self.mImgCurStar = self:getChildGO("mImgCurStar")
    self.mGroupCamera = self:getChildGO("mGroupCamera")
    self.mGroupCurStar = self:getChildTrans("mGroupCurStar")
    self.mTxtId = self:getChildGO("mTxtId"):GetComponent(ty.Text)
    self.mTxtLvl_2 = self:getChildGO("mTxtLvl_2"):GetComponent(ty.Text)
    self.mEleImg = self:getChildGO("mEleImg"):GetComponent(ty.AutoRefImage)
    self.mTxtLvlTitle = self:getChildGO("mTxtLvlTitle"):GetComponent(ty.Text)
    -- 特效
    self.mEffectNode = self:getChildTrans("mImg_2")
    self.mBtnRecord = self:getChildGO("mBtnForRecord")
    if (not GameManager.IS_DEBUG) then
        self.mBtnRecord:SetActive(false)
    end
end

-- 玩家点击关闭
function onClickClose(self)
    if (self.mIsShowPreview) then
        self.mIsShowPreview = nil
        self:updateView(false)
    else
        self:playerClose()
        super.onClickClose(self)
    end
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    self:playerClose()
    super.onCloseAllCall(self)
end

function playerClose(self)
    self.mCurHeroId = nil
    self.mIsShowPreview = nil
end

function active(self, args)
    -- 此处确保尽快看到展示的场景
    Perset3dHandler:setupShowData(MainCityConst.ROLE_MODE_OVERVIEW, nil, nil, "")
    super.active(self, args)
    MoneyManager:setMoneyTidList()
    hero.HeroManager:addEventListener(hero.HeroManager.PANEL_SHOW_HERO_CHANGE, self.onUpdatePanelShowHeroHandler, self)
    hero.HeroManager:addEventListener(hero.HeroManager.UPDATE_FIELD_IS_LOCK, self.onUpdateHeroLockStateHandler, self)
    hero.HeroManager:addEventListener(hero.HeroManager.UPDATE_FIELD_IS_LIKE, self.onUpdateHeroLikeStateHandler, self)
    -- hero.HeroManager:addEventListener(hero.HeroManager.UPDATE_FIELD_COVENANT_HELPER, self.onUpdateConnectHelperHandler, self)
    hero.HeroFlagManager:addEventListener(hero.HeroFlagManager.FLAG_UPDATE, self.onBubbleUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.HERO_DATA_UPDATE, self.onUpdateHeroDetailDataHandler, self)

    self.mCurHeroId = hero.HeroManager:getPanelShowHeroId()
    if (self.mCurHeroId ~= nil) then
        self:setData(self.mCurHeroId, false)
    else
        self:setData(args, true)
    end
    
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    hero.HeroManager:removeEventListener(hero.HeroManager.PANEL_SHOW_HERO_CHANGE, self.onUpdatePanelShowHeroHandler, self)
    hero.HeroManager:removeEventListener(hero.HeroManager.UPDATE_FIELD_IS_LOCK, self.onUpdateHeroLockStateHandler, self)
    hero.HeroManager:removeEventListener(hero.HeroManager.UPDATE_FIELD_IS_LIKE, self.onUpdateHeroLikeStateHandler, self)
    GameDispatcher:removeEventListener(EventName.HERO_DATA_UPDATE, self.onUpdateHeroDetailDataHandler, self)
    -- hero.HeroManager:removeEventListener(hero.HeroManager.UPDATE_FIELD_COVENANT_HELPER, self.onUpdateConnectHelperHandler, self)
    hero.HeroFlagManager:removeEventListener(hero.HeroFlagManager.FLAG_UPDATE, self.onBubbleUpdateHandler, self)
    self:recoverModel(true)
    self:clearStar()
    RedPointManager:remove(self.mBtnEquip.transform)
    RedPointManager:remove(self.mBtnDevelop.transform)
end

function clearStar(self)
    if (self.mStarItemList) then
        for i = 1, #self.mStarItemList do
            self.mStarItemList[i]:poolRecover()
        end
    end
    self.mStarItemList = {}
end

function initViewText(self)
    self:setBtnLabel(self.mBtnSkill, 1041, "技能")
    self.mTxtLvlTitle.text = _TT(1003) -- "等级"
    self.mTxtHelper.text = _TT(43508) -- "-战术助手"
    
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mGoJob, self.onClickJobHandler)
    self:addUIEvent(self.mBtnLock, self.onLockChangeHandler)
    self:addUIEvent(self.mBtnEquip, self.onClickEquipHandler)
    self:addUIEvent(self.mBtnCamera, self.onClickCameraHandler)
    self:addUIEvent(self.mBtnLast, self.onClickLastHeroHandler)
    self:addUIEvent(self.mBtnNext, self.onClickNextHeroHandler)
    self:addUIEvent(self.mBtnRecord, self.onClickRecordHandler)
    self:addUIEvent(self.mBtnSkill, self.onClickSkillTabHandler)
    self:addUIEvent(self.mBtnLike, self.onClickLikeChangeHandler)
    self:addUIEvent(self.mBtnDevelop, self.onClickDevelopHandler)
    self:addUIEvent(self.mBtnHelper, self.onClickBtnHelperHandler)
    self:addUIEvent(self.mBtnBracelets, self.onClickBraceletsHandler)
    self:addUIEvent(self.mBtnEquipUnOpen, self.onClickEquipUnOpenHandler)
end

function onClickSkillTabHandler(self)
    -- GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DEVELOP_PANEL, { heroId = self.mCurHeroId, tabType = hero.DevelopTabType.SKILL, subData = { type = 2 } })
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DEVELOP_PANEL, { heroId = self.mCurHeroId, tabType = hero.DevelopTabType.SKILL, subData = {} })
end

function onClickJobHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_JOB_PANEL, { heroId = self.mCurHeroId })
end

function onClickDevelopHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DEVELOP_PANEL, { heroId = self.mCurHeroId, tabType = nil })
end

function onClickEquipHandler(self)
    -- gs.Message.Show2("芯片")
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_EQUIP_PANEL, { heroId = self.mCurHeroId, tabType = nil })
end

function onClickEquipUnOpenHandler(self)
    funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_EQUIP, true)
end

function onClickBraceletsHandler(self)
    gs.Message.Show2(_TT(1335))
    -- GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DEVELOP_PANEL, { heroId = self.mCurHeroId, tabType = nil })
end

function onClickCameraHandler(self)
    self.mIsShowPreview = true
    self:updateView(false)
end

function onLockChangeHandler(self)

end

function onClickLikeChangeHandler(self)
    local heroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    local isLike = heroVo.isLike == 0 and 1 or 0
    GameDispatcher:dispatchEvent(EventName.REQ_HERO_LICK_CHANGE, { heroId = self.mCurHeroId, isLike = isLike })
end

-- 打开关联助手
function onClickBtnHelperHandler(self)
    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    if (curHeroVo.covanantHelperId ~= 0) then
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.CovenantGraduateSchool, param = { helperId = curHeroVo.covanantHelperId } })
    end
end

-- 点击切换查看前一个英雄
function onClickLastHeroHandler(self)
    local lastHeroId = hero.HeroManager:getPanelShowLastHeroId(self.mCurHeroId)
    if (lastHeroId) then
        hero.HeroManager:setPanelShowHeroId(lastHeroId)
    else
        print("不存在前一个英雄")
    end
end

-- 点击切换查看后一个英雄
function onClickNextHeroHandler(self)
    local nextHeroId = hero.HeroManager:getPanelShowNextHeroId(self.mCurHeroId)
    if (nextHeroId) then
        hero.HeroManager:setPanelShowHeroId(nextHeroId)
    else
        print("不存在后一个英雄")
    end
end

-- 当前查看的英雄改变
function onUpdatePanelShowHeroHandler(self)
    self:recoverModel(false)
    self.mCurHeroId = hero.HeroManager:getPanelShowHeroId()
    self:setData(self.mCurHeroId, true)
end

-- 当前查看的英雄详细数据更新
function onUpdateHeroDetailDataHandler(self, args)
    if (self.mCurHeroId == args.heroId) then
        self:setData(self.mCurHeroId, false)
    end
end

function onUpdateHeroLockStateHandler(self, args)
    if (args.heroId == self.mCurHeroId) then
        local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
        self:udpateLockState(curHeroVo)
    end
end

function onUpdateHeroLikeStateHandler(self, args)
    if (args.heroId == self.mCurHeroId) then
        local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
        self:udpateLikeState(curHeroVo)
    end
end

function onUpdateConnectHelperHandler(self, args)
    local heroId = args.heroId
    if (self.mCurHeroId == heroId) then
        self:updateConnectHelperView()
    end
end

function onBubbleUpdateHandler(self, args)
    local heroId = args.heroId
    if (heroId == self.mCurHeroId) then
        if (args.flagType == hero.HeroFlagManager.FLAG_BTN_DEVELOP) or (args.flagType == hero.HeroFlagManager.FLAG_CAN_WEAR_EQUIP) then
            self:updateBubbleView(args.flagType, args.isFlag)
        end
    end
end

function updateBubbleView(self, flagType, isFlag)
    if (not flagType and not isFlag) then

        if (hero.HeroFlagManager:getFlag(self.mCurHeroId, hero.HeroFlagManager.FLAG_BTN_DEVELOP)) then
            RedPointManager:add(self.mBtnDevelop.transform, nil, -162, 29.5)
        else
            RedPointManager:remove(self.mBtnDevelop.transform)
        end

        -- 芯片检查
        if (hero.HeroFlagManager:getFlag(self.mCurHeroId, hero.HeroFlagManager.FLAG_CAN_WEAR_EQUIP)) then
            RedPointManager:add(self.mBtnEquip.transform, nil, -14.5, 24)
        else
            RedPointManager:remove(self.mBtnEquip.transform)
        end
    else

        if flagType == hero.HeroFlagManager.FLAG_BTN_DEVELOP then
            if (isFlag) then
                RedPointManager:add(self.mBtnDevelop.transform, nil, -162, 29.5)
            else
                RedPointManager:remove(self.mBtnDevelop.transform)
            end
        elseif flagType == hero.HeroFlagManager.FLAG_CAN_WEAR_EQUIP then
            if (isFlag) then
                RedPointManager:add(self.mBtnEquip.transform, nil, -14.5, 24)
            else
                RedPointManager:remove(self.mBtnEquip.transform)
            end
        end
    end
end

function setData(self, cusHeroId, isInit)
    self.mCurHeroId = cusHeroId and cusHeroId or self.mCurHeroId
    local heroVo = hero.HeroManager:getHeroVo(cusHeroId)
    if (not heroVo) then
        logError("数据异常，测试赶紧重现下", "hero.HeroInfoPanel")
        return
    elseif (heroVo:checkIsPreData()) then
        return
    else
        self:updateView(isInit)
        self:updateBubbleView()
        self.mBtnLast:SetActive(hero.HeroManager:getPanelShowLastHeroId(self.mCurHeroId) ~= nil)
        self.mBtnNext:SetActive(hero.HeroManager:getPanelShowNextHeroId(self.mCurHeroId) ~= nil)
    end
end

-- 更新界面
function updateView(self, isInit)
    self:removeEffect()
    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    if (curHeroVo) then
        self:addEffect("fx_ui_hero_show_0" .. curHeroVo.color, self.mEffectNode, 0, 0, nil)
        self:clearStar()
        local curIntegers, curDecimals = math.modf(curHeroVo.evolutionLvl / 2)
        for i = 1, curIntegers do
            local item = SimpleInsItem:create(self.mImgCurStar, self.mGroupCurStar, "HeroInfoPanelmImgCurStar")
            local img = item:getGo():GetComponent(ty.AutoRefImage)
            img:SetImg(UrlManager:getCommon5Path("common_0043.png"), false)
            table.insert(self.mStarItemList, item)
        end
        if (curDecimals > 0) then
            local item = SimpleInsItem:create(self.mImgCurStar, self.mGroupCurStar, "HeroInfoPanelmImgCurStar")
            local img = item:getGo():GetComponent(ty.AutoRefImage)
            img:SetImg(UrlManager:getCommon5Path("common_0050.png"), false)
            table.insert(self.mStarItemList, item)
        end

        self.mTxtLvl_1.text = "" .. curHeroVo.lvl
        self.mTxtHeroName.text = curHeroVo.name
        self.mTxtPower.text = string.format(_TT(1159), HtmlUtil:color(curHeroVo.power, "202226ff"))
        self.mImgJob:SetImg(UrlManager:getHeroJobSmallIconUrl(curHeroVo.professionType), false)
        self.mTxtDefine.text = hero.getDefineName(curHeroVo.defineType)

        self.mEleImg:SetImg(UrlManager:getHeroEleTypeIconUrl(curHeroVo.eleType), false)

        if curHeroVo.eleType == 0 then
            self.mEleImg.gameObject:SetActive(false)
        else
            self.mEleImg.gameObject:SetActive(true)
        end
        self.mTxtId.text = "111"
        self.mTxtLvl_2.text = curHeroVo.lvl

        if (not self.mModelPlayer:getModelTrans()) then
            self:updateModelView(curHeroVo)
        end
        self:udpateLockState(curHeroVo)
        self:udpateLikeState(curHeroVo)
        self:updateBraceletsState(curHeroVo)

        if (self.mIsShowPreview) then
            self.mGroupCamera:SetActive(true)
        else
            self.mGroupCamera:SetActive(false)
        end
        self:updateGuide()
    end

    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_EQUIP, false) then

        self.mBtnEquipUnOpen:SetActive(false)
        self.mBtnEquip:SetActive(true)
        -- self.mBtnEquip:GetComponent(ty.Button).
        -- self.mBtnEquip:GetComponent(ty.Button).interactable = true
    else
        self.mBtnEquipUnOpen:SetActive(true)
        self.mBtnEquip:SetActive(false)
        -- self.mBtnEquip:GetComponent(ty.Button).interactable = false
    end
    -- self.mBtnEquip:SetActive(funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_EQUIP, false))
    self.mBtnBracelets:SetActive(funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_BRACELETS, false))
end

-- 更新关联助手
function updateConnectHelperView(self)
    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    if (curHeroVo.covanantHelperId == 0) then
        self.mBtnHelper:SetActive(false)
    else
        self.mBtnHelper:SetActive(true)
        self.mImgHelper:SetImg(UrlManager:getHelperHeadIconUrl(900 + curHeroVo.covanantHelperId), false)
    end
end

function updateGuide(self)
    self:setGuideTrans("hero_info_btn_develop", self.mBtnDevelop.transform)
    local heroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    if heroVo.tid == 1110 then
        self:setGuideTrans("Equip_Load_1", self:getChildTrans("mBtnEquip"))
        self:setGuideTrans("Equip_BtnFavorable", self:getChildTrans("mBtnFavorable"))
    end
end

-- 更新模型
function updateModelView(self, heroVo)
    if (heroVo) then
        self.mModelPlayer:setData(heroVo.id, true, 1, true, MainCityConst.ROLE_MODE_OVERVIEW, "", self.mModelClicker, true, function()
        end)
    else
        self:recoverModel(false)
    end
end

function recoverModel(self, isResetMaincity)
    self.mModelPlayer:reset(isResetMaincity)
end

-- 更新锁定状态
function udpateLockState(self, curHeroVo)
    self.mImgGoLockUnSelect:SetActive(curHeroVo.isLock ~= 1)
    self.mImgGoLockSelect:SetActive(curHeroVo.isLock == 1)
end

-- 更新喜欢状态
function udpateLikeState(self, curHeroVo)
    self.mGoLikeUnSelect:SetActive(curHeroVo.isLike ~= 1)
    self.mGoLikeSelect:SetActive(curHeroVo.isLike == 1)
end

-- 更新手环状态
function updateBraceletsState(self, curHeroVo)
    local equipVo = curHeroVo:getEquipByPos(PropsEquipSubType.SLOT_7)
    self.mImgGoHasBracelets:SetActive(equipVo ~= nil)
    self.mImgGoUnHasBracelets:SetActive(equipVo == nil)
end

function onClickRecordHandler(self)
    if (self.mIsRecord == nil or self.mIsRecord == false) then
        self.mIsRecord = true
        self.mModelPlayer:setShowType(MainCityConst.ROLE_MODE_OVERVIEW, UrlManager:getBgPath("common/common_record_bg.jpg"))
    else
        self.mIsRecord = false
        self.mModelPlayer:setShowType(MainCityConst.ROLE_MODE_OVERVIEW, "")
    end
    self.mBtnLast:SetActive(not self.mIsRecord)
    self.mBtnNext:SetActive(not self.mIsRecord)
    self.gBtnClose:SetActive(not self.mIsRecord)
    self.gBtnCloseAll:SetActive(not self.mIsRecord)
    self.mGroupContent:SetActive(not self.mIsRecord)
    self:getChildGO("mBtnForRecord"):GetComponent(ty.CanvasGroup).alpha = self.mIsRecord and 0 or 1
    gm.GmManager:dispatchEvent(gm.GmManager.EVENT_VISIBLE_CHANGE, not self.mIsRecord)
    debugFrames.FPS:dispatchEvent(debugFrames.FPS.EVENT_VISIBLE_CHANGE, not self.mIsRecord)
    GameView.msg:Find("TextDevelopment").gameObject:SetActive(not self.mIsRecord)
end

-- 更新战员档案信息
function updateDetailsInfo(self, curHeroVo)

end
return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1335):	"手环"
]]