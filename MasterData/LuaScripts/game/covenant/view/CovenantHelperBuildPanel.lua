--[[ 
-----------------------------------------------------
@filename       : CovenantHelperBuildPanel
@Description    : 盟约助手培养
@date           : 2021-06-16 11:12:00
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('covenant.CovenantHelperBuildPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("covenant/CovenantHelperBuildPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    -- self:setBg("covenant_helper.jpg", false, "covenant")
    self:setBg("", false)
end

--析构  
function dtor(self)
end

function initData(self)
    -- 当前助手id
    self.m_helperId = nil
    -- 当前是否培养界面
    self.m_isBuildView = true
    -- 当前是否需要播放升级特效
    self.m_isLvlEffect = false
    -- 当前的基因总数（专门用于升级用的动画显示）
    self.m_totalGeneNum = nil
end

-- 初始化
function configUI(self)
    -- 助手
    self.m_textHelperListTitle = self:getChildGO("TextHelperListTitle"):GetComponent(ty.Text)
    self.mGroupHelperHead = self:getChildTrans('GroupHelperHead')

    -- 展示
    self.mGroupShow = self:getChildGO('GroupShow')
    self.mBtnBuild = self:getChildGO('BtnBuild')
    self.mImgBuild = self.mBtnBuild:GetComponent(ty.AutoRefImage)
    self.mBtnToHelp = self:getChildGO('BtnToHelp')
    self.mImgToHelp = self.mBtnToHelp:GetComponent(ty.AutoRefImage)
    self.mBtnArrowLeft = self:getChildGO('BtnArrowLeft')
    self.mBtnArrowRight = self:getChildGO('BtnArrowRight')

    self.m_modelNode = self:getChildTrans("ModelNode")
    self.m_modelClicker = self:getChildGO("ClickerArea")
    self.m_modelPlayer = ModelScenePlayer.new()
    self.m_clickTrigger = self:getChildGO("ToucherGesture"):GetComponent(ty.LongPressOrClickEventTrigger)
    -- 屏蔽手势
    self:getChildGO("ToucherGesture"):SetActive(false)

    self.m_groupSkill = self:getChildGO("GroupSkill")
    self.m_skillIcon = self:getChildGO("IconSkill")
    self.m_imgSkill = self.m_skillIcon:GetComponent(ty.AutoRefImage)
    self.m_textSkillTypeName = self:getChildGO("TextSkillTypeName"):GetComponent(ty.Text)
    self.m_textSkillName = self:getChildGO("TextSkillName"):GetComponent(ty.Text)
    
    self.mBtnTalent = self:getChildGO("BtnTalent")
    self.mTextGeneTitle = self:getChildGO("TextGeneTitle"):GetComponent(ty.Text)
    self.mTextGeneParam = self:getChildGO("TextGeneParam"):GetComponent(ty.Text)

    -- 升级
    self.mGroupLvl = self:getChildGO('GroupLvl')
    self.m_rectLvlShow = self:getChildGO("GroupLvlShow"):GetComponent(ty.RectTransform)
    self.m_textLvl = self:getChildGO("TextLvl"):GetComponent(ty.Text)
    self.m_textMaxLvl = self:getChildGO("TextMaxLvl"):GetComponent(ty.Text)
    self.m_textHelperName = self:getChildGO("TextHelperName"):GetComponent(ty.Text)
    
    self.m_groupExpShow = self:getChildGO("GroupExpShow")
    self.m_progressBar = self:getChildGO('ProgressBar'):GetComponent(ty.ProgressBar)
    local comCallFun = function()
        self.__removeActionTextSn(self)
    end
    self.m_progressBar:InitData(4, comCallFun)
    self.m_textExpPro = self:getChildGO("TextExpPro"):GetComponent(ty.Text)

    self.m_groupAttr = self:getChildTrans("GroupSpecialAttr")
    self.m_goupAddTip = self:getChildGO("GroupAddTip")
    self.m_imgAddGeneTip = self:getChildGO("ImgAddGeneTip"):GetComponent(ty.AutoRefImage)
    self.m_textAddTipName = self:getChildGO("TextAddTipName"):GetComponent(ty.Text)
    self.m_textAddTipValue = self:getChildGO("TextAddTipValue"):GetComponent(ty.Text)

    self.m_groupLvlUp = self:getChildGO("GroupLvlUp")
    self.m_textCost = self:getChildGO("TextCost"):GetComponent(ty.Text)
    self.m_imgCost = self:getChildGO("ImgCost"):GetComponent(ty.AutoRefImage)
    self.m_textCostTitle = self:getChildGO("TextCostTitle"):GetComponent(ty.LanText)
    self.m_btnLvlUp = self:getChildGO("BtnLvlUp")
    self.m_imgBtnLvlUp = self.m_btnLvlUp:GetComponent(ty.AutoRefImage)
    self.m_textBtnLvlUp = self:getChildGO("TextBtnLvlUp"):GetComponent(ty.Text)
    self.m_btnLvlUpRect = self.m_btnLvlUp:GetComponent(ty.RectTransform)
    self.m_btnLvlUpTrigger = self:getChildGO("BtnLvlUp"):GetComponent(ty.LongPressOrClickEventTrigger)

    -- 英雄
    self.mGroupHero = self:getChildGO('GroupHero')
    self.mTextHeroTitle1 = self:getChildGO("TextHeroTitle_1"):GetComponent(ty.Text)
    self.mTextHeroTitle2 = self:getChildGO("TextHeroTitle_2"):GetComponent(ty.Text)
    self.mGroupHelpHero = self:getChildTrans('GroupHelpHero')
    self.mTextHelpTip = self:getChildGO("TextHelpTip"):GetComponent(ty.Text)
end

--激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({ MoneyTid.PLAYER_HELPER_EXP_TID })
    GameDispatcher:addEventListener(EventName.RES_COVENANT_HELPER_DATA, self.__onHelperDataUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.RES_COVENANT_HELP_HERO_SELECT, self.__onHelpHeroSelectUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.RES_COVENANT_HELPER_LVL_UP, self.__onHelperLvlUpdateHandler, self)
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.__onBagUpdateHandler, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.__onUpdatePlayerMoneyHandler, self)
    hero.HeroManager:addEventListener(hero.HeroManager.UPDATE_FIELD_COVENANT_HELPER, self.__onHelperDataUpdateHandler, self)
    -- self:__addTouchEvent()
    self:__addLongTouchEvent()

    self.m_helperId = args.helperId
    self:__updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.RES_COVENANT_HELPER_DATA, self.__onHelperDataUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.RES_COVENANT_HELP_HERO_SELECT, self.__onHelpHeroSelectUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.RES_COVENANT_HELPER_LVL_UP, self.__onHelperLvlUpdateHandler, self)
    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.__onBagUpdateHandler, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.__onUpdatePlayerMoneyHandler, self)
    hero.HeroManager:removeEventListener(hero.HeroManager.UPDATE_FIELD_COVENANT_HELPER, self.__onHelperDataUpdateHandler, self)
    -- self:__removeTouchEvent()
    self:__removeLongTouchEvent()

    self:__resetShowList()
    self:__clearHeadItemList()
    self:__clearAttrItemList()
    self:__removeActionTextSn()
    self:__recoverModel(true)
    
    self.m_isLvlEffect = false
end

function initViewText(self)
    self.m_textHelperListTitle.text = _TT(43501) --"-助手列表-"
    self.m_textCostTitle.text = _TT(4349) --消耗
    self.mTextGeneTitle.text = _TT(43502) --"基因参数"
    self.mTextHeroTitle1.text = _TT(43503) --"导力对象"
    self.mTextHeroTitle2.text = _TT(43503) --"导力对象"
    self.m_textAddTipName.text = _TT(43502) --"基因参数"
    self:setBtnLabel(self.mBtnBuild, 4321, "培养")
    self:setBtnLabel(self.mBtnToHelp, 43504, "导力")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnBuild, self.__onClickBuildHandler)
    self:addUIEvent(self.mBtnToHelp, self.__onClickToHelpHandler)
    self:addUIEvent(self.mBtnArrowLeft, self.__onClickLeftHandler)
    self:addUIEvent(self.mBtnArrowRight, self.__onClickRightHandler)
    self:addUIEvent(self.m_skillIcon, self.__onClickSkillTipHandler)
    self:addUIEvent(self.mBtnTalent, self.__onClickTalentPanelHandler)
end

-- 长按相关
function __addLongTouchEvent(self)
    local function _onLongPressHandler()
        self:__onClickBtnLvlUpHandler(true)
    end
    self.m_btnLvlUpTrigger.onLongPress:AddListener(_onLongPressHandler)
    local function _onClickHandler()
        self:__onClickBtnLvlUpHandler(false)
    end
    self.m_btnLvlUpTrigger.onClick:AddListener(_onClickHandler)
    local function _onPointerUpHandler()
        self:__onClickLvlUpCancelHandler()
    end
    self.m_btnLvlUpTrigger.onPointerUp:AddListener(_onPointerUpHandler)
    local function _onPointerExitHandler()
        self:__onClickLvlUpCancelHandler()
    end
    self.m_btnLvlUpTrigger.onPointerExit:AddListener(_onPointerExitHandler)
end

function __removeLongTouchEvent(self)
    self.m_btnLvlUpTrigger.onLongPress:RemoveAllListeners()
    self.m_btnLvlUpTrigger.onClick:RemoveAllListeners()
    self.m_btnLvlUpTrigger.onPointerUp:RemoveAllListeners()
    self.m_btnLvlUpTrigger.onPointerExit:RemoveAllListeners()
end

-- 手势相关
function __addTouchEvent(self)
    local function _onPointDownHandler()
        self:__onPointDownHandler()
    end
    self.m_clickTrigger.onPointerDown:AddListener(_onPointDownHandler)
    local function _onPointerUpHandler()
        self:__onPointerUpHandler()
    end
    self.m_clickTrigger.onPointerUp:AddListener(_onPointerUpHandler)
end

function __removeTouchEvent(self)
    self.m_clickTrigger.onPointerDown:RemoveAllListeners()
    self.m_clickTrigger.onPointerUp:RemoveAllListeners()
    self.m_clickTrigger.onPointerExit:RemoveAllListeners()
end

function __onPointDownHandler(self)
    self.m_downTime = gs.Time.time
    self.m_downX = gs.Input.mousePosition.x
end

function __onPointerUpHandler(self)
    local deltaTime = gs.Time.time - self.m_downTime
    if (deltaTime < 0.5) then
        local deltaX = gs.Input.mousePosition.x - self.m_downX
        if (deltaX > 0) then
            self:__onClickLeftHandler()
        elseif (deltaX < 0) then
            self:__onClickRightHandler()
        end
    end
end

-- 点击培养
function __onClickBuildHandler(self)
    self.m_isBuildView = true
    self:__updateView()
end

-- 点击导力
function __onClickToHelpHandler(self)
    self.m_isBuildView = false
    self:__updateView()
end

-- 点击左边
function __onClickLeftHandler(self)
    if(self.m_helperId)then
        local helperIdList = covenant.CovenantManager:getHelperIdList()
        local index = nil
        for i = 1, #helperIdList do
            if(helperIdList[i] == self.m_helperId)then
                index = i
                break
            end
        end
        if(index)then
            if(helperIdList[index - 1])then
                self.m_helperId = helperIdList[index - 1]
            else
                self.m_helperId = helperIdList[#helperIdList]
            end
            self:__updateView()
        end
    end
end

-- 点击右边
function __onClickRightHandler(self)
    if(self.m_helperId)then
        local helperList = covenant.CovenantManager:getHelperIdList()
        local index = nil
        for i = 1, #helperList do
            if(helperList[i] == self.m_helperId)then
                index = i
                break
            end
        end
        if(index)then
            if(helperList[index + 1])then
                self.m_helperId = helperList[index + 1]
            else
                self.m_helperId = helperList[1]
            end
            self:__updateView()
        end
    end
end

-- 技能图标点击
function __onClickSkillTipHandler(self)
    local helperInfoVo = covenant.CovenantManager:getHelperConfigInfo(self.m_helperId)
    if (helperInfoVo) then
        if (helperInfoVo.skillId > 0) then
            TipsFactory:skillTips(nil, helperInfoVo.skillId, heroVo)
        end
    end
end

-- 科技树点击
function __onClickTalentPanelHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.CovenantScienceTree})
end

-- 点击升级
function __onClickBtnLvlUpHandler(self, isLongPress)
    if (isLongPress) then
        if (not self.m_frameSn) then
            self.m_frameSn = LoopManager:addFrame(1, 0, self, self.__onFramdUpdateHandler)
            self:__checkSend()
        end
    else
        self:__checkSend()
    end
end

function __onFramdUpdateHandler(self, deltaTime)
    -- 初始化变量
    if (not self.m_frames) then
        self.m_frames = 0
    end
    if (not self.m_speed) then
        self.m_speed = 0
    end
    if (not self.m_downSec) then
        self.m_downSec = 0
    end
    if (not self.m_isCanSend) then
        self.m_isCanSend = false
    end
    if (not self.m_isReceive) then
        self.m_isReceive = false
    end
    -- 按下时每25帧加1
    -- 1秒后每20帧加1
    -- 2秒后每15帧加1
    self.m_frames = self.m_frames + 1
    self.m_speed = self.m_speed + 1
    if (self.m_frames >= 30) then
        -- 模拟30帧为1秒
        self.m_downSec = self.m_downSec + 1
        self.m_frames = 0
    end

    if (self.m_downSec >= 2 and self.m_speed >= 15) then
        self.m_speed = 0
        self.m_isCanSend = true
    elseif (self.m_downSec >= 1 and self.m_speed >= 20) then
        self.m_speed = 0
        self.m_isCanSend = true
    elseif (self.m_downSec >= 0 and self.m_speed >= 25) then
        self.m_speed = 0
        self.m_isCanSend = true
    end
    -- 达到条件速度和收到服务器响应后发送升级
    if (self.m_isCanSend and self.m_isReceive) then
        self.m_isCanSend = false
        self.m_isReceive = false
        self:__checkSend()
    end
end

function __checkSend(self)
    local helperVo = covenant.CovenantManager:getHelperVo(self.m_helperId)
    local limitLvl = covenant.CovenantManager:getHelperLimitLvl(self.m_helperId)
    local maxLvl = covenant.CovenantManager:getHelperMaxLvl(self.m_helperId)
    if(helperVo.lvl >= maxLvl)then
        self:__onClickLvlUpCancelHandler()
        gs.Message.Show(_TT(43505))--"助手等级已达到最大级"
    elseif(helperVo.lvl >= limitLvl)then
        self:__onClickLvlUpCancelHandler()
        gs.Message.Show(string.format(_TT(43506)))--"需要先提升声望等级"
    else
        -- 升级
        local propsConfigVo = nil
        local needCount = 0
        propsConfigVo, needCount = covenant.CovenantManager:getLvlUpNeedPropsCount(helperVo)
        local isEnough, tipStr = MoneyUtil.judgeNeedMoneyCountByTid(propsConfigVo.tid, needCount, true, false)
        if (isEnough) then
            GameDispatcher:dispatchEvent(EventName.REQ_COVENANT_HELPER_LVL_UP, { helperId = self.m_helperId, list = { { key = propsConfigVo.tid, value = needCount } } })
        else
            -- UIFactory:alertMessge(tipStr, false, nil, nil, nil, false)
            gs.Message.Show2(tipStr)
        end
    end
end

-- 释放升级按钮
function __onClickLvlUpCancelHandler(self)
    if (self.m_frameSn) then
        LoopManager:removeFrameByIndex(self.m_frameSn)
        self.m_frameSn = nil
        self.m_frames = nil
        self.m_speed = nil
        self.m_downSec = nil
        self.m_isCanSend = nil
        self.m_isReceive = nil
    end
end

-- 助手信息更新
function __onHelperDataUpdateHandler(self, args)
    if(args.herlperId == nil or self.m_helperId == args.herlperId)then
        self:__updateView()
    end
end

-- 助手助力英雄更新
function __onHelpHeroSelectUpdateHandler(self, args)
    if(self.m_helperId == args.herlperId)then
        self:__updateView()
    end
end

-- 助手等级更新
function __onHelperLvlUpdateHandler(self, args)
    if(self.m_helperId == args.helperId)then
        self.m_isLvlEffect = true
    end
    self.m_isReceive = true
end

-- 背包更新
function __onBagUpdateHandler(self, args)
    self:__updateCost()
end

-- 资产更新
function __onUpdatePlayerMoneyHandler(self, args)
    self:__updateView()
end

function __updateSkillView(self)
    -- local helperInfoVo = covenant.CovenantManager:getHelperConfigInfo(self.m_helperId)
    -- if (helperInfoVo) then
    --     if (helperInfoVo.skillId > 0) then
    --         local skillVo = fight.SkillManager:getSkillRo(helperInfoVo.skillId)
    --         if (skillVo) then
    --             self.m_groupSkill:SetActive(true)
    --             self.m_imgSkill:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), true)
    --             self.m_textSkillTypeName.text = fight.FightDef.GetSkillTypeName(skillVo:getType())
    --             self.m_textSkillName.text = skillVo:getName() .. _TT(1069)--"增强"
    --         else
    --             self.m_groupSkill:SetActive(false)
    --         end
    --     else
    --         self.m_groupSkill:SetActive(false)
    --     end
    -- else
    --     self.m_groupSkill:SetActive(false)
    -- end

    -- 暂时屏蔽
    self.m_groupSkill:SetActive(false)
end

function onItemChange(self, args)
    self.m_helperId = args:getData().helperId
    self:__updateView()
end

function __updateView(self)
    self:__clearHeadItemList()
    -- local helperIdList = covenant.CovenantManager:getHelperIdList()
    -- for i = 1, #helperIdList do
    --     local vo = covenant.CovenantManager:getHelperVo(helperIdList[i])
    --     local item = covenant.CovenantHelperHeadItem:poolGet()
    --     item:setData(self.mGroupHelperHead, vo)
    --     item:addEventListener(item.EVENT_CHANGE, self.onItemChange, self)
    --     table.insert(self.m_headItemList, item)
    --     if(self.m_helperId == nil or self.m_helperId == vo.helperId)then
    --         self.m_helperId = vo.helperId
    --         item:setSelect(true)
    --     else
    --         item:setSelect(false)
    --     end
    -- end

    local helperVo = covenant.CovenantManager:getHelperVo(self.m_helperId)
    -- 更新特殊的属性展示
    if (self.m_isLvlEffect) then
        self.m_isLvlEffect = false
        for i = 1, #self.m_attrItemList do
            local item = self.m_attrItemList[i]
            local oldAttrVo, oldAttrWeight = item:getData()
            local attrVo = { key = oldAttrVo.key, value = helperVo.attrDic[oldAttrVo.key] }
            item:updateData(attrVo)
        end
        self:__removeActionTextSn()
        self.m_frameSnText = LoopManager:addFrame(1, 0, self, self.__updateActionText)
        self.m_progressBar:SetValue(helperVo.exp, helperVo.maxExp, true, false, true, 0.3)
    else
        self:__clearAttrItemList()
        local showAttrList = { AttConst.HP_MAX, AttConst.ATTACK, AttConst.DEFENSE, AttConst.SPEED }
        for i = 1, #showAttrList do
            local attrKey = showAttrList[i]
            if (helperVo.attrDic[attrKey]) then
                local attrVo = { key = attrKey, value = helperVo.attrDic[attrKey] }
                local item = covenant.CovenantHelperAttrItem:poolGet()
                item:setData(attrVo, true)
                item:setParent(self.m_groupAttr)
                table.insert(self.m_attrItemList, item)
            end
        end
        self.m_progressBar:SetValue(helperVo.exp, helperVo.maxExp, false, false, false, 0.3)
        self.m_textExpPro.text = helperVo.exp .. "/" .. helperVo.maxExp
    end

    local limitLvl = covenant.CovenantManager:getHelperLimitLvl(self.m_helperId)
    local maxLvl = covenant.CovenantManager:getHelperMaxLvl(self.m_helperId)
    self.m_textLvl.text = helperVo.lvl
    self.m_textMaxLvl.text = "/" .. limitLvl
    local helperInfoVo = covenant.CovenantManager:getHelperConfigInfo(self.m_helperId)
    self.m_textHelperName.text = helperInfoVo:getName()

    if (helperVo.lvl >= maxLvl) then
        self:__onClickLvlUpCancelHandler()
        -- 已经升级到最大级了
        self.m_groupLvlUp:SetActive(true)
        self:setBtnLabel(self.m_btnLvlUp, 1081, "已满级")
        self.m_imgBtnLvlUp:SetImg(UrlManager:getCommonPath("common_3005.png"), true)
        self.m_textCost.gameObject:SetActive(false)
        self.m_textBtnLvlUp.color = gs.ColorUtil.GetColor("BABABAFF")
        self.m_groupExpShow:SetActive(false)
        self.m_goupAddTip:SetActive(false)
    elseif(helperVo.lvl >= limitLvl)then
        self:__onClickLvlUpCancelHandler()
        -- 升级被限制
        self.m_groupLvlUp:SetActive(true)
        self:setBtnLabel(self.m_btnLvlUp, 1040, "升级")
        self.m_imgBtnLvlUp:SetImg(UrlManager:getCommonPath("common_3005.png"), true)
        self.m_textCost.gameObject:SetActive(false)
        self.m_textBtnLvlUp.color = gs.ColorUtil.GetColor("BABABAFF")
        self.m_groupExpShow:SetActive(true)
        self.m_goupAddTip:SetActive(false)
    else
        -- 升级
        self.m_groupLvlUp:SetActive(true)
        self:setBtnLabel(self.m_btnLvlUp, 1040, "升级")
        self.m_imgBtnLvlUp:SetImg(UrlManager:getCommonPath("common_3003.png"), true)
        self.m_textBtnLvlUp.color = gs.ColorUtil.GetColor("FFFFFFFF")
        self.m_groupExpShow:SetActive(true)
    
        -- 此处的升级按钮有概率会缩小，需要手动还原下大小
        gs.TransQuick:Scale(self.m_btnLvlUpRect, 1, 1, 1)
    
        local propsConfigVo, needCount = covenant.CovenantManager:getLvlUpNeedPropsCount(helperVo)
        if (needCount > 0) then
            self.m_textCost.gameObject:SetActive(true)
            self:__updateCost()
        else
            self.m_textCost.gameObject:SetActive(false)
        end

        local lvlUpConfigVo = covenant.CovenantManager:getHelperLvlUpConfigVo(helperVo.helperId, helperVo.lvl)
        local addGene = lvlUpConfigVo.addGene
        if(addGene > 0)then
            self.m_goupAddTip:SetActive(true)
            self.m_textAddTipValue.text = "+" .. addGene
        else
            self.m_goupAddTip:SetActive(false)
        end
    end

    self.m_totalGeneNum = covenant.CovenantManager.totalGeneNum
    self.mTextGeneParam.text = covenant.CovenantManager.remainGeneNum .. "/" .. covenant.CovenantManager.totalGeneNum
    self.mTextHelpTip.text = string.format(_TT(43507), sysParam.SysParamManager:getValue(SysParamType.COVENANT_HELP_HERO_NUM))--"每名助手最多协助%s名战员"

    self.mImgBuild:SetGray(not self.m_isBuildView)
    self.mImgToHelp:SetGray(self.m_isBuildView)
    self.mGroupLvl:SetActive(self.m_isBuildView)
    self.mGroupHero:SetActive(not self.m_isBuildView)

    self:__updateShowHeroList()
    self:__updateSkillView()
    self:__updateModelView()
    self:updateBubbleView()
end

-- 进度条文字相关
function __removeActionTextSn(self)
    if (self.m_frameSnText) then
        LoopManager:removeFrameByIndex(self.m_frameSnText)
        self.m_frameSnText = nil
    end
end

-- 进度条文字相关
function __updateActionText(self)
    local cur = self.m_progressBar.Current
    local total = self.m_progressBar.Total
    self.m_textExpPro.text = self.m_progressBar.Current .. "/" .. self.m_progressBar.Total
end

function __updateCost(self)
    local propsConfigVo = nil
    local needCount = 0
    local helperVo = covenant.CovenantManager:getHelperVo(self.m_helperId)
    propsConfigVo, needCount = covenant.CovenantManager:getLvlUpNeedPropsCount(helperVo)
    self.m_imgCost:SetImg(MoneyUtil.getMoneyIconUrlByTid(propsConfigVo.tid), true)
    local isEnough, tipStr = MoneyUtil.judgeNeedMoneyCountByTid(propsConfigVo.tid, needCount, false, false)
    if (isEnough) then
        self.m_textCost.color = gs.ColorUtil.GetColor(ColorUtil.PURE_WHITE_NUM)
    else
        self.m_textCost.color = gs.ColorUtil.GetColor(ColorUtil.RED_NUM)
    end
    self.m_textCost.text = "x" .. needCount

    -- if (self.m_costGrid) then
    --     self.m_costGrid:poolRecover()
    --     self.m_costGrid = nil
    -- end
    -- self.m_costGrid = PropsGrid:create(self.m_textCost.transform, { MoneyTid.HERO_GLOBAL_EXP_TID, 1 }, 0.6)
    -- self.m_costGrid:setIsShowName(false)
    -- self.m_costGrid:setClickEnable(true)
    -- self.m_costGrid:setPosition(gs.Vector3(-36, -36, 0))
end

function __updateModelView(self)
    local helperInfoVo = covenant.CovenantManager:getHelperConfigInfo(self.m_helperId)
    if(helperInfoVo)then
        -- self.m_modelPlayer:setModelData(helperInfoVo.model, false, 1, true, MainCityConst.ROLE_MODE_OVERVIEW, UrlManager:getBgPath("covenant/covenant_helper.jpg"), self.m_modelClicker, true, nil)
    else
        self:__recoverModel(false)
    end
end

function updateBubbleView(self)
    local helperVo = covenant.CovenantManager:getHelperVo(self.m_helperId)
    local isCanlvlUp = covenant.CovenantManager:isHelperCanLvlUp(helperVo)
    if (isCanlvlUp) then
        RedPointManager:add(self.m_btnLvlUp.transform, nil, 79, 19)
    else
        RedPointManager:remove(self.m_btnLvlUp.transform)
    end
end

-----------------------------------------------------------------start 助力英雄---------------------------------------------------------------------
-- 更新助力英雄格子
function __updateShowHeroList(self)
    self:__resetShowList()
    local helperVo = covenant.CovenantManager:getHelperVo(self.m_helperId)
    for i = 1, #helperVo.helpHeroList do
        local heroPosVo = helperVo.helpHeroList[i]
        local item = self.m_heroCardDic[heroPosVo.showPos]
        local heroVo = hero.HeroManager:getHeroVo(heroPosVo.heroId)
        item:setData(heroVo)
    end
end

function __onClickHelpHeroGridHandler(self, item)
    local pos = item:getPos()
    local heroVo = item:getData()
    GameDispatcher:dispatchEvent(EventName.OPEN_COVENANT_HELP_HERO_SELECT_PANEL, {helperId = self.m_helperId, pos = item:getPos(), heroId = item:getData() and item:getData().id or nil})
end

function __resetShowList(self)
    if(table.empty(self.m_heroCardDic))then
        self.m_heroCardDic = {}
        local maxNum = sysParam.SysParamManager:getValue(SysParamType.COVENANT_HELP_HERO_NUM)
        for pos = 1, maxNum do
            local item = covenant.CovenantHelperHeroItem.new()
            item:setBaseData(pos, true, self, self.__onClickHelpHeroGridHandler, item)
            item:setParentTrans(self.mGroupHelpHero)
            item:resetState()
            self.m_heroCardDic[pos] = item
        end
    else
        for pos, item in pairs(self.m_heroCardDic) do
            item:resetState()
        end
    end
end
-----------------------------------------------------------------end 助力英雄---------------------------------------------------------------------

function __recoverModel(self, isResetMaincity)
    self.m_modelPlayer:reset(isResetMaincity)
end

function __clearAttrItemList(self)
    if (self.m_attrItemList) then
        for i = 1, #self.m_attrItemList do
            local item = self.m_attrItemList[i]
            item:poolRecover()
        end
    end
    self.m_attrItemList = {}
end

function __clearHeadItemList(self)
    if (self.m_headItemList) then
        for i = 1, #self.m_headItemList do
            local item = self.m_headItemList[i]
            item:removeEventListener(item.EVENT_CHANGE, self.onItemChange, self)
            item:poolRecover()
        end
    end
    self.m_headItemList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
