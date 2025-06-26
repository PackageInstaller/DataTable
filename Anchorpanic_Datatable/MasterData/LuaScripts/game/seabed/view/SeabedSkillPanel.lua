-- 海底主界面
module("seabed.SeabedSkillPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("seabed/SeabedSkillPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle("技能选择")
    self:setSize(0, 0)
    self:setBg("seabed_main.jpg", false, "seabed")
end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.mSkillItemList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mDefInfo = self:getChildGO("mDefInfo")
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mSkillScroll = self:getChildGO("mSkillScroll"):GetComponent(ty.ScrollRect)
    self.mSkillItem = self:getChildGO("mSkillItem")

    self.mSelectInfo = self:getChildGO("mSelectInfo")
    self.mSelectSkill = self:getChildGO("mSelectSkill")
    self.mSelectContent = self:getChildTrans("mSelectContent")
    self.mTxtSelectSkillName = self:getChildGO("mTxtSelectSkillName"):GetComponent(ty.Text)
    self.mTxtSelectSkillDes = self:getChildGO("mTxtSelectSkillDes"):GetComponent(ty.Text)

    self.mBtnLast = self:getChildGO("mBtnLast")
    self.mBtnNext = self:getChildGO("mBtnNext")

    self.mBtnSure = self:getChildGO("mBtnSure")
    self.mBtnCancel = self:getChildGO("mBtnCancel")
end

-- 激活
function active(self, args)
    super.active(self, args)
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:clearSkillItemList()
    if self.curItem ~= nil then
        self.curItem:poolRecover()
    end
    self.curItem = nil
end

function initViewText(self)

    self:getChildGO("mTxtTips"):GetComponent(ty.Text).text = _TT(111041)
    self:getChildGO("mTxtFight"):GetComponent(ty.Text).text = _TT(111042)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnLast, self.onBtnLastClickHandler)
    self:addUIEvent(self.mBtnNext, self.onBtnNextClickHandler)

    self:addUIEvent(self.mBtnSure, self.onBtnSureClickHandler)
    self:addUIEvent(self.mBtnCancel, self.onBtnCancelClickHandler)
end

function onBtnSureClickHandler(self)
    local args = {}
    args.step = seabed.SeabedStepType.Skill
    args.list = {self.curIndex}

    GameDispatcher:dispatchEvent(EventName.REQ_ENTER_SEABED, args)

    -- GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_MAP_PANEL)
end

function onBtnCancelClickHandler(self)
    self.mDefInfo:SetActive(true)
    self.mSelectInfo:SetActive(false)
end

function showPanel(self)

    self.mDefInfo:SetActive(true)
    self.mSelectInfo:SetActive(false)

    local skillList = seabed.SeabedManager:getSeabedSkillData()
    self.skillNum = #skillList
    self:clearSkillItemList()
    for i = 1, #skillList do
        local item = SimpleInsItem:create(self.mSkillItem, self.mSkillScroll.content, "mSeabedSkillItem")
        item:getChildGO("mImgColor"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor(skillList[i].color)
        item:getChildGO("mTxtTag"):GetComponent(ty.Text).text = _TT(skillList[i].tag)

        local skillVo = fight.SkillManager:getSkillRo(skillList[i].skillId)
        item:getChildGO("mTxtName"):GetComponent(ty.Text).text = skillVo:getName()
        item:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()),
            true)

        item:getChildGO("mGroupNode"):GetComponent(ty.CanvasGroup).gameObject:SetActive(false)
        LoopManager:setTimeout(i * 0.03, self, function()
            item:getChildGO("mGroupNode"):GetComponent(ty.CanvasGroup).gameObject:SetActive(true)
            item.m_go:GetComponent(ty.UIDoTween):BeginTween()
        end)

        item:addUIEvent("mBtnClick", function()
            self:onClickSkillItem(i)
        end)
        table.insert(self.mSkillItemList, item)
    end

end

function onClickSkillItem(self, index)
    self.curIndex = index
    self.mDefInfo:SetActive(false)
    self:updateSelectItem()
end

function updateSelectItem(self)
    local skillList = seabed.SeabedManager:getSeabedSkillData()
    local vo = skillList[self.curIndex]

    if self.curItem ~= nil then
        self.curItem:poolRecover()
    end

    self.curItem = SimpleInsItem:create(self.mSkillItem, self.mSelectContent, "mSeabedSingleSkillItem")
    gs.TransQuick:UIPos(self.curItem:getGo():GetComponent(ty.RectTransform), 0, 0)

    self.curItem:getChildGO("mImgColor"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor(vo.color)
    self.curItem:getChildGO("mTxtTag"):GetComponent(ty.Text).text = _TT(vo.tag)

    local skillVo = fight.SkillManager:getSkillRo(vo.skillId)
    self.curItem:getChildGO("mTxtName"):GetComponent(ty.Text).text = skillVo:getName()
    self.curItem:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getSkillIconPath(
        skillVo:getIcon()), true)

    self.mTxtSelectSkillName.text = skillVo:getName()
    self.mTxtSelectSkillDes.text = skillVo:getDesc()

    self.mSelectInfo:SetActive(true)
end

function onBtnLastClickHandler(self)
    self.curIndex = self.curIndex - 1
    if self.curIndex <= 0 then
        self.curIndex = self.skillNum
    end
    self:updateSelectItem()
end

function onBtnNextClickHandler(self)
    self.curIndex = self.curIndex + 1
    if self.curIndex > self.skillNum then
        self.curIndex = 1
    end
    self:updateSelectItem()
end

function clearSkillItemList(self)
    for i = 1, #self.mSkillItemList, 1 do
        self.mSkillItemList[i]:poolRecover()
    end
    self.mSkillItemList = {}
end

return _M
