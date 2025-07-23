module("covenant.CovenantHelperAttrItem", Class.impl(BaseComponent))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("covenant/CovenantHelperAttrItem.prefab")

function __initData(self)
    super.__initData(self)

    --一些常用的
    self.m_attrIcon = nil
    self.m_weightIcon = nil
    self.m_textAttrName = nil
    self.m_textAttrValue = nil

    --------------------------------------------- 数据源 self.m_data 为 属性vo 和 属性权重 ---------------------------------------------
end

-- 设置data
function setData(self, cusAttrVo, cusIsAsyn)
    self:__reset()
    if(cusAttrVo)then
        self.m_data = {}
        self.m_data.attrVo = cusAttrVo

        if (cusIsAsyn == nil) then
            cusIsAsyn = true
        end
        if (cusIsAsyn) then
            if (self.m_isLoadFinish) then
                self:__updateView()
            else
                self:__preLoad(cusIsAsyn)
            end
        else
            self:__preLoad(cusIsAsyn)
            self:__updateView()
        end
    end
end

function getData(self)
    return self.m_data.attrVo
end

function __updateCustomView(self)
    self:__initScript()
    self:__updateContent()
end

function __initScript(self)
    self.m_attrIcon = self.m_childGos["IconAttr"]:GetComponent(ty.AutoRefImage)
    self.m_textAttrName = self.m_childGos["TextAttrName"]:GetComponent(ty.Text)
    self.m_textAttrValue = self.m_childGos["TextAttrValue"]:GetComponent(ty.Text)

    self.m_textAddGo = self.m_childGos["TextAddValue"]
    self.m_textAddCanvasGroup = self.m_textAddGo:GetComponent(ty.CanvasGroup)
    self.m_textAddValue = self.m_textAddGo:GetComponent(ty.Text)
end

function __updateContent(self)
    self.m_attrIcon:SetImg(UrlManager:getAttrIconUrl(self.m_data.attrVo.key), true)
    self.m_textAttrName.text = AttConst.getName(self.m_data.attrVo.key)
    self.m_textAttrValue.text = AttConst.getValueStr(self.m_data.attrVo.key, self.m_data.attrVo.value)
    self.m_textAddGo:SetActive(false)
end

function updateData(self, newAttrVo)
    local addValue = newAttrVo.value - self.m_data.attrVo.value
    self.m_data = {}
    self.m_data.attrVo = newAttrVo
    self:__updateContent()
    if(addValue > 0)then
        self.m_textAddValue.text = "+"..addValue
        self.m_textAddGo:SetActive(true)
        local function finishCall()
            self.m_textAddGo:SetActive(false)
        end
        -- local function hideFun()
        --     TweenFactory:canvasGroupAlphaTo(self.m_textAddCanvasGroup, 1, 0, 0.3, nil, finishCall)
        -- end
        -- TweenFactory:canvasGroupAlphaTo(self.m_textAddCanvasGroup, 0, 1, 0.3, nil, hideFun)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
