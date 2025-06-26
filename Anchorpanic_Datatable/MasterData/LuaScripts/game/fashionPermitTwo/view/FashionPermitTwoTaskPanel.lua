module('fashionPermitTwo.FashionPermitTwoTaskPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("fashionPermitTwo/FashionPermitTwoTaskPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle("任务")
    self:setBg("fashionPermit_bg.jpg", false, "fashionPermit")
end

--析构  
function dtor(self)
end


function initData(self)
    self.mScrollerHeight = 0
end

-- 初始化
function configUI(self)
    self.mTaskScroller = self:getChildGO("mTaskScroller"):GetComponent(ty.LyScroller)
    self.mTaskScroller:SetItemRender(fashionPermitTwo.FashionPermitTwoTaskItem)

    self.mBtnAll = self:getChildGO("mBtnAll")
    self.mAutoReceive = self:getChildGO("mAutoReceive")
end

--激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_FASHIONPERMIT_TWO_TASK_PANEL,self.showPanel,self)
    self:showPanel()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:removeEventListener(EventName.UPDATE_FASHIONPERMIT_TWO_TASK_PANEL,self.showPanel,self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnAll,self.onClickBtnAll)
end

function showPanel(self)
    local taskList = fashionPermitTwo.FashionPermitTwoManager:getFashionPermitTaskData()
  
    for i = 1, 5 do
        taskList[i].tweenId = i * 2
    end
  
    if (self.mTaskScroller.Count <= 0) then
        self.mTaskScroller.DataProvider = taskList
    else
        self.mTaskScroller:ReplaceAllDataProvider(taskList)
    end

    local canGet = fashionPermitTwo.FashionPermitTwoManager:canGetTask()
    self.mAutoReceive:SetActive(canGet)

    if self.mScrollerHeight == 0 then
        self.mScrollerHeight = self.mTaskScroller:GetComponent(ty.RectTransform).sizeDelta.y
    end
   
    local height = self.mAutoReceive.activeSelf == true and (self.mScrollerHeight - self.mAutoReceive:GetComponent(ty.RectTransform).rect.height) or self.mScrollerHeight
    gs.TransQuick:SizeDelta02(self.mTaskScroller:GetComponent(ty.RectTransform), height)
end

function onClickBtnAll(self)
--    local taskList = fashionPermit.FashionPermitManager:getFashionPermitTaskData()
    GameDispatcher:dispatchEvent(EventName.REQ_GAIN_FASHION_PERMIT_TWO_TASK,{taskId = 0})
end

return _M