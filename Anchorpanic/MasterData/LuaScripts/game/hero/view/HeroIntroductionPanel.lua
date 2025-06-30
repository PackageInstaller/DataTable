--[[ 
-----------------------------------------------------
@filename       : HeroIntroductionPanel
@Description    : 招募预览
@date           : 2023-04-28 2:43:13
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("hero.HeroIntroductionPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("hero/HeroIntroductionPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
isShowBlackBg = 0
isShowCloseAll = 0

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1280, 720)
    self:setTxtTitle("预览")
    self:setBg("")
end

-- 初始化数据
function initData(self)
    self.curHeroTid = nil
    self.mSkillList = {}
    self.mReuseItemList = {}
    self.mIsShow3D = true
end

function configUI(self)
    self.mGroup = self:getChildGO("mGroup")
    self.mModelPlayer = ModelScenePlayer.new()
    self.mModelNode = self:getChildGO("mModelNode")
    self.mBtnHideUI = self:getChildGO("mBtnHideUI")
    self.mBtnChange = self:getChildGO("mBtnChange")
    self.mImgReuseBg = self:getChildGO("mImgReuseBg")
    self.mClickerArea = self:getChildGO("mClickerArea")
    self.mAni = self.UIObject:GetComponent(ty.Animator)
    self.mBtnHeroInfo = self:getChildGO("mBtnHeroInfo")
    self.mGroupSkill = self:getChildTrans("mGroupSkill")
    self.mImgHeroPicBg = self:getChildGO("mImgHeroPicBg")
    self.mGroupTalent = self:getChildTrans("mGroupTalent")
    self.mEffectTrans = self:getChildTrans("mEffectTrans")
    self.mImgMassTrans = self:getChildTrans("mImgMassTrans")
    self.mBtnHeroUpGrade = self:getChildGO("mBtnHeroUpGrade")
    self.mGroupEleAndOcc = self:getChildTrans("mGroupEleAndOcc")
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtCvZh = self:getChildGO("mTxtCvZh"):GetComponent(ty.Text)
    self.mTxtCvJp = self:getChildGO("mTxtCvJp"):GetComponent(ty.Text)
    self.mTxtSkill = self:getChildGO("mTxtSkill"):GetComponent(ty.Text)
    self.mTxtTalent = self:getChildGO("mTxtTalent"):GetComponent(ty.Text)
    self.mImgHeroPic = self:getChildGO("mImgHeroPic"):GetComponent(ty.AutoRefImage)
    self.mImgHideChange = self:getChildGO("mImgHideChange"):GetComponent(ty.AutoRefImage)

    self.mIsLimit = self:getChildGO("mIsLimit")
end

function active(self, args)
    super.active(self, args)
    self.curCvImgNum = 0--当前关闭CV的图片后缀
    self.isShutView = 1--是否关闭页面  若关闭则为nil
    self.isShutCv = false
    self.isNoMass = args.isNoMass
    self.data = args
    MoneyManager:setMoneyTidList({})
    self:setData(args.heroId, args.heroTid)
    self.mImgHeroPicBg:SetActive(false)
    self.mBtnChange:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("heroFavorable/hero_favorable_34.png"), true)
end

function deActive(self)
    super.deActive(self)
    self.isShutView = nil
    self:recoverModel(true)
    self.mIsShow3D = true
    MoneyManager:setMoneyTidList()
end

function closeAll(self)
    if (bag.BagManager.mOpenHeroDetail) then
        GameDispatcher:dispatchEvent(EventName.CLOSE_SELECT_HERO_VIEW)
    end
    super.closeAll(self)
end

-- 玩家点击关闭
function onClickClose(self)
    if (bag.BagManager.mOpenHeroDetail) then
        GameDispatcher:dispatchEvent(EventName.DEACTIVE_SELECT_HERO_VIEW, true)
    end
    if self.data.closeCall then
        self.data.closeCall()
    end
    super.onClickClose(self)
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnChange, self.onChangeState)
    self:addUIEvent(self.mBtnHideUI, self.onClickHideHandler)
    self:addUIEvent(self.mBtnHeroUpGrade, self.onClickOpenUpGradeHandler)
    self:addUIEvent(self.mBtnHeroInfo, self.onClickOpenParticularsHandler)
end
--打开战员简介
function onClickOpenParticularsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_PARTICULARS_PANEL, self.data)
end

--打开战员升格
function onClickOpenUpGradeHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_UPGRADE_PANEL, self.data)
end

function onClickHideHandler(self)
    if self.mGroup.activeSelf == true then
        self.mAni:SetTrigger("show")
        self.mGroup:SetActive(false)
        self:setBtnLabel(self.mBtnHideUI, 281, "显示UI")
        self.mImgHideChange:SetImg(UrlManager:getPackPath("mainui/mainui_6.png"), true)
    else
        self.mAni:SetTrigger("exit")
        self.mGroup:SetActive(true)
        self:setBtnLabel(self.mBtnHideUI, 280, "隐藏UI")
        self.mImgHideChange:SetImg(UrlManager:getPackPath("mainui/mainui_7.png"), true)
    end
    self.base_childGos["mGroupTop"]:SetActive(self.mGroup.activeSelf == true)
end

function onChangeState(self)
    if self.mIsShow3D == false then
        self.mIsShow3D = true
        self.mImgHeroPicBg:SetActive(false)
        self.mBtnChange:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("heroFavorable/hero_favorable_34.png"), true)
    else
        self.mBtnChange:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("heroFavorable/hero_favorable_35.png"), true)
        self.mImgHeroPicBg:SetActive(true)
        self.mIsShow3D = false
    end
    if self.mIsShow3D then
        self:updateModelView(self.curHeroVo)
    else
        self:recoverModel(false)
    end
    -- end
end

function setData(self, cusHeroId, cusHeroTid)
    self.curHeroId = cusHeroId
    self.curHeroTid = cusHeroTid
    if (cusHeroId == nil) then
        self.curHeroVo = hero.HeroManager:getHeroConfigVo(self.curHeroTid)
    else
        self.curHeroVo = hero.HeroManager:getHeroVo(self.curHeroId)
    end
    self:updateView()
end

function updateView(self)
    self:removeAllSkillItem()
    self:removeReuseItemList()
    if (self.curHeroVo) then
        local heroVo = hero.HeroManager:getHeroConfigVo(self.curHeroTid)
        self.mTxtName.text = self.curHeroVo.name
        self.mIsLimit:SetActive(heroVo.isLimit==1)
        self.mTxtCvZh.text = _TT(1015, self.curHeroVo.zhCVName)--"中：" .. self.curHeroVo.zhCVName
        self.mTxtCvJp.text = _TT(1016, self.curHeroVo.jpCVName)--"日：" .. self.curHeroVo.jpCVName
        for i = 1, 3 do
            self:getChildGO("mImgQuality_" .. i):SetActive(heroVo.color - 1 == i)
        end
        if heroVo.professionType ~= nil then
            local occItem = SimpleInsItem:create(self.mImgReuseBg, self.mGroupEleAndOcc, "heroOccReuseItem")
            occItem:getChildGO("mIconReuse"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getMonsterJobSmallIconUrl(heroVo.professionType), true)
            occItem:getChildGO("mTxtReuse"):GetComponent(ty.Text).text = hero.getProfessionName(heroVo.professionType)
            occItem:addUIEvent(nil, function()
                TipsFactory:heroEleAndOccTips(1, occItem:getTrans())
            end)
            table.insert(self.mReuseItemList, occItem)
        end
        self.mImgHeroPic:SetImg(UrlManager:getBgPath(string.format("heroRecord/record_pic_%s.png", heroVo.showModel)))
        if heroVo.eleType ~= -1 then
            local eleItem = SimpleInsItem:create(self.mImgReuseBg, self.mGroupEleAndOcc, "heroEleReuseItem")
            eleItem:getChildGO("mIconReuse"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getHeroEleTypeIconUrl(heroVo.eleType), true)
            local color, txt = hero.getHeroTypeName(heroVo.eleType)
            eleItem:getChildGO("mTxtReuse"):GetComponent(ty.Text).text = HtmlUtil:color(txt, color)
            eleItem:addUIEvent(nil, function()
                TipsFactory:heroEleAndOccTips(2, eleItem:getTrans())
            end)
            table.insert(self.mReuseItemList, eleItem)
        end
        for _, skillID in ipairs(heroVo.baseSkillIdList) do
            local skillItem = SkillGrid:create(self.mGroupSkill, { skillId = skillID, heroVo = heroVo }, 1)
            skillItem:setDetailVisible(false)
            table.insert(self.mSkillList, skillItem)
        end
        for _, skillID in ipairs(heroVo.inBornSkill) do
            local skillItem = SkillGrid:create(self.mGroupTalent, { skillId = skillID, heroVo = heroVo }, 1)
            skillItem:setDetailVisible(false)
            table.insert(self.mSkillList, skillItem)
        end
        self:updateModelView(heroVo)
    end
end

function updateModelView(self, heroVo)
    if (heroVo) then
        self.mModelPlayer:setModelData(heroVo:getUIModel(), false, true, 1, true, MainCityConst.ROLE_MODE_OVERVIEW, UrlManager:getBgPath("hero5/details_bg_02.jpg"), self.mClickerArea, true, function()
        end)
    else
        self:recoverModel(false)
    end
end

function recoverModel(self, isResetMaincity)
    self.mModelPlayer:reset(isResetMaincity)
end

function removeReuseItemList(self)
    if #self.mReuseItemList > 0 then
        for _, item in ipairs(self.mReuseItemList) do
            item:poolRecover()
            item = nil
        end
        self.mReuseItemList = {}
    end
end

function removeAllSkillItem(self)
    if #self.mSkillList > 0 then
        for _, item in ipairs(self.mSkillList) do
            item:poolRecover()
            item = nil
        end
        self.mSkillList = {}
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]