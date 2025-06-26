--[[ 
-----------------------------------------------------
@filename       : CovenantSelectSurePanel
@Description    : 盟约选择确认界面
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('covenant.CovenantSelectSurePanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("covenant/CovenantSelectSurePanel.prefab")


destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
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

   self.m_sureInfo = self:getChildGO("SureInfo")
   self.mYesInputField = self:getChildGO("YesInputField"):GetComponent(ty.InputField)
   self.mPlaceholder = self:getChildGO("Placeholder"):GetComponent(ty.Text)
   self.mSureSelectTxt = self:getChildGO("SureSelectTxt"):GetComponent(ty.Text)
   self.m_cancelBtn = self:getChildGO("CancelBtn")
   self.m_cancelTxt = self:getChildGO("CancelTxt"):GetComponent(ty.Text)
   self.m_okBtn = self:getChildGO("OKBtn")
   self.m_okTxt = self:getChildGO("OKTxt"):GetComponent(ty.Text)
end

function show(self,args)
    self.cusId = args.id
    self.data =  covenant.CovenantManager:getCovenantSelectData(self.cusId)
  
    self.mSureSelectTxt.text =  _TT(41021, _TT(self.data.name))
end

--激活
function active(self)
    super.active(self)
   
    GameDispatcher:addEventListener(EventName.REQ_JOIN_RESULT,self.onResJoinResHandler,self)
    GameDispatcher:addEventListener(EventName.REQ_CHANGE_RESULT,self.onResChangeResHandler,self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.REQ_JOIN_RESULT,self.onResJoinResHandler,self)
    GameDispatcher:removeEventListener(EventName.REQ_CHANGE_RESULT,self.onResChangeResHandler,self)
end


--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mPlaceholder.text =_TT(29533)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.m_okBtn,self.__onOkBtnClick)
    self:addUIEvent(self.m_cancelBtn,self.__onCanacelBtnClick)
end

-- 加入返回结果
function onResJoinResHandler(self,msg)
    if msg == 0 then
        --"加入失败"
        gs.Message.Show(_TT(41028));
    else
        self:onClickClose()
    end
end

-- 变更返回结果
function onResChangeResHandler(self,msg)
    if msg == 0 then
        --"加入失败"
        gs.Message.Show(_TT(41028));
    else
        self:onClickClose()
    end
end

function __onCanacelBtnClick(self)
    self:onClickClose()
end

function __onOkBtnClick(self)
    if string.lower(self.mYesInputField.text) == "yes" then
        local forcesId = covenant.CovenantManager:getForcesId()
        if forcesId == 0 then
            GameDispatcher:dispatchEvent(EventName.REQ_JOIN_FORCES,self.cusId)
        else
            GameDispatcher:dispatchEvent(EventName.REQ_CHANGE_FORCES,self.cusId)
        end
    else
        gs.Message.Show(_TT(41026));
    end
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
