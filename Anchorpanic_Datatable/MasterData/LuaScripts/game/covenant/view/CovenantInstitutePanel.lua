

module("covenant.CovenantInstitutePanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("covenant/CovenantInstitutePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 0
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setBg("")
    self:setTxtTitle(_TT(29566))
    -- self:setSize(1624, 750)
    -- self:setBg("covenantBg_2.png",false,"covenantTalent")
end

function initData(self)
    self.mAttrLists = {}
    --点击升级的次数 限制器
    self.mOnClickTime=0
    self.mLastOnClickTime=0


    self.mSkillList = {}
end
-- 析构
function dtor(self)
end

function configUI(self)
    super.configUI(self)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtTopTitle = self:getChildGO("mTxtTopTitle"):GetComponent(ty.Text)
    self.mTxtSkill = self:getChildGO("mTxtSkill"):GetComponent(ty.Text)
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
    self.mAttrContent = self:getChildTrans("mAttrContent")
    self.mBtnLvUp = self:getChildGO("mBtnLvUp")
    self.mTxtCost = self:getChildGO("mTxtCost"):GetComponent(ty.Text)
    self.mImgCost = self:getChildGO("mImgCost"):GetComponent(ty.AutoRefImage)
    self.mNeedLvUp = self:getChildGO("mNeedLvUp")
    self.mImgIsMaxGroup = self:getChildGO("mImgIsMaxGroup")
    self.mAttrItem = self:getChildGO("mAttrItem")

    self.mSkillContent = self:getChildTrans("mSkillContent")

    self:setGuideTrans("funcTips_covenant_institute", self:getChildTrans("mBtnLvUp"))
end
-- 激活
function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_INSTITUTE_PANEL,self.onUpdateInstitutePanel,self)
    MoneyManager:setMoneyTidList({MoneyTid.PLAYER_HELPER_EXP_TID})
    self:showPanel()
end
-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_INSTITUTE_PANEL,self.onUpdateInstitutePanel,self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
    self:clearAttrs()
    self:clearSkillItem()
end

function onUpdateInstitutePanel(self)
    self:showPanel()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtName.text = _TT(29567)
    self.mTxtTopTitle.text = _TT(29568)
    self.mTxtSkill.text = _TT(29569)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnLvUp,self.onClicklevelUpHandler)
end

function showPanel(self)
    local instituteServerInfo = covenant.CovenantManager:getInstituteServerInfo()
    self.mTxtLv.text = instituteServerInfo.lv 
    self:clearAttrs()
    self.m_helperId = 101
    local helperVo = covenant.CovenantManager:getInstituteData(self.m_helperId)
    local maxLv = helperVo:getHelperMaxLv()
    local needExp = helperVo:getHelperLvExp(instituteServerInfo.lv)
    local roleVo = role.RoleManager:getRoleVo()
    local needExpState = roleVo:getPlayerHelperGlobalExp() > needExp and HtmlUtil:color(needExp, "038008") or HtmlUtil:color(needExp, "fa0909")
    for i = 1 ,#instituteServerInfo.attr do
        local item = SimpleInsItem:create(self.mAttrItem, self.mAttrContent,"CovenantInstitutePanelmInstituteItem")
        item:getChildGO("mTxtAttrName"):GetComponent(ty.Text).text = AttConst.getName(instituteServerInfo.attr[i].key)
        item:getChildGO("mTxtAttrValue"):GetComponent(ty.Text).text = instituteServerInfo.attr[i].value
        if maxLv~=instituteServerInfo.lv then
            item:getChildGO("mTxtUp"):GetComponent(ty.Text).text=instituteServerInfo.attrNext[i].value-instituteServerInfo.attr[i].value
        end
        table.insert(self.mAttrLists,item)
    end

    self.mImgCost:SetImg(MoneyUtil.getMoneyIconUrlByTid(MoneyTid.PLAYER_HELPER_EXP_TID,false), true)

    if maxLv == instituteServerInfo.lv then
        self.mNeedLvUp:SetActive(false)
        self.mImgIsMaxGroup:SetActive(true)
    else
        self.mImgIsMaxGroup:SetActive(false)
        self.mNeedLvUp:SetActive(true)
        self.mTxtCost.text = needExpState    
    end
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self:getChildTrans("mGroupCost"))
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self:getChildTrans("mImgTopTitleBg"))

    self:clearSkillItem()
    self.cusForcesId = covenant.CovenantManager:getForcesId()
    local selectData = covenant.CovenantManager:getCovenantSelectData(self.cusForcesId)

    for i=1,#selectData.skill do
        local skillItem = SkillGrid:create(self.mSkillContent, {skillId = selectData.skill[i]}, 1)
        table.insert(self.mSkillList, skillItem) 
    end
end

 function clearSkillItem(self)
    for i = 1, #self.mSkillList do
        self.mSkillList[i]:poolRecover()
    end
    self.mSkillList = {}
end

function onClicklevelUpHandler(self)
    local instituteServerInfo = covenant.CovenantManager:getInstituteServerInfo()
    local helperVo = covenant.CovenantManager:getInstituteData(self.m_helperId)
    local needExp = helperVo:getHelperLvExp(instituteServerInfo.lv)
    local roleVo = role.RoleManager:getRoleVo()

    
    
    local myExp = roleVo:getPlayerHelperGlobalExp()
    if instituteServerInfo.lv >= covenant.CovenantManager:getCovenantPrestigeDataById(covenant.CovenantManager:getPerstigeStage()).helperLimitLvl then
        gs.Message.Show(_TT(29549))
        return 
    else
        if myExp >= needExp then
            local time=GameManager:getClientMSTime()
            self.mOnClickTime=time
            if self.mOnClickTime-self.mLastOnClickTime>0.5 then
                GameDispatcher:dispatchEvent(EventName.REQ_INSTITUTE_LV_UP)
                self.mLastOnClickTime=GameManager:getClientMSTime()
            else
            gs.Message.Show(_TT(29556))
            end
        else
            gs.Message.Show(_TT(29557))
        end 
    end

end

function clearAttrs(self)
    for i = 1 ,#self.mAttrLists do
        self.mAttrLists[i]:poolRecover()
    end
    self.mAttrLists = {}
end

function onCloseAllCall(self)
    super.onCloseAllCall(self)
    self:playerClose()
end

function onClickClose(self)
    super.onClickClose(self)
    self:playerClose()    
end

function playerClose(self)
    GameDispatcher:dispatchEvent(EventName.CUSTOM_CONVENANT_SCENE_CHANGE)
end
    

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(29557):	"缺少经验"
	语言包: _TT(29556):	"指挥官慢点"
]]
