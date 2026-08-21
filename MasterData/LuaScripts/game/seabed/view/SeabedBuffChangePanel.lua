-- 海底主界面
module("seabed.SeabedBuffChangePanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("seabed/SeabedBuffChangePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(111021))
    self:setSize(0, 0)
    self:setBg("seabed_main.jpg", false, "seabed")
end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.mBuffList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mBuffScroll = self:getChildGO("mBuffScroll"):GetComponent(ty.ScrollRect)
    self.mBuffItem = self:getChildGO("mBuffItem")

    self.mBtnRet = self:getChildGO("mBtnRet")
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
end

-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:clearBuffList()
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnRet, self.onBtnRetClickHandler)
end

function onBtnRetClickHandler(self)
    -- if self.needRemove then
    self:showPanel()
    -- else
    --    self:close()
    -- end
end

function showPanel(self)

    local canRemoveColl = seabed.SeabedManager:canShowRemoveColl()
    local canAddColl = seabed.SeabedManager:canShowAddColl()

    local canRemoveBuff = seabed.SeabedManager:canShowRemoveBuff()
    local canAddBuff = seabed.SeabedManager:canShowAddBuff()

    self.mTxtTips.color = gs.ColorUtil.GetColor("ffffffff")
    self.curType = 0

    --1 移除收藏品
    --2 添加收藏品
    --3 移除buff
    --4 添加buff
    -- if canRemoveColl == true then
    --     self.curType = 1
    -- elseif canAddColl == true then
    --     self.curType = 2
    -- elseif canRemoveBuff == true then
    --     self.curType = 3
    -- elseif canAddBuff == true then
    --     self.curType = 4
    -- end

    if canRemoveColl == true then
        self.curType = 4
    elseif canAddColl == true then
        self.curType = 2
    elseif canRemoveBuff == true then
        self.curType = 3
    elseif canAddBuff == true then
        self.curType = 1
    end

    if self.curType == 0 then
        self:close()
    elseif self.curType == 1 then
        self.mTxtTips.text = _TT(111052)
        self.battleType = seabed.SeabedBattleType.Buff
        local list = seabed.SeabedManager:getAddBuffList()
        seabed.SeabedManager:resetAddBuffList()
        self:showList(list)
    elseif self.curType == 2 then
        self.mTxtTips.text = _TT(111168)
        self.battleType = seabed.SeabedBattleType.Collage
        local list = seabed.SeabedManager:getAddCollList()
        seabed.SeabedManager:resetAddCollList()
        self:showList(list)
    elseif self.curType == 3 then
        self.mTxtTips.text = _TT(111053)
        self.battleType = seabed.SeabedBattleType.Buff
        self.mTxtTips.color = gs.ColorUtil.GetColor("d23627ff")
        local list = seabed.SeabedManager:getRemoveBuffList()
        seabed.SeabedManager:resetRemoveBuffList()
        self:showList(list)
    elseif self.curType == 4 then
        self.mTxtTips.text = _TT(111169)
        self.mTxtTips.color = gs.ColorUtil.GetColor("d23627ff")
        self.battleType = seabed.SeabedBattleType.Collage
        local list = seabed.SeabedManager:getRemoveCollList()
        seabed.SeabedManager:resetRemoveCollList()
        self:showList(list)
       
    end
end

function showList(self, list)
    self:clearBuffList()
    for i = 1, #list, 1 do
        local item = SimpleInsItem:create(self.mBuffItem, self.mBuffScroll.content, "mSeabedChangeBuffItem")
        local vo
        if self.battleType == seabed.SeabedBattleType.Buff then
            vo = seabed.SeabedManager:getSeabedBuffDataById(list[i])
        elseif self.battleType == seabed.SeabedBattleType.Collage then
            vo = seabed.SeabedManager:getSeabedCollectionDataById(list[i])
        end
        item:getChildGO("mBtnClick"):SetActive(false)
        item:getChildGO("mGroupNode"):GetComponent(ty.CanvasGroup).gameObject:SetActive(false)
        item:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage):SetImg(
            UrlManager:getIconPath("seabed/color_0" .. vo.color .. ".png"), false)
        item:getChildGO("mImgBuffIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(vo.icon), false)
        item:getChildGO("mTxtBuffName"):GetComponent(ty.Text).text = _TT(vo.name)
        item:getChildGO("mTxtBuffDes"):GetComponent(ty.Text).text = _TT(vo.des)

        LoopManager:setTimeout(i * 0.03, self, function()
            item:getChildGO("mGroupNode"):GetComponent(ty.CanvasGroup).gameObject:SetActive(true)
            item.m_go:GetComponent(ty.UIDoTween):BeginTween()
        end)
        table.insert(self.mBuffList, item)

    end
end

function clearBuffList(self)
    for i = 1, #self.mBuffList, 1 do
        self.mBuffList[i]:poolRecover()
    end
    self.mBuffList = {}
end

return _M
