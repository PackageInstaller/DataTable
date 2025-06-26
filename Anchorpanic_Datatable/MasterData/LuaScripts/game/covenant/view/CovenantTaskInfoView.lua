
--[[ 
-----------------------------------------------------
@filename       : CovenantTaskInfoView
@Description    : 盟约任务内容
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]] 
module("covenant.CovenantTaskInfoView", Class.impl(TabSubView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("covenant/CovenantTaskInfoView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setUICode(LinkCode.CovenantTask)
end

function initData(self)
end


-- 初始化
function configUI(self)
    super.configUI(self)
    self.mAllBtn = self:getChildGO("mAllBtn")
    self.mTaskScroll = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mTaskScroll:SetItemRender(covenant.CovenantTaskItem)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mAllBtn,self.onAllBtnClick)
end

--激活
function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_CONVENANT_TASK_PANEL,self.onUpdatePanel,self)
    self:showPanel(true)
end


function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_CONVENANT_TASK_PANEL,self.onUpdatePanel,self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
end

function onUpdatePanel(self)
    self:showPanel()
end

function showPanel(self,isInit)
    self.taskList = covenant.CovenantManager:getTaskData()
    table.sort(self.taskList,function (s1,s2)
        return s1.serverData.state < s2.serverData.state
    end)

    if isInit then
        self.mTaskScroll.DataProvider = self.taskList
    else
        self.mTaskScroll:ReplaceAllDataProvider(self.taskList)
    end
end

function onAllBtnClick(self)
    local getList = {}
    for i=1,#self.taskList do
        if self.taskList[i].serverData.state == 0 then
            table.insert(getList,self.taskList[i].localData.id)
        end
    end
    if #getList> 0 then
        GameDispatcher:dispatchEvent(EventName.REQ_GAIN_CONVENANT_TASK, { list = getList })
    else
        gs.Message.Show(_TT(29560))
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(29560):	"没有可以领取的奖励"
]]
