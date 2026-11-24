
SLGScrollableImageView = {}

SLGScrollableImageView.__index = SLGScrollableImageView

local overlayPool = {}


local function GetOverlayItem(this, overlayData)
    local overlayType = overlayData.type
    local pool = overlayPool[overlayType]

    if pool and #pool > 0 then
        local item = pool[#pool]
        pool[#pool] = nil

        if item.transform.parent ~= this.overlayContainer then
            item.transform:SetParent(this.overlayContainer, false)
        end

        item.transform.localScale = Vector3.one
        item.transform.anchoredPosition = overlayData.position
        item.gameObject:SetActive(true)


        if item.UpdateData then
            item:UpdateData(overlayData)
        end

        return item
    end


    local prefab = overlayData.prefab
    if prefab then
        local obj = GameObject.Instantiate(prefab)
        if obj then
            local objTF = obj:GetComponent("RectTransform")
            objTF:SetParent(this.overlayContainer, false)
            objTF.localScale = Vector3.one

            local itemClass = _G[overlayData.className]
            if itemClass then
                local item = itemClass.New(obj)
                item.className = overlayData.className
                item.gameObject = obj
                item.transform = objTF

                if item.Init then
                    item:Init()
                end

                if item.UpdateData then
                    item:UpdateData(overlayData)
                end

                objTF.anchoredPosition = overlayData.position

                return item
            else
                GameObject.DestroyImmediate(obj)
            end
        end
    end

    return nil
end


local function RecycleOverlayItem(item)
    if item.tween then
        item.tween:Kill(false)
        item.tween = nil
    end

    if item.Clear then
        item:Clear()
    end

    item.gameObject:SetActive(false)

    local overlayType = item.className
    if not overlayPool[overlayType] then
        overlayPool[overlayType] = {}
    end

    table.insert(overlayPool[overlayType], item)
end


SLGScrollableImageView.PreloadOverlays = function(className, prefab, count)
    local pool = {}

    for i = 1, count do
        local obj = GameObject.Instantiate(prefab)
        if obj then
            local objTF = obj:GetComponent("RectTransform")
            objTF.anchoredPosition = Vector2(10000, 10000)

            local itemClass = _G[className]
            if itemClass then
                local item = itemClass.New(obj)
                item.className = className
                item.gameObject = obj
                item.transform = objTF

                if item.Init then
                    item:Init()
                end

                table.insert(pool, item)
            else
                GameObject.DestroyImmediate(obj)
            end
        end
    end

    overlayPool[className] = pool
end


SLGScrollableImageView.ClearPool = function(className)
    local pool = overlayPool[className]
    if pool then
        for i = 1, #pool do
            local item = pool[i]
            if item.Destroy then
                item:Destroy()
            end
            GameObject.DestroyImmediate(item.gameObject)
        end
        overlayPool[className] = nil
    end
end


SLGScrollableImageView.ClearAllPools = function()
    for className, pool in pairs(overlayPool) do
        SLGScrollableImageView.ClearPool(className)
    end
end


SLGScrollableImageView.New = function(gameObject)
    local self = {}
    setmetatable(self, SLGScrollableImageView)

    self.gameObject = gameObject
    self.rectTransform = gameObject:GetComponent("RectTransform")
    self.scrollRect = gameObject:GetComponent("ScrollRect")
    self.content = self.scrollRect.content

    self.overlayContainer = self.content:Find("OverlayContainer")
    self.backgroundImage = self.content:Find("BackgroundImage")



    self.viewWidth = 0
    self.viewHeight = 0
    self.contentWidth = 0
    self.contentHeight = 0


    self.contentPosX = 0
    self.contentPosY = 0
    self.currentPosX = 0
    self.currentPosY = 0


    self.visibleOverlays = {}
    self.overlayDataList = {}


    self.onScrollCallback = nil
    self.onClickCallback = nil


    self.updateHandler = function()
        self:UpdateVisibleOverlays()
    end

    return self
end


function SLGScrollableImageView:SetViewParams(viewWidth, viewHeight, contentWidth, contentHeight)
    if viewWidth and viewHeight then
        self.viewWidth = viewWidth
        self.viewHeight = viewHeight

    else
        local sizeDelta = self.rectTransform.sizeDelta
        self.viewWidth = sizeDelta.x
        self.viewHeight = sizeDelta.y
    end

    if contentWidth and contentHeight then
        self.contentWidth = contentWidth
        self.contentHeight = contentHeight
        self.content.sizeDelta = Vector2(contentWidth, contentHeight)


        if self.overlayContainer then
            self.overlayContainer.sizeDelta = Vector2(contentWidth, contentHeight)
        end


        if self.backgroundImage then
            self.backgroundImage.sizeDelta = Vector2(contentWidth, contentHeight)
        end
    else
        if self.contentWidth == 0 or self.contentHeight == 0 then

            local contentSize = self.content.sizeDelta
            self.contentWidth = contentSize.x
            self.contentHeight = contentSize.y
        end
    end
end


local function ParseUnderscoreSeparatedString(str)
    if not str or str == "" then
        return {}
    end

    local result = {}
    local tempStr = str


    while true do
        local pos = string.find(tempStr, "_")
        if pos then

            table.insert(result, string.sub(tempStr, 1, pos - 1))

            tempStr = string.sub(tempStr, pos + 1)
        else

            table.insert(result, tempStr)
            break
        end
    end

    return result
end


function SLGScrollableImageView:SetBackImages(prefab, images)
    if not images or #images == 0 then
        return
    end

    local w = 0
    local h = 0
    for k, v in pairs(images) do
        local texturePath = "Assets/_BundleResources/Images/SeasonSLG/SmallMap/" .. v .. ".png"
        local texture = LuaMgr.GetTexture(texturePath)

        local posList = ParseUnderscoreSeparatedString(v)
        local x = tonumber(posList[2])
        local y = tonumber(posList[3]) or 0

        local obj = GameObject.Instantiate(prefab)
        if obj then
            local objTF = obj:GetComponent("RectTransform")
            local image = obj:GetComponent("RawImage")
            image.texture = texture
            image:SetNativeSize()
            objTF:SetParent(self.backgroundImage,false)

            objTF.localScale = Vector3.one
            objTF.anchoredPosition = Vector2(x * objTF.sizeDelta.x, - y * objTF.sizeDelta.y)
            w = math.max(w, ((x+1) * objTF.sizeDelta.x))
            h = math.max(h, ((y+1) * objTF.sizeDelta.y))
        end
    end

    self:SetViewParams(w, h, w, h)
end


function SLGScrollableImageView:AddOverlay(overlayData)
    table.insert(self.overlayDataList, overlayData)


    local overlayPos = overlayData.position
    local contentPos = self.content.anchoredPosition

    local visibleLeft = -contentPos.x
    local visibleRight = visibleLeft + self.viewWidth
    local visibleTop = -contentPos.y
    local visibleBottom = visibleTop - self.viewHeight

    local isWithinView = overlayPos.x >= visibleLeft and overlayPos.x <= visibleRight and
                         overlayPos.y <= visibleTop and overlayPos.y >= visibleBottom

    if isWithinView then
        local item = GetOverlayItem(self, overlayData)
        if item then
            item.position = overlayData.position
            self.visibleOverlays[tostring(#self.overlayDataList)] = item
        end
    end
end


function SLGScrollableImageView:AddOverlays(overlaysData)
    for i = 1, #overlaysData do
        self:AddOverlay(overlaysData[i])
    end
end


function SLGScrollableImageView:UpdateVisibleOverlays()
    if not self.content or LuaMgr.IsObjectNull(self.content) then
        return
    end


    local pos = self.content.anchoredPosition
    local contentX, contentY = pos.x, pos.y

    if contentX ~= self.currentPosX or contentY ~= self.currentPosY then
        self.contentPosX = contentX
        self.contentPosY = contentY
        self.currentPosX = contentX
        self.currentPosY = contentY
    end


    local visibleLeft = -self.currentPosX
    local visibleRight = visibleLeft + self.viewWidth
    local visibleTop = -self.currentPosY
    local visibleBottom = visibleTop - self.viewHeight


    for key, overlay in pairs(self.visibleOverlays) do
        local overlayPos = overlay.transform.anchoredPosition
        local isWithinView = overlayPos.x >= visibleLeft and overlayPos.x <= visibleRight and
                             overlayPos.y <= visibleTop and overlayPos.y >= visibleBottom

        if not isWithinView then
            RecycleOverlayItem(overlay)
            self.visibleOverlays[key] = nil
        end
    end


    for i = 1, #self.overlayDataList do
        local overlayData = self.overlayDataList[i]
        local overlayPos = overlayData.position

        local isWithinView = overlayPos.x >= visibleLeft and overlayPos.x <= visibleRight and
                             overlayPos.y <= visibleTop and overlayPos.y >= visibleBottom

        local isAlreadyVisible = false
        for key, overlay in pairs(self.visibleOverlays) do
            if overlay.position and overlay.position == overlayPos then
                isAlreadyVisible = true
                break
            end
        end

        if isWithinView and not isAlreadyVisible then
            overlayData.position = overlayPos
            local overlay = GetOverlayItem(self, overlayData)
            if overlay then
                overlay.position = overlayPos
                self.visibleOverlays[tostring(i)] = overlay
            end
        end
    end
end


function SLGScrollableImageView:SetOverlayData(overlayDataList)
    self.overlayDataList = overlayDataList or {}


    self:ClearOverlays()


    LuaMgr.AddUpdate(self.updateHandler)
end


function SLGScrollableImageView:ClearOverlays(retainPool)

    for key, overlay in pairs(self.visibleOverlays) do
        RecycleOverlayItem(overlay)
    end
    self.visibleOverlays = {}

    if not retainPool then

        for overlayType, pool in pairs(overlayPool) do
            for i = 1, #pool do
                local item = pool[i]
                if item.Destroy then
                    item:Destroy()
                end
                GameObject.DestroyImmediate(item.gameObject)
            end
            overlayPool[overlayType] = {}
        end
    end
end


function SLGScrollableImageView:Clear(retainPool)

    self:ClearOverlays(retainPool)


    LuaMgr.RemoveUpdate(self.updateHandler)
end


function SLGScrollableImageView:ScrollToPosition(x, y, animated)
    local targetPos = Vector2(-x, -y)

    if animated then
        local startPos = self.content.anchoredPosition

        local tween = DOTween.To(
            function() return self.content.anchoredPosition end,
            function(vec) self.content.anchoredPosition = vec end,
            targetPos, 0.3)
    else
        self.content.anchoredPosition = targetPos
    end
end


function SLGScrollableImageView:GetOverlayCount()
    return #self.overlayDataList
end


function SLGScrollableImageView:GetVisibleOverlayCount()
    local count = 0
    for _, _ in pairs(self.visibleOverlays) do
        count = count + 1
    end
    return count
end


function SLGScrollableImageView:GetImageCoordinate(worldPoint)
    local localPoint = self.content:InverseTransformPoint(worldPoint)
    return localPoint
end


function SLGScrollableImageView:SetZoom(scale)
    if self.scrollRect then
        self.scrollRect.zoomFactor = scale
    end
end