module("StateButton", Class.impl())

function ctor(self)
    self:initData()
end

function initData(self)
    self.m_prefabName = UrlManager:getUIPrefabPath("compent/StateButton.prefab")
    self.mTxtName = "m_textContent"
    self.m_imgNormalName = "m_imgNormal"
    self.m_imgSelectName = "m_imgSelect"
    self.m_imgTipName = "m_imgTip"

    -- 物品相关
    self.m_stateButtonGo = nil
    self.m_childGos = nil
    self.m_childTrans = nil

    -- 数据
    self.m_isSelect = nil
    self.m_paramData = nil
    self.m_fontNormalColor = nil
    self.m_fontSelectColor = nil
    self.m_fontOffsetNomal = nil
	self.m_fontOffsetSelect = nil
end

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function poolRecover(self)
    self:__reset()
    gs.GOPoolMgr:Recover(self.m_stateButtonGo, self.m_prefabName)
    self.m_stateButtonGo = nil
    self.m_childGos = nil
    self.m_childTrans = nil
    LuaPoolMgr:poolRecover(self)
end

function __reset(self)
    self:setSelectState(false)
    self.m_paramData = nil
end

function __getGo(self)
    if (not self.m_stateButtonGo) then
        self.m_stateButtonGo = gs.GOPoolMgr:Get(self.m_prefabName)
        self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(self.m_stateButtonGo)
    end
    if (self.m_stateButtonGo) then
        return self.m_stateButtonGo
    end
    return nil
end

function addParent(self, cusParentTrans)
    local go = self:__getGo()
    if (not go) then
        return
    end
    go.transform:SetParent(cusParentTrans, false)
    self:__initGo()
end

function __initGo(self)
    local rect = self.m_stateButtonGo:GetComponent(ty.RectTransform)
    gs.TransQuick:LPos(rect, 0, 0, 0)
    gs.TransQuick:Scale(rect, 1, 1, 1)
end

-- 设置data
function setData(self, cusPosX, cusPosY, cusWidth, cusHeight, normalAssetName, selectAssetName, cusContent, cusFontSize, cusIsBlod, cusParamData, fontNormalColor, fontSelectColor, fontOffsetNomal, fontOffsetSelect, fontLineSpace, cusTextAlignment)
    local go = self:__getGo()
    if (not go) then
        return
    end

    if (fontNormalColor) then
        if (string.starts(fontNormalColor, "#")) then
            fontNormalColor = string.gsub(fontNormalColor, "#", "")
        elseif (string.starts(fontNormalColor, "0x")) then
            fontNormalColor = string.gsub(fontNormalColor, "0x", "")
        end
        self.m_fontNormalColor = fontNormalColor
    end
    if (fontSelectColor) then
        if (string.starts(fontSelectColor, "#")) then
            fontSelectColor = string.gsub(fontSelectColor, "#", "")
        elseif (string.starts(fontSelectColor, "0x")) then
            fontSelectColor = string.gsub(fontSelectColor, "0x", "")
        end
        self.m_fontSelectColor = fontSelectColor
    end
    if fontOffsetNomal then
        self.m_fontOffsetNomal = fontOffsetNomal
    end
    self:setFontOffset(self.m_fontOffsetNomal)

    if fontOffsetSelect then
        self.m_fontOffsetSelect = fontOffsetSelect
    end

    self:setSize(cusWidth, cusHeight)
    self:setAsset(normalAssetName, selectAssetName)
    if (cusContent ~= nil) then
        self:setText(cusContent, cusFontSize, cusIsBlod, fontLineSpace, cusTextAlignment)
    end
    if (cusPosX ~= nil and cusPosY ~= nil) then
        self:setPosition(cusPosX, cusPosY, 0)
    end
    if (cusParamData ~= nil) then
        self:setParamData(cusParamData)
    end
end

-- 设置文字大小
function setFontSize(self, cusFontSize)
end

-- 设置加粗
function setBlod(self, cusIsBlod)
end

-- 设置大小
function setSize(self, cusWidth, cusHeight)
    local imgNormalGo = self.m_childGos[self.m_imgNormalName]
    local imgSelectGo = self.m_childGos[self.m_imgSelectName]
    self:__setGoSize(imgNormalGo, cusWidth, cusHeight)
    self:__setGoSize(imgSelectGo, cusWidth, cusHeight)
    self:__setGoSize(self.m_stateButtonGo, cusWidth, cusHeight)
end

-- 设置具体物体大小
function __setGoSize(self, cusGo, cusWidth, cusHeight)
    local rect = cusGo:GetComponent(ty.RectTransform)
    rect.sizeDelta = gs.Vector2(cusWidth, cusHeight)
end

-- 设置资源(资源名全名)
function setAsset(self, normalAssetName, selectAssetName)
    local imgNormalScript = self.m_childGos[self.m_imgNormalName]:GetComponent(ty.AutoRefImage)
    -- imgNormalScript.sprite = AssetLoader.GetAsset(normalAssetName)
    imgNormalScript:SetImg(normalAssetName, false)
    -- AssetLoader.ReleaseAsset(normalAssetName)
    local imgSelectScript = self.m_childGos[self.m_imgSelectName]:GetComponent(ty.AutoRefImage)
    -- imgSelectScript.sprite = AssetLoader.GetAsset(selectAssetName)
    imgSelectScript:SetImg(selectAssetName, false)
    -- AssetLoader.ReleaseAsset(selectAssetName)
end

-- 设置文本
function setText(self, cusContent, cusFontSize, cusIsBlod, cusLineSpace, cusAlignment)
    local textScript = self.m_childTrans[self.mTxtName]:GetComponent(ty.Text)
    textScript.text = cusContent
    if (cusFontSize == nil) then
        textScript.fontSize = 24
    else
        textScript.fontSize = cusFontSize
    end
    if (cusIsBlod == nil or cusIsBlod == false) then
        textScript.fontStyle = gs.FontStyle.Normal
    else
        textScript.fontStyle = gs.FontStyle.Bold
	end
	if cusLineSpace then
		textScript.lineSpacing = cusLineSpace
	end
	if cusAlignment then
        textScript.alignment = cusAlignment
	end
end

-- 设置提示图
function setTipImg(self, source, x, y)
    local goTip = self.m_childGos[self.m_imgTipName]
    if(source)then
        goTip:SetActive(true)
        local imgTipScript = goTip:GetComponent(ty.AutoRefImage)
        imgTipScript:SetImg(source, true)
        local rectTipScript = goTip:GetComponent(ty.RectTransform)
        gs.TransQuick:LPos(rectTipScript, x or 0, y or 0, 0)
    else
        goTip:SetActive(false)
    end
end

-- 设置坐标(锚点在左上角)
function setPosition(self, cusPosX, cusPosY, cusPosZ)
    local rect = self.m_stateButtonGo:GetComponent(ty.RectTransform)
    gs.TransQuick:LPos(rect, cusPosX, cusPosY, cusPosZ)
end

-- 设置参数
function setParamData(self, cusParamData)
    self.m_paramData = cusParamData
end

-- 获取参数
function getParamData(self)
    return self.m_paramData
end

-- 设置字体偏移量（左下右上）
function setFontOffset(self, offset)
    offset = offset or { 0, 0, 0, 0 }
    local rect = self.m_childTrans[self.mTxtName]:GetComponent(ty.RectTransform)
    gs.TransQuick:Offset(rect, offset[1], offset[2], -offset[3], -offset[4])
end

-- 设置是否选中状态
function setSelectState(self, cusIsSelect)
    local imgNormalGo = self.m_childGos[self.m_imgNormalName]
    local imgSelectGo = self.m_childGos[self.m_imgSelectName]
    if (imgSelectGo.activeSelf == cusIsSelect) then
        return
    else
        local textScript = self.m_childTrans[self.mTxtName]:GetComponent(ty.Text)
        local rect = self.m_childTrans[self.mTxtName]:GetComponent(ty.RectTransform)
        if (cusIsSelect) then
            imgSelectGo:SetActive(true)
            imgNormalGo:SetActive(false)

            if (self.m_fontSelectColor) then
                textScript.color = gs.ColorUtil.GetColor(self.m_fontSelectColor)
            end

            if self.m_fontOffsetSelect then
                self:setFontOffset(self.m_fontOffsetSelect)
            else
                self:setFontOffset(self.m_fontOffsetNomal)
            end

        else
            imgSelectGo:SetActive(false)
            imgNormalGo:SetActive(true)

            if (self.m_fontNormalColor) then
                textScript.color = gs.ColorUtil.GetColor(self.m_fontNormalColor)
            end
            self:setFontOffset(self.m_fontOffsetNomal)
        end
    end
end

-- 获取是否选中状态
function getSelectState(self)
    local imgSelectGo = self.m_childGos[self.m_imgSelectName]
    if (imgSelectGo) then
        return imgSelectGo.activeSelf
    end
    return nil
end

function addBubble(self, source,  x, y, num, showType, moduleType)
    RedPointManager:add(self.m_stateButtonGo.transform, source, x, y, num, showType, moduleType)
end

function removeBubble(self)
    RedPointManager:remove(self.m_stateButtonGo.transform)
end

-- 为组件加入侦听点击事件
function addOnClick(self, callBack, soundPath, ...)
    if self.m_stateButtonGo == nil then
        Debug:log_error("StateButton", "添加点击监听失败")
        return
    end
    local params = nil
    if select("#", ...) > 0 then
        params = { ... }
    end
    local func = function()
        if(soundPath == nil)then
            AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath("ui_basic_click.prefab"))
        else
            AudioManager:playSoundEffect(soundPath)
        end
        if params then
            callBack(self, unpack(params))
        else
            callBack(self)
        end
    end
    gs.UIComponentProxy.AddListener(self.m_stateButtonGo, func)
end

-- 为组件移除侦听点击事件
function removeOnClick(self)
    if self.m_stateButtonGo == nil then
        Debug:log_error("StateButton", "移除点击监听失败")
        return
    end
    gs.UIComponentProxy.RemoveListener(self.m_stateButtonGo)
end

return _M