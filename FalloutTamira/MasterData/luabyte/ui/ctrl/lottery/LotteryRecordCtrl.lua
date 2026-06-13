local LotteryRecordCtrl = BaseClass("LotteryRecordCtrl", BaseUICtrl)
local M = LotteryRecordCtrl


local UIHeroItemNewCtrl = require("UI.Ctrl.Lottery.LotteryRecordToggleCtrl")
local UIHeroItemNewView = require("UI.View.Lottery.LotteryRecordToggle")

local SortType = { CardPool, Time, Hero }

function M:Init()
    self.scrollView = self._view.togglesc
    self.scrollView:Init(UIHeroItemNewCtrl, UIHeroItemNewView)
    self._ChangePageHandler = EventMgr:AddListener(UIMessageNames.LOTTERY_RECORD_CHANGEPAGE, Bind(self, self._ChangePage))
    self._view.CloseBtn:onClick(function(g)
        self:Close()
    end
    )
    self._view.Btn_Home:onClick(Bind(self, self.ReturnMainUI))

    self._view.toggleLeftArrow:SetOnClick(self, self.ClickLeftArrow)
    self._view.toggleRightArrow:SetOnClick(self, self.ClickRightArrow)

    self._view.TimeTitle:onClick(self, self.SortByTime)
    self._view.TypeTitle:onClick(self, self.SortByPoolId)
    self._view.HeroTitle:onClick(self, self.SortByItemId)

    self.TimeTitleState = self._view.TimeTitle.transform:GetComponent(typeof(CS.UIState))
    self.TypeTitleState = self._view.TypeTitle.transform:GetComponent(typeof(CS.UIState))
    self.HeroTitleState = self._view.HeroTitle.transform:GetComponent(typeof(CS.UIState))
    --titlestate:1:time 2:type 3:hero
    self.titleStates = {}
    self.titleStates[1] = self.TimeTitleState
    self.titleStates[2] = self.TypeTitleState
    self.titleStates[3] = self.HeroTitleState

    --各个排序的升序降序 false为升序 下一次需要降序
    self.sortByTimeOrder = false
    self.sortByTypeOrder = false
    self.sortByHeroOrder = false



    self.numberPrePage = 10 --每页多少个
end

function M:OnEnter(cfg)
    local type = cfg.type
    self:LoadData(type)
    self.datanumber = #self.alldata
    print("Lua Has Data Number :" .. self.datanumber)
    if self.datanumber == 0 then
        --无抽卡记录
        for i = 1, self.numberPrePage do
            self.view["History" .. i]:SetActive(false)
        end
        return
    end
    local pageNumber = math.ceil(self.datanumber / self.numberPrePage)
    print("Lua pageNumber Number :" .. pageNumber)
    self._pageList = {}
    for i = 1, pageNumber do
        local pagedata = {}
        pagedata.selectIndex = i
        pagedata.select = false
        table.insert(self._pageList, pagedata)
    end
    self.PageIndex = 1
    self:_RefPageList()
    -- self:_ChangePage(self.PageIndex)
    -- 以时间降序为默认界面
    self:SortByTime()
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:ClickLeftArrow()
    local temindex = self.PageIndex
    if self.PageIndex > 1 then
        temindex = self.PageIndex - 1
    else
        return
    end
    self:_ChangePage(temindex)
    self.view.togglesc:SetHorizontalNormalizedByIndex(temindex)
end

function M:ClickRightArrow()
    local temindex = self.PageIndex
    if self.PageIndex < #self._pageList then
        temindex = self.PageIndex + 1
    else
        return
    end
    self:_ChangePage(temindex)
    self.view.togglesc:SetHorizontalNormalizedByIndex(temindex)
end

function M:_RefPageList()
    self.scrollView:SetDataList(self._pageList)
    if #self._pageList < 5 then --少于5页不滑动并居中
        self.view.togglesc:SetDragState(false)
        self.view.LayoutCtrl:SetLayout()
    end
end

function M:_ChangePage(index)
    if self._pageList == nil or self.PageIndex == nil then
        return
    end
    self._pageList[self.PageIndex].select = false
    self._pageList[index].select = true
    self:_RefPageList()

    self.PageIndex = index
    local startIndex = (index - 1) * self.numberPrePage
    for i = 1, self.numberPrePage do
        if startIndex + i <= self.datanumber then
            self.view["History" .. i]:SetActive(true)
            self.view["History" .. i]:SetData(self.alldata[startIndex + i])
        else
            self.view["History" .. i]:SetActive(false)
        end
    end

    --设置箭头颜色
    if self.PageIndex == 1 then
        self.view.LeftArrow:SetColor(255, 255, 255, 51)
    else
        self.view.LeftArrow:SetColor(255, 255, 255, 255)
    end

    if self.PageIndex == #self._pageList then
        self.view.RightArrow:SetColor(255, 255, 255, 51)
    else
        self.view.RightArrow:SetColor(255, 255, 255, 255)
    end
end

function M:OnDispose()
    self._pageList = nil
    self.datanumber = nil
    self.PageIndex = nil
    self.alldata = nil
    EventMgr:RemoveListener(UIMessageNames.LOTTERY_RECORD_CHANGEPAGE, self._ChangePageHandler)
    self._ChangePageHandler = nil
    M.super.OnDispose(self)
end

function M:LoadData(type)
    local Calldata = GameHelper.GetLuckDrawData(type)
    self.alldata = {}
    local index = 0 --默认排序
    if Calldata ~= nil then
        for _, value in pairs(Calldata) do
            index = index + 1
            local data = {}
            data.time = value.time
            data.poolId = value.poolId
            data.items = value.items[0]
            data.spTag = value.spTag
            data.index = index
            local temItemData = ConfigHelper.GetCfg("item", data.items)
            data.quality = temItemData.quality
            table.insert(self.alldata, data)
        end
    end
end

function M:SortByTime()
    table.sort(self.alldata, function(a, b)
        local a_time = TimeUtil.ParseLuckDrawTime(a.time)
        local b_time = TimeUtil.ParseLuckDrawTime(b.time)
        if a_time == b_time then
            return a.index < b.index
        else
            if self.sortByTimeOrder then
                return a_time < b_time
            else
                return a_time > b_time
            end
        end
    end)
    self:_ChangePage(1)
    self:ChangeTitleUIState(1, self.sortByTimeOrder)
    self.sortByTimeOrder = not self.sortByTimeOrder
    --重置其他两个的排序
    self.sortByTypeOrder = false
    self.sortByHeroOrder = false
end

function M:SortByPoolId()
    table.sort(self.alldata, function(a, b)
        if a.poolId == b.poolId then
            return a.index < b.index
        else
            if self.sortByTypeOrder then
                return a.poolId > b.poolId
            else
                return a.poolId < b.poolId
            end
        end
    end)
    self:_ChangePage(1)
    self:ChangeTitleUIState(2, self.sortByTypeOrder)
    self.sortByTypeOrder = not self.sortByTypeOrder

    --重置其他两个的排序
    self.sortByTimeOrder = false
    self.sortByHeroOrder = false
end

function M:SortByItemId()
    table.sort(self.alldata, function(a, b)
        if a.items == b.items then
            return a.index < b.index
        else
            if self.sortByHeroOrder then
                return a.quality < b.quality
            else
                return a.quality > b.quality
            end
        end
    end)
    self:_ChangePage(1)
    self:ChangeTitleUIState(3, self.sortByHeroOrder)
    self.sortByHeroOrder = not self.sortByHeroOrder

    --重置其他两个的排序
    self.sortByTimeOrder = false
    self.sortByTypeOrder = false
end

--title:1:time 2:type 3:hero
--state:1:Up 2:Down 3：Mormal
function M:ChangeTitleUIState(title, UOrder)
    for i = 1, #self.titleStates do
        if i == title then
            if UOrder then
                self.titleStates[i]:SetState(1)
            else
                self.titleStates[i]:SetState(2)
            end
        else
            self.titleStates[i]:SetState(3)
        end
    end
end

return LotteryRecordCtrl
