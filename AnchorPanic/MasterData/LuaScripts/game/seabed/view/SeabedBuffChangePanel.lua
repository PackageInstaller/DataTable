

-- 海底主界面
module("seabed.SeabedBuffChangePanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("seabed/SeabedBuffChangePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗


-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(111051))
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
    if self.needRemove then
        self:showPanel()
    else
        self:close()
    end
end

function showPanel(self)
    local canAdd = seabed.SeabedManager:canShowAddBuff()
    local canRemove = seabed.SeabedManager:canShowRemoveBuff()
    self.mTxtTips.color =  gs.ColorUtil.GetColor("ffffffff")
    if canAdd and canRemove then
        self.mTxtTips.text = _TT(111052)
        local list = seabed.SeabedManager:getAddBuffList()
        seabed.SeabedManager:resetAddBuffList()
        self:showList(list)
        self.needRemove = true
    elseif canAdd == true and canRemove == false then
        self.mTxtTips.text = _TT(111052)
        local list = seabed.SeabedManager:getAddBuffList()
        seabed.SeabedManager:resetAddBuffList()
        self:showList(list)
    elseif canAdd == false and canRemove == true then
        self.mTxtTips.text = _TT(111053)
        self.mTxtTips.color =  gs.ColorUtil.GetColor("d23627ff")
        local list = seabed.SeabedManager:getRemoveBuffList()
        seabed.SeabedManager:resetRemoveBuffList()
        self.needRemove = false
        self:showList(list)
    end
end

function showList(self,list)
    self:clearBuffList()
    for i = 1, #list, 1 do
        local item = SimpleInsItem:create(self.mBuffItem, self.mBuffScroll.content, "mSeabedChangeBuffItem")
        local vo = seabed.SeabedManager:getSeabedBuffDataById(list[i])
        item:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage):SetImg("seabed/color_0"..vo.color..".png", false)
        item:getChildGO("mImgBuffIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(vo.icon), false)
        item:getChildGO("mTxtBuffName"):GetComponent(ty.Text).text = _TT(vo.name)
        item:getChildGO("mTxtBuffDes"):GetComponent(ty.Text).text = _TT(vo.des)
    
        table.insert(self.mBuffList,item)
        
    end
end

function clearBuffList(self)
    for i = 1, #self.mBuffList, 1 do
        self.mBuffList[i]:poolRecover()
    end
    self.mBuffList = {}
end

return _M