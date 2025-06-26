module("cycle.CycleLevelPanel", Class.impl(View))
-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("cycle/CycleLevelPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShow3DBg = 1
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(331))
    self:setBg("")
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mLevelItems = {}
    self.mLv = 0
    self.mExp = 0
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mLevelItem = self:getChildGO("mLevelItem")
    self.mLevelScroll = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mBtnGetAll = self:getChildGO("mBtnGetAll")
    self.mTxtLevel = self:getChildGO("mTxtLevel"):GetComponent(ty.Text)
    self.mTxtEx = self:getChildGO("mTxtEx"):GetComponent(ty.Text)
    self.mLevelSliderImg = self:getChildGO("mLevelSliderImg"):GetComponent(ty.Image)
    self.mLevelSelectTitle = self:getChildGO("mLevelSelectTitle"):GetComponent(ty.Text)
end

-- 激活
function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.ON_RESPONED_RECEIVE_AWARD, self.init, self)
    MoneyManager:setMoneyTidList({})
    self.isInit = true
    self.mLevelScroll:SetItemRender(cycle.CycleLevelItem)
    self:init()
    if self.mLv > 1 then
        self.mLevelScroll:SetItemIndex(self.mLv - 1, 0, 0, 0.5)
    end
end
-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.ON_RESPONED_RECEIVE_AWARD, self.init, self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mLevelSelectTitle.text = _TT(27606)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnGetAll, self.onBtnGetAllClickHandler)
end

function init(self)
    self:updateData()
    self:onShowPanel()
    self:updateItems()
end


function updateData(self)
    local info = cycle.CycleManager.mHistoryInfo
    self.mLv = info.lv

    if self.mLv > 0 and self.mLv > #info.gained_lv_reward_list then
        self.mBtnGetAll.gameObject:SetActive(true)
    end
    if self.mLv <= 0 or self.mLv <= #info.gained_lv_reward_list then
        self.mBtnGetAll.gameObject:SetActive(false)
    end
    self.mExp = info.exp
    self.mReceivedList = info.exp
    self.len = #cycle.CycleManager:getCycleLvDataList()
    if self.mLv < self.len then
        self.mNextLvConfig = cycle.CycleManager:getCycleLvData(self.mLv + 1)
    else
        self.mNextLvConfig = cycle.CycleManager:getCycleLvData(self.len)
    end
end

function onShowPanel(self)
    if self.mLv > 0 and self.mLv < 10 then
        self.mTxtLevel.text = "0" .. self.mLv
    else
        self.mTxtLevel.text = self.mLv
    end
    self.mTxtEx.text = self.mExp .. "/" .. self.mNextLvConfig.needExp
    self.mLevelSliderImg.fillAmount = self.mExp / self.mNextLvConfig.needExp
end

function updateItems(self)
    local levelDic = cycle.CycleManager:getCycleLvDataList()
    for idx = 1, 6 do
        levelDic[idx].tweenId = idx
    end
    if self.mLevelScroll.Count <= 0 then
        self.mLevelScroll.DataProvider = levelDic
    else
        self.mLevelScroll:ReplaceAllDataProvider(levelDic)
    end
end

function onBtnGetAllClickHandler(self)
    if cycle.CycleManager.mHistoryInfo.gained_lv_reward_list then
        if #cycle.CycleManager.mHistoryInfo.gained_lv_reward_list >= self.len then
            gs.Message.Show(_TT(27552))
            return
        end
    end
    if self.mLv > 0 then
        if self.mLv > #cycle.CycleManager.mHistoryInfo.gained_lv_reward_list then
            GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_AUTO_RECEIVE)
            return
        end
    end
    gs.Message.Show(_TT(27553))
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27553):	"暂无奖励领取"
	语言包: _TT(27552):	"已经全部领取完"
]]
