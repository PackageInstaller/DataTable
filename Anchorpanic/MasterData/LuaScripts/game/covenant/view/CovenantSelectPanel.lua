--[[ 
-----------------------------------------------------
@filename       : CovenantSelectPanel
@Description    : 盟约选择界面
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('covenant.CovenantSelectPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("covenant/CovenantSelectPanel.prefab")


destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setBg("common_bg_10.jpg", false)
end

--析构  
function dtor(self)
end

function initData(self)
    self.mItemList = {}
end

-- 初始化
function configUI(self)
   super.configUI(self)

   self.m_itemContent = self:getChildTrans("ItemContent")

   -- 变更盟约倒计时
   self.mIsChangeBtn = self:getChildGO("IsChangeBtn")
   self.mInfoTxt = self:getChildGO("InfoTxt"):GetComponent(ty.Text)

   self:initView()
end

function initView(self)
    self.voDic = covenant.CovenantManager:getSelectConfigData()
    for i = 1, #self.voDic do
        local item = convert.CovenantSelectItem:poolGet()
        item:setData(self.m_itemContent,self.voDic[i])
        table.insert(self.mItemList,item)
    end

    local joinId = covenant.CovenantManager:getForcesId()

    -- if joinId == 0 then
    --     self.mIsChangeBtn:SetActive(false)
    -- else
    --     LoopManager:addTimer(0,0,self,self.__setChangeTime)
    --     self.mIsChangeBtn:SetActive(true)
    -- end
end

-- function __setChangeTime(self)
--     local runChangeTime = covenant.CovenantManager:getChangeTime()
--     local clientTime = GameManager:getClientTime()
--     local reamainTime  =  runChangeTime - clientTime

--     if(reamainTime<=0) then
--         self.mIsChangeBtn:SetActive(false)
--         LoopManager:removeTimer(self,self.__setChangeTime)
--     else
--         local hours = math.floor((reamainTime % 86400)/3600)
--         local mins = math.floor((reamainTime % 3600)/60)
--         local secs = reamainTime % 60

--         local s = "" 
--         if(hours>1) then
--             s  = hours..":"..mins
--         else
--             s = mins..":"..secs
--         end

--         self.mTimeTxt.text = _TT(41022,s)
--     end
-- end

--激活
function active(self)
    super.active(self)
     -- 打开盟约选择界面详细信息页

    GameDispatcher:addEventListener(EventName.REQ_CHANGE_RESULT,self.onResChangeResHandler,self)
    
    GameDispatcher:addEventListener(EventName.REQ_JOIN_RESULT,self.onResJoinResHandler,self)
  
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    --LoopManager:removeTimer(self,self.__setChangeTime)
    GameDispatcher:removeEventListener(EventName.REQ_CHANGE_RESULT,self.onResChangeResHandler,self)
    --GameDispatcher:removeEventListener(EventName.OPEN_COVENANT_SELECT_INFO_PANEL,self.onOpenCovenantSelectInfoPanelHandler, self)
    GameDispatcher:removeEventListener(EventName.REQ_JOIN_RESULT,self.onResJoinResHandler,self)
  
    self:__clearItem()
end

function onResJoinResHandler(self,msg)
    if msg == 1 then
        self:onClickClose()
    end
end

function onResChangeResHandler(self,msg)
    if msg == 1 then
        self:onClickClose()
    end
end

-- function close(self)
 
--     super.close(self)
--        logError("close")
-- end
--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mInfoTxt.text = _TT(41030)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    
end

function __clearItem(self)
    for i = 1, #self.mItemList do
        self.mItemList[i]:poolRecover()
    end
    self.mItemList = {}
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
