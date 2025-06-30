module("seabed.SeabedTalentAllPanel", Class.impl(View))
-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("seabed/SeabedTalentAllPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(27589))
    self:setUICode(LinkCode.Cycle)
    self:setBg("cycle_bg_002.jpg", false, "cycle")
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mTalentBarList = {}
    self.mBarIndex = 2
    self.mIsBgActive = true
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mTxtProgress = self:getChildGO("mTxtProgress"):GetComponent(ty.Text)
    self.mTalentBar = self:getChildGO("mTalentBar")
    self.Content = self:getChildTrans("Content")
    self.mEmptyState = self:getChildGO("mEmptyState")
end

-- 激活
function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({})
    --self:updateView()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverTalentBar()
end

function updateView(self)
    self:recoverTalentBar()
    local dic = seabed.SeabedManager:getSeabedTalentData()
    local talentNum = seabed.SeabedManager:getSeabedTalentUnlockNum()
    self.mTxtProgress.text = talentNum .. "/" .. table.nums(dic)
    if talentNum > 0 then 
        -- 三属性
        for k,v in pairs(seabed.SeabedManager:getTalentAttr()) do
            self:addTalentBar(1, {key = k, value = v})
        end
        if cycle.CycleTalentManager:getPlayExpRate() > 0 then 
            self:addTalentBar(2)
        end
        if cycle.CycleTalentManager:getBattleExpRate() > 0 then
            self:addTalentBar(3)
        end
        if cycle.CycleTalentManager:getCoin() > 0 then
            self:addTalentBar(4)
        end
        if cycle.CycleTalentManager:getReason() > 0 then
            self:addTalentBar(5)
        end
        for k,v in pairs(cycle.CycleTalentManager:getCollage()) do
            self:addTalentBar(6, {value = v})
        end
    end
    self.mEmptyState:SetActive(talentNum <= 0)
end

function addTalentBar(self, type, data)
    if self.mBarIndex == 2 then 
        local item = SimpleInsItem:create(self.mTalentBar, self.Content, "CycleTalentCongnitionPanelTalentBar")
        local barBg = item:getChildGO("mBg")
        barBg:SetActive(self.mIsBgActive)
        self.mIsBgActive = not self.mIsBgActive
        table.insert(self.mTalentBarList, item)
        self.mBarIndex = 0
    end
    local icon = "cycle/talent_icon_02.png"
    local name = ""
    local value = " "
    if type == 1 then 
        value = "+" .. (data.value / 100) .. "%" 
        name = AttConst.getName(data.key)
    elseif type == 2 then 
        -- 战斗经验
        value = "+" .. (cycle.CycleTalentManager:getPlayExpRate() / 100) .. "%"
        name = _TT(27590)
    elseif type == 3 then 
        -- 转化效率
        value = "+" .. (cycle.CycleTalentManager:getBattleExpRate() / 100) .. "%"
        name = _TT(27591)
    elseif type == 4 then 
        -- 玩法币
        value = "+" .. cycle.CycleTalentManager:getCoin() 
        name = _TT(27592)
    elseif type == 5 then 
        -- 理智
        value = "+" .. cycle.CycleTalentManager:getReason() 
        name = _TT(27593)
    elseif type == 6 then 
        icon = "cycle/talent_icon_03.png"
        name = _TT(27594, _TT(cycle.CycleManager:getCycleCollectionDataById(data.value).name)) -- "解锁收藏品: \"" ..  .. "\""
    end

    local lastItem = self.mTalentBarList[#self.mTalentBarList]
    if self.mBarIndex == 0 then
        lastItem:getChildGO("mTalentItem2"):SetActive(false)
        local iconImg = lastItem:getChildGO("mIcon1"):GetComponent(ty.AutoRefImage)
        local title = lastItem:getChildGO("mTxtTitle1"):GetComponent(ty.Text)
        local addValue = lastItem:getChildGO("mAddVlaue1"):GetComponent(ty.Text)
        iconImg:SetImg(UrlManager:getIconPath(icon))
        title.text = name
        addValue.text = value 
    elseif self.mBarIndex == 1 then
        lastItem:getChildGO("mTalentItem2"):SetActive(true)
        local iconImg = lastItem:getChildGO("mIcon2"):GetComponent(ty.AutoRefImage)
        local title = lastItem:getChildGO("mTxtTitle2"):GetComponent(ty.Text)
        local addValue = lastItem:getChildGO("mAddVlaue2"):GetComponent(ty.Text)
        iconImg:SetImg(UrlManager:getIconPath(icon))
        title.text = name
        addValue.text = value 
    end
    self.mBarIndex = self.mBarIndex + 1
end

function recoverTalentBar(self)
    for k,v in pairs(self.mTalentBarList) do
        v:poolRecover()
    end
    self.mTalentBarList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27593):	"初始理智"
	语言包: _TT(27592):	"初始玩法币"
	语言包: _TT(27591):	"玩法经验转化效率"
	语言包: _TT(27590):	"战斗经验"
	语言包: _TT(27589):	"天赋"
]]
