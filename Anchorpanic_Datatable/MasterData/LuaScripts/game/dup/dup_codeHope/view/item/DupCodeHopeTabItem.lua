--[[ 
-----------------------------------------------------
@filename       : DupCodeHopeTabItem
@Description    : 代号·希望副本章节页签
@date           : 2021-05-13 14:58:45
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup.dup_codeHope.view.item.DupCodeHopeTabItem', Class.impl(BaseReuseItem))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupCodeHope/DupCodeHopeTabItem.prefab")


--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mBtnNomal = self:getChildGO("mBtnNomal")
    self.mBtnSelect = self:getChildGO("mBtnSelect")

    self.mTxtSelect = self:getChildGO("mTxtSelect"):GetComponent(ty.Text)
    self.mTxtSelectId = self:getChildGO("mTxtSelectId"):GetComponent(ty.Text)
    self.mSelectComlete = self:getChildGO("mSelectComlete")
    self.mTxtSelectComlete = self:getChildGO("mTxtSelectComlete"):GetComponent(ty.Text)
    self.mSelectProgress = self:getChildGO("mSelectProgress")
    self.mTxtSelectProgress = self:getChildGO("mTxtSelectProgress"):GetComponent(ty.Text)

    self.mImgLock = self:getChildGO("mImgLock")
    self.mTxtNomal = self:getChildGO("mTxtNomal"):GetComponent(ty.Text)
    self.mTxtNomalId = self:getChildGO("mTxtNomalId"):GetComponent(ty.Text)
    self.mNomalComlete = self:getChildGO("mNomalComlete")
    self.mTxtNomalComlete = self:getChildGO("mTxtNomalComlete"):GetComponent(ty.Text)
    self.mNomalProgress = self:getChildGO("mNomalProgress")
    self.mTxtNomalProgress = self:getChildGO("mTxtNomalProgress"):GetComponent(ty.Text)
end

--激活
function active(self)
    super.active(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnNomal, self.onNomalClick)
end

function setData(self, cusParent, cusData, cusCallBack, cusThisObject)
    self:setParentTrans(cusParent)
    self.data = cusData
    self.page = cusData.page
    self.callBack = cusCallBack
    self.thisObject = cusThisObject

    self:initBar()
    self:updateBar()
end

function initBar(self)
    local selectLan = self.data.selectLan or self.data.nomalLan
    local selectLanId = self.data.selectLanId or self.data.nomalLanId

    self.mTxtNomal.text = self.data.nomalLanId and _TT(self.data.nomalLanId) or self.data.nomalLan
    self.mTxtSelect.text = selectLanId and _TT(selectLanId) or selectLan

    self:setSelect(false)
end

function updateBar(self)
    self.mTxtNomalId.text = self.page
    self.mTxtSelectId.text = self.page
    local isPass = dup.DupCodeHopeManager:getChapterIsPass(self.page)
    local isOpen = dup.DupCodeHopeManager:getChapterIsOpen(self.page)
    local passCount, allCount = dup.DupCodeHopeManager:getChapterProgress(self.page)

    if isPass then
        --self.mNomalComlete:SetActive(true)
        --self.mSelectComlete:SetActive(true)
        self.mTxtNomalId.gameObject:SetActive(true)
        self.mImgLock:SetActive(false)
        --self.mNomalProgress:SetActive(false)
        --self.mSelectProgress:SetActive(false)

        self.mTxtNomalProgress.text = string.format("%.2f", passCount / allCount) * 100 .. "%"
        self.mTxtSelectProgress.text = string.format("%.2f", passCount / allCount) * 100 .. "%"
    else
        --self.mNomalComlete:SetActive(false)
        --self.mSelectComlete:SetActive(false)

        self.mTxtNomalProgress.text = string.format("%.2f", passCount / allCount) * 100 .. "%"
        self.mTxtSelectProgress.text = string.format("%.2f", passCount / allCount) * 100 .. "%"
        if isOpen then
            self.mImgLock:SetActive(false)
            self.mNomalProgress:SetActive(true)
            self.mSelectProgress:SetActive(true)
            self.mTxtNomalId.gameObject:SetActive(true)
            self.mTxtSelectId.gameObject:SetActive(true)
        else
            self.mNomalProgress:SetActive(false)
            self.mSelectProgress:SetActive(false)
            self.mTxtNomalId.gameObject:SetActive(false)
            self.mTxtSelectId.gameObject:SetActive(false)
            self.mImgLock:SetActive(true)
        end
    end

    local isGain = dup.DupCodeHopeManager:chapterAwardIsGain(self.page)
    self.mNomalComlete:SetActive(isGain)
    self.mSelectComlete:SetActive(isGain)

    if isGain then
        self.mNomalProgress:SetActive(false)
        self.mSelectProgress:SetActive(false)

    end
end

function setSelect(self, bool)
    if bool then
        self.mBtnSelect:SetActive(true)
        self.mBtnNomal:SetActive(false)
        
    else
        self.mBtnSelect:SetActive(false)
        self.mBtnNomal:SetActive(true)
    end
end

function updateRed(self, bool)
    if bool then
        RedPointManager:add(self.UITrans, nil, -120, 19)
    else
        RedPointManager:remove(self.UITrans)
    end
end


function onNomalClick(self)
    self.callBack(self.thisObject, self.page)

    self.UIObject:GetComponent(ty.Animator):SetTrigger("click")
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
