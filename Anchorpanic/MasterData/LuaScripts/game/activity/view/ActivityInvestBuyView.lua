module("game.activity.view.ActivityInvestBuyView", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("activity/ActivityInvestBuyView.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowMoneyBar = 1

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(136501))
    self:setSize(1120, 520)
end

function initData(self)
    self.selectId = 0
    self.mInvestItemList = {}
end

function configUI(self)
    super.configUI(self)

    self.mContent = self:getChildTrans("Content")
    self.mBuyItem = self:getChildGO("mBuyItem")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)

    self.mBtnBuy = self:getChildGO("mBtnBuy"):GetComponent(ty.Button)
end

function initViewText(self)
    -- activity.ActivityManager:getActivityVoById(vo.activityId):isOpen()
end

function active(self, args)
    super.active(self, args)

    MoneyManager:setMoneyTidList({MoneyTid.ITIANIUM_TID})
    self:showPanel()
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnBuy, self.onBtnBuyClick)

end

function getInvestIndexById(self,id)
    local investList = activity.ActivityManager:getInvestList()
    for i = 1, #investList do
        if investList[i].id == id then
            return i
        end
    end
    return 1
end

function onBtnBuyClick(self)

    if self.selectId == 0 then
        gs.Message.Show(_TT(136517))
        return
    end

    local investList = activity.ActivityManager:getInvestList()
    local curId = activity.ActivityManager:getInvestGrade()
    local needMoney = sysParam.SysParamManager:getValue(SysParamType.ACTIVITY_INVEST_NEED_MONEY) / 100
    local curMoney = activity.ActivityManager:getInvestTotalCount()
    if needMoney > curMoney then
        gs.Message.Show(_TT(136512))
        return
    end

    if curId > 0 then
        gs.Message.Show(_TT(136513))
        return
    end

    local i = self:getInvestIndexById(self.selectId)
    UIFactory:alertMessge(_TT(136503), true, function()
        local result, tips =
            MoneyUtil.judgeNeedMoneyCountByTid(investList[i].cost[1], investList[i].cost[2], true, true)
        if tips == "" and result == true then
            GameDispatcher:dispatchEvent(EventName.REQ_ACTIVITY_INVEST_BUY, {
                id = investList[i].id
            })
            self:close()
        else
            if MoneyUtil.getMoneyCountByType(MoneyTid.PAY_ITIANIUM_TID) > 0 then
                GameDispatcher:dispatchEvent(EventName.OPEN_CONVERT_TITANIUM_VIEW)
            else
                GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {
                    linkId = LinkCode.Purchase
                })
            end
        end
    end, _TT(1), nil, true, nil, _TT(2), _TT(5))
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({})
    self:clearInvestItems()
end

function showPanel(self)

    local curId = activity.ActivityManager:getInvestGrade()
    local needMoney = sysParam.SysParamManager:getValue(SysParamType.ACTIVITY_INVEST_NEED_MONEY) / 100
    local curMoney = activity.ActivityManager:getInvestTotalCount()

    self.mTxtTitle.text = string.substitute(_TT(136502), needMoney, curMoney, needMoney)

    self:clearInvestItems()
    local investList = activity.ActivityManager:getInvestList()
    for i = 1, #investList do
        local item = SimpleInsItem:create(self.mBuyItem, self.mContent, "mInvestBuyItem")
        item:getChildGO("mDayTwo"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(
            "activityInvest/activity_xtjj_number" .. investList[i].id .. ".png"), false)

        item:getChildGO("mNeedIcon"):GetComponent(ty.AutoRefImage):SetImg(
            MoneyUtil.getMoneyIconUrlByTid(investList[i].cost[1]), true)
        item:getChildGO("mGetIcon"):GetComponent(ty.AutoRefImage):SetImg(
            MoneyUtil.getMoneyIconUrlByTid(investList[i].allReturn[1]), true)

        item:getChildGO("mImgSelect"):SetActive(self.selectId == investList[i].id)
        item:getChildGO("mImgNoSelect"):SetActive(false) -- self.selectId ~= investList[i].id)

        item:getChildGO("mTxtNeedCount"):GetComponent(ty.Text).text = investList[i].cost[2]
        item:getChildGO("mTxtGetCount"):GetComponent(ty.Text).text = investList[i].allReturn[2]

        item:addUIEvent(nil,function ()
            self.selectId = investList[i].id

            for i = 1,#self.mInvestItemList do
                self.mInvestItemList[i]:getChildGO("mImgSelect"):SetActive(self.selectId == investList[i].id)
                self.mInvestItemList[i]:getChildGO("mImgNoSelect"):SetActive(self.selectId ~= investList[i].id)
            end
            self.mBtnBuy.interactable = self.selectId > 0
        end)

        table.insert(self.mInvestItemList,item)
    end
    self.mBtnBuy.interactable = self.selectId > 0
end

function clearInvestItems(self)
    for i = 1, #self.mInvestItemList do
        self.mInvestItemList[i]:poolRecover()
    end
    self.mInvestItemList = {}
end

return _M
