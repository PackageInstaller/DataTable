--[[   
     英雄招募拨号界面
]]
module('recruit.RecruitDialPanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('recruit/RecruitDial.prefab')

panelType = -1 -- 窗口类型 1 全屏 2 弹窗
isAdapta = 0 --是否开启适配刘海


-- 构造函数
function ctor(self)
    super.ctor(self)
    -- local w, h = ScreenUtil:getScreenSize()
    -- self:setSize(w, h)
    -- self:setTxtTitle('')
    -- self:setBg("", false)
    -- self.gBtnClose:SetActive(false)
    -- self:setPrevent(false)
end

-- 初始化数据
function initData(self)
    self.m_textCodeList = {}
    self.m_btnNumDic = {}
end

-- 初始化
function configUI(self)
    for num = 0, 9 do
        self:getChildGO('TextNum_' .. num):GetComponent(ty.Text).text = tostring(num)
    end
    for num = 0, 9 do
        self.m_btnNumDic[num] = self:getChildGO('BtnNum_' .. num)
    end
    for codeIndex = 1, 6 do
        table.insert(self.m_textCodeList, self:getChildGO('TextCode_' .. codeIndex):GetComponent(ty.Text))
    end

    self.m_btnConfirm = self:getChildGO('BtnNum_confirm')
    self.m_textConfirm = self:getChildGO('TextNum_confirm'):GetComponent(ty.Text)
    self.m_btnDel = self:getChildGO('BtnNum_del')
    self.m_textTip = self:getChildGO('TextTip'):GetComponent(ty.Text)
    self.m_textTipEng = self:getChildGO('TextTipEng'):GetComponent(ty.Text)


    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mImgPrevent = self:getChildGO("mImgPrevent")

    -- self:getChildGO('ImgBg'):SetImg(UrlManager:getBgPath("recruit/recruit_dial_bg.jpg"), false)
end

-- 激活
function active(self, args)
    -- super.active(self, args)
	self.m_callFun = args.callFun
	self.mImgPrevent:SetActive(false)
    self:setGuideTrans("recruit_dial_code", self:getChildTrans("GroupNum"))
end

-- 非激活
function deActive(self)
    super.deActive(self)
    for i = 1, #self.m_textCodeList do
        self.m_textCodeList[i].text = ""
    end
end

function initViewText(self)
    self.m_textConfirm.text = _TT(1) --"确定"
    self.m_textTip.text = _TT(28016) --"请   输   入   六   位   神   秘   代   码"
    self.m_textTipEng.text = _TT(28017) --"P  L  E  A  S  E     E  N  T  E  R     T  H  E     S  I  X     D  I  G  I  T     M  Y  S  T  E  R  I  O  U  S     C  O  D  E"
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.close)
    self:addUIEvent(self.m_btnConfirm, self.onConfirm)
    self:addUIEvent(self.m_btnDel, self.__onClickDelHandler)
    for num = 0, 9 do
        self:addUIEvent(self.m_btnNumDic[num], self.__onClickNumHandler, nil, num)
    end
end

function __onClickDelHandler(self)
    for i = #self.m_textCodeList, 1, -1 do
        if (self.m_textCodeList[i].text ~= "") then
            self.m_textCodeList[i].text = ""
            return
        end
    end
end

function __onClickNumHandler(self, num)
    local isFull = true
    for i = 1, #self.m_textCodeList do
        if (self.m_textCodeList[i].text == "") then
            isFull = false
        end
    end
    if (not isFull) then
        for i = 1, #self.m_textCodeList do
            if (self.m_textCodeList[i].text == "") then
                self.m_textCodeList[i].text = tostring(num)
                if (i ~= #self.m_textCodeList) then
                    return
                end
            end
            -- if(i == #self.m_textCodeList)then
            -- 	if(self.m_callFun)then
            -- 		self.m_callFun()
            -- 		self.m_callFun = nil
            -- 	else
            -- 		Debug:log_error("RecruitDialPanel", "找不到回调函数")
            -- 	end
            -- end
        end
    end
end

function onConfirm(self)
	self.mImgPrevent:SetActive(true)

    if (self.m_callFun) then
        self.m_callFun()
        self.m_callFun = nil
    else
        Debug:log_error("RecruitDialPanel", "找不到回调函数")
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
