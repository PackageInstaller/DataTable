--[[ 
-----------------------------------------------------
@filename       : CovenantSelectPanel
@Description    : 盟约选择不能变更界面
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('covenant.CovenantSelectNotChangePanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("covenant/CovenantSelectNotChangePanel.prefab")


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

   self.mNotChangeInfo = self:getChildGO("NotChangeInfo")
   self.mInfoTxt = self:getChildGO("InfoTxt"):GetComponent(ty.Text)
   self.mTipTxt = self:getChildGO("TipTxt"):GetComponent(ty.Text)
   self.mInfoTimeTxt = self:getChildGO("InfoTimeTxt"):GetComponent(ty.Text)
   self.mNotChangeBtn = self:getChildGO("NotChangeBtn")

   LoopManager:addTimer(0,0,self,self.__setTime) 
end

function __setTime(self)
    local runChangeTime = covenant.CovenantManager:getChangeTime()
    local clientTime = GameManager:getClientTime()

    local reamainTime  =  runChangeTime- clientTime
    if(reamainTime <= 0) then
        self:onClickClose()
        return
    end

    local hours = math.floor((reamainTime % 86400)/3600)
    local mins = math.floor((reamainTime % 3600)/60)
    local secs = reamainTime % 60

    local s = _TT(29550, hours, mins, secs)
    self.mInfoTimeTxt.text = _TT(41025,s)
end

--激活
function active(self)
    super.active(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    LoopManager:removeTimer(self,self.__setTime)
end


--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mInfoTxt.text = _TT(41023)
    self.mTipTxt.text = _TT(41024)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mNotChangeBtn,self.__onNotChangeBtnClick)
end

function  __onNotChangeBtnClick(self)
    self:onClickClose()
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
