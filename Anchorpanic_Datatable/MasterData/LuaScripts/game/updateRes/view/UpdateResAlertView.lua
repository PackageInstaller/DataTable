module("updateRes.UpdateResAlertView", Class.impl(updateRes.UpdateResBaseView))

UIRes = UrlManager:getPrefabPath("updateRes/UpdateResAlertView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
end

-- 设置父容器
function getParentTrans(self)
    return updateRes.alert
end

--初始化UI
function configUI(self)
	super.configUI(self)
    
    self.mGoTipBg = self:getChildGO("mImgTipBg")

    self.m_btnClose = self:getChildGO("gBtnClose")
    self.m_btnNo = self:getChildGO("BtnNo")
    self.m_textNo = self:getChildGO('TextNo'):GetComponent(ty.Text)
    self.m_btnYes = self:getChildGO("BtnYes")
    self.m_textYes = self:getChildGO('TextYes'):GetComponent(ty.Text)
    self.m_btnConfirm = self:getChildGO("BtnConfirm")
    self.m_textConfirm = self:getChildGO('TextConfirm'):GetComponent(ty.Text)
    self.m_textTitle = self:getChildGO('gTxtTitle'):GetComponent(ty.Text)
    self.m_textContent = self:getChildGO('mTxtContent'):GetComponent(ty.Text)
    self.m_rectContent = self:getChildGO('mTxtContent'):GetComponent(ty.RectTransform)
    self.mClickEvent = self.mGoTipBg:GetComponent(ty.LongPressOrClickEventTrigger)

    self.mGroupNormal = self:getChildGO("mGroupNormal")
    self.mGroupSecret = self:getChildGO("mGroupSecret")
    self.mTxtSecret = self:getChildGO('mTxtSecret'):GetComponent(ty.Text)
    self.mBtnSecretBack = self:getChildGO("mBtnSecretBack")
    self.mTxtSecretBack = self:getChildGO('mTxtSecretBack'):GetComponent(ty.Text)
    self.mBtnSecretCollect = self:getChildGO("mBtnSecretCollect")
    self.mTxtSecretCollect = self:getChildGO('mTxtSecretCollect'):GetComponent(ty.Text)
end

--激活
function active(self)
    super.active(self)
	self:addOnClick(self.m_btnClose, self.__onClickCloseHandler)
	self:addOnClick(self.m_btnNo, self.__onClickNoHandler)
	self:addOnClick(self.m_btnYes, self.__onClickYesHandler)
	self:addOnClick(self.m_btnConfirm, self.__onClickConfrimHandler)
    self.mClickEvent.onLongPress:AddListener(function() self:__onLongPressHandler() end)
	self:addOnClick(self.mBtnSecretBack, self.__onClickSecretBackHandler)
	self:addOnClick(self.mBtnSecretCollect, self.__onClickSecretCollectHandler)
end

--非激活
function deActive(self)
    super.deActive(self)
	self:removeOnClick(self.m_btnClose, self.__onClickCloseHandler)
	self:removeOnClick(self.m_btnNo, self.__onClickNoHandler)
	self:removeOnClick(self.m_btnYes, self.__onClickYesHandler)
	self:removeOnClick(self.m_btnConfirm, self.__onClickConfrimHandler)
    self.mClickEvent.onLongPress:RemoveAllListeners()
	self:removeOnClick(self.mBtnSecretBack, self.__onClickSecretBackHandler)
	self:removeOnClick(self.mBtnSecretCollect, self.__onClickSecretCollectHandler)
end

function setData(self, data)
    local tipType = data.tipType
    local title = data.title
    local content = data.content
    local yesStr = data.yesStr
    self.m_yesFun = data.yesFun
    local noStr = data.noStr
    self.m_noFun = data.noFun

    self.m_textTitle.text = title
    self.m_textContent.text = content
    
    -- if(string.getStringCharCount(content) <= 24)then
    --     self.m_textContent.alignment = gs.TextAnchor.MiddleCenter
    -- else
    --     self.m_textContent.alignment = gs.TextAnchor.MiddleLeft           
    -- end

    self.m_textNo.text = noStr or ""
    self.m_textYes.text = yesStr or ""
    self.m_textConfirm.text = yesStr or ""

    if(noStr == nil and self.m_noFun == nil)then
        self.mGoTipBg:SetActive(true)
        self.m_btnNo:SetActive(false)
        self.m_btnYes:SetActive(false)
        self.m_btnConfirm:SetActive(true)
        gs.TransQuick:UIPosY(self.m_rectContent, -63)
    else
        self.mGoTipBg:SetActive(false)
        self.m_btnNo:SetActive(true)
        self.m_btnYes:SetActive(true)
        self.m_btnConfirm:SetActive(false)
        gs.TransQuick:UIPosY(self.m_rectContent, 0)
    end
end

function __onClickCloseHandler(self)
    self:close()
    if(self.m_noFun)then
        self.m_noFun()
    elseif(self.m_yesFun)then
        self.m_yesFun()
    end
end

function __onClickNoHandler(self)
    if(self.m_noFun)then
        self:close()
        self.m_noFun()
    end
end

function __onClickYesHandler(self)
    if(self.m_yesFun)then
        self:close()
        self.m_yesFun()
    end
end

function __onClickConfrimHandler(self)
    if(self.m_yesFun)then
        self:close()
        self.m_yesFun()
    end
end

function __onLongPressHandler(self)
end

function __onClickSecretBackHandler(self)
end

function __onClickSecretCollectHandler(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
