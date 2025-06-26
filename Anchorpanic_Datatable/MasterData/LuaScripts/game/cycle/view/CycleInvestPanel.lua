

module("cycle.CycleInvestPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("cycle/CycleInvestPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(4550))
    self:setBg("cycle_bg_003.jpg", false, "cycle")
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mInvestAllItems = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mTxtHeroName = self:getChildGO("mTxtHeroName"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtShopInfo = self:getChildGO("mTxtShopInfo"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)

    self.mInvestAllInfo = self:getChildGO("mInvestAllInfo")

    self.mTxtAllInfo = self:getChildGO("mTxtAllInfo"):GetComponent(ty.Text)
    self.mTxtMax = self:getChildGO("mTxtMax"):GetComponent(ty.Text)

    self.mTxtMaxValue = self:getChildGO("mTxtMaxValue"):GetComponent(ty.Text)

    self.mBtnAllRet = self:getChildGO("mBtnAllRet")
    self.mInvestScroll = self:getChildGO("mInvestScroll"):GetComponent(ty.ScrollRect)
    self.mInvestItem = self:getChildGO("mInvestItem")
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtHeroName.text = _TT(27548)
    self.mTxtName.text = _TT(27549)
    self.mTxtShopInfo.text = _TT(27550)
    self.mTxtDes.text = _TT(27551)
end

function active(self, args)
    super.active(self)

    self:showPanel()

    MoneyManager:setMoneyTidList({})
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })
    self:clearInvestAllItems()
end


function showPanel(self)

    self:clearInvestAllItems()
    local maxValue = cycle.CycleManager:getInvestMaxValue()
    self.mTxtMaxValue.text = maxValue

    local dic = cycle.CycleManager:getCycleInvestShopData()
    for k, v in pairs(dic) do
        --过滤满级
        if v.needCoin > 0 then
            local item = SimpleInsItem:create(self.mInvestItem, self.mInvestScroll.content, "CycleInvestPanelinvestItem")
            item:getChildGO("mTxtDes"):GetComponent(ty.Text).text = _TT(v.des)
            item:getChildGO("mTxtNeedCoin"):GetComponent(ty.Text).text = v.needCoin
    
            local cg = item:getChildGO("mGroupItem"):GetComponent(ty.CanvasGroup)
            local img = item:getChildGO("mImgState"):GetComponent(ty.AutoRefImage)
            if v.needCoin <= maxValue then
                cg.alpha = 1
                img:SetImg(UrlManager:getCommon5Path("common_0145.png"), false)
            else
                cg.alpha = 0.5
                img:SetImg(UrlManager:getCommon5Path("common_0085.png"), false)
            end
    
            table.insert(self.mInvestAllItems, item)
        end
       
    end
end

function clearInvestAllItems(self)
    for i = 1, #self.mInvestAllItems do
        self.mInvestAllItems[i]:poolRecover()
    end
    self.mInvestAllItems = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27551):	"投资系统会概率性在商店出现，其余额会在每一次探索中继承。养成良好的投资习惯解锁投资奖赏，为后续的探索积攒优势"
	语言包: _TT(27550):	"中国有句古话:xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
	语言包: _TT(27549):	"伊西丝"
	语言包: _TT(27548):	"古怪商人"
]]
