module('bag.BagPropsDetailView', Class.impl("lib.component.BaseContainer"))
UIRes = UrlManager:getUIPrefabPath('bag/BagPropsDetailView.prefab')

--构造函数
function ctor(self)
    super.ctor(self)
end

function configUI(self)
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
end

function __reset(self)
    self:__recoverBtnGoDic()
end

function show(self)
    self.UIObject:SetActive(true)
end

function hide(self)
    self.UIObject:SetActive(false)
    self:__reset()
end

function __getGoUniqueName(self, goName)
    return self.__cname .. "_" .. goName
end

function __getBtnGo(self, goName, type)
    local uniqueName = self:__getGoUniqueName(goName)
    local go = gs.GOPoolMgr:GetOther(uniqueName)
    if (not go or gs.GoUtil.IsGoNull(go)) then
        if (self.m_childGos and self.m_childGos[goName]) then
            go = gs.GameObject.Instantiate(self.m_childGos[goName])
        end
    end
    self.m_btnGoDic[go:GetHashCode()] = { go = go, uniqueName = uniqueName, type = type }
    return go
end

function __recoverBtnGoDic(self)
    if (self.m_btnGoDic) then
        for hashCode, data in pairs(self.m_btnGoDic) do
            self:removeOnClick(data.go)
            gs.GOPoolMgr:RecoverOther(data.uniqueName, data.go)
        end
    end
    self.m_btnGoDic = {}
end

function setData(self, cusPropsId)
    self.m_propsVo = bag.BagManager:getPropsVoById(cusPropsId)
    self:__updateView()
end

function __updateView(self)
    self:__recoverBtnGoDic()
    self:__updateGrid()
    self:__updateBtnUse()
    self:__updateLink()
end

function __updateGrid(self)
    local element_1 = self.m_childTrans["m_element_1"]
    if (not self.m_propsGrid) then
        self.m_propsGrid = PropsGrid:poolGet()
    end
    self.m_propsGrid:setData(self.m_propsVo, element_1)
    self.m_propsGrid:setIsShowName(false)
    self.m_propsGrid:setClickEnable(false)
    self.m_propsGrid:setPosition(gs.Vector3(-120, -70, 0))

    -- self.m_childTrans["mTxtName"]:GetComponent(ty.Text).text = HtmlUtil:color(self.m_propsVo:getName(), ColorUtil:getPropColor(self.m_propsVo.color))
    self.m_childTrans["mTxtName"]:GetComponent(ty.Text).text = self.m_propsVo:getName()
    self.m_childTrans["m_textDes"]:GetComponent(ty.Text).text = string.substitute(_TT(4015), self.m_propsVo:getDes())--"描述：" .. self.m_propsVo:getDes()
end

function __updateBtnUse(self)
    local btnUseElementGo = self.m_childGos["m_element_4"]
    local btnUse = self.m_childGos["BtnUse"]
    if (self.m_propsVo.isCanUse) then
        self:addOnClick(btnUse, self.__onClickUseHandler)
        btnUseElementGo:SetActive(true)
    else
        self:removeOnClick(btnUse)
        btnUseElementGo:SetActive(false)
    end
end

-- 点击使用
function __onClickUseHandler(self)
    props.PropsManager:checkUseProps(self.m_propsVo)
end

function __updateLink(self)
    local linkDataList = { 1, 2, 3 }
    local linkElementGo = self.m_childGos["m_element_3"]
    if (#linkDataList > 0 and (self.m_isShowLink == nil or self.m_isShowLink == true)) then --显示链接
        linkElementGo:SetActive(true)

        local linkItemList = {}
        for i = 1, #linkDataList do
            local linkBtnGo = self:__getBtnGo("m_btnLink", _TT(4016) .. i) --链接
            linkBtnGo.transform:SetParent(linkElementGo.transform, false)
            linkBtnGo:SetActive(true)
            local rect = linkBtnGo:GetComponent(ty.RectTransform)
            gs.TransQuick:Scale(rect, 1, 1, 1)

            local childGos, childTrans = GoUtil.GetChildHash(linkBtnGo)
            childGos["Text"]:GetComponent(ty.Text).text = _TT(4016) .. linkDataList[i] --链接

            self:addOnClick(linkBtnGo, self.__onClickLinkHandler, nil, { go = linkBtnGo })
        end
    else --隐藏链接
        linkElementGo:SetActive(false)
    end
end

-- 点击链接
function __onClickLinkHandler(self, args)
    local data = self.m_btnGoDic[args.go:GetHashCode()]
    gs.Message.Show(_TT(37, data.type)) --"跳转前往" .. data.type
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]