---##################### 【CustomBox Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]

local itemIconSpritePath = {
    [1] = Config.SpritePath.WeaponIconPath,
    [2] = Config.SpritePath.EquipIconPath,
    [3] = Config.SpritePath.ItemIconPath,
    [4] = Config.SpritePath.ItemIconPath,
    [5] = Config.SpritePath.ItemIconPath,
}
---%%%%%%%%%%%%%%%%%%%%% 【CustomBox Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
---@class CustomBox : CustomBox_Generate
local CustomBox = require "CustomBox_Generate"

---初始化逻辑，注册装备按钮点击事件和道具锁定状态消息监听
function CustomBox:InitLogic(data)
    self.equipBtn.scaleButton.onClick:AddListener(BindCallback_NoParams(self, self.OnEquipBtnClick))
    self.showEf:SetActive(false)
	GameMsgMgr:regEvent(GameMsgType.RefreshCustomItemLockState, self, self.RecvRefreshCustomItemLockState)

	UIMgr:AddCloseFunc(function (wnd)
		if wnd.msgEventHandler then
			for i,v in ipairs(wnd.msgEventHandler) do
				GameMsgMgr:unRegEvent(v[1], wnd, v[2])
			end
		end
		wnd:AutoReleaseAssets()
		wnd:AutoReleaseTimers()
	end)
end

---设置 mono 对象引用
---@param mono table 父节点对象
function CustomBox:setMono(mono)
    self.mono = mono
end

---根据奖励数据初始化 customData，并调用 refreshUI 刷新界面
---@param data RewardInfo|integer[]
---@param exCustomData CustomBoxData?
function CustomBox:SetUIData(data, exCustomData)
    ---@type CustomBoxData
    local customData = {
        id = 0,
    }
    if data then
        customData.tipsPassEventState = data.tipsPassEventState
    else
        customData.tipsPassEventState = true
    end
    local itemType = GE.RewardType.ItemProp
    if data == nil then
        customData.nullReward = true
        customData.disableClick = true
    elseif #data >= 3 then
        customData.id = data[2]
        itemType = data[1]
        customData.itemType = Me:RewardTypeToItemype(data[1])
        customData.itemNum = data[3]
    else
        itemType = data.type
        customData.id = data.id
        customData.itemType = Me:RewardTypeToItemype(data.type)
        customData.itemNum = data.num
        customData.isFrist = data.isFrist
        if data.extraType == GE.ItemPropType.CharToken then
            itemType = GE.RewardType.ItemProp
            local roleConfig = Config.GetCharacterInfo(data.id)
            customData.itemType = Me:RewardTypeToItemype(GE.RewardType.ItemProp)
            customData.id = roleConfig.getPatch[1][2]
            customData.itemNum = roleConfig.getPatch[1][3]
        end
    end
    
    local cfg = nil
    if itemType == GE.RewardType.Weapon then
        if customData.id == 0 or customData.id == nil then
           customData.nullReward = true
           customData.disableClick = true
        else
            local serverData = Me:getWeaponDataById(customData.id)
            if serverData ~= nil then
                cfg = Config.GetWeaponInfo(serverData.cid)
                customData.isLock = serverData.isLock
                customData.itemNum = "+" .. serverData.level
                customData.CanLock = true
                customData.rid = serverData.id
                customData.id = serverData.cid
            else
                cfg = Config.GetWeaponInfo(customData.id)
                if cfg == nil then
                   LuaLogger.es("武器数据错误 id:" .. customData.id)
                   return
                end
            end
            customData.itemNameTxt = cfg.name
        end
    elseif itemType == GE.RewardType.Equipment then
        if customData.id == 0 or customData.id == nil then
           customData.nullReward = true
           customData.disableClick = true
        else
            local serverData = Me:getEquipDataByid(customData.id)
            if serverData ~= nil then
                cfg = Config.GetEquipmentInfo(serverData.cid)
                customData.isLock = serverData.isLock
                customData.itemNum = "Lv." .. serverData.level
                customData.CanLock = true
                customData.rid = serverData.id
                customData.id = serverData.cid
                customData.star = serverData.star
            else
                cfg = Config.GetEquipmentInfo(customData.id)
                if cfg == nil then
                   LuaLogger.es("装备数据错误 id:" .. customData.id)
                   return
                end
                customData.star = cfg.basicStar
                customData.itemNum = "Lv.1"
            end
            customData.itemNameTxt = cfg.name
        end
       
    elseif itemType == GE.RewardType.Skin then
        cfg = Config.GetCharacterSkinInfo(customData.id)
        if cfg == nil then
            customData.nullReward = true
            customData.disableClick = true
        else
            customData.itemNameTxt = cfg.skinName
        end
        customData.itemNum = nil
    elseif itemType == GE.RewardType.Character then
        cfg = Config.GetCharacterInfo(customData.id)
        if cfg == nil then
            customData.nullReward = true
            customData.disableClick = true
        else
            customData.itemNameTxt = cfg.name
        end
        customData.itemNum = nil
    elseif itemType == GE.RewardType.Affection then
        customData.id = Config.GetConfigInfo("AffectionItem")
        itemType = GE.ItemTypeIndex.item
        customData.itemType = Me:RewardTypeToItemype(itemType)
    else
        cfg = Config.GetItemInfo(customData.id)
        if cfg == nil then
           customData.nullReward = true
           customData.disableClick = true
        else
            customData.itemNameTxt = cfg.itemName
        end
    end

    if exCustomData ~= nil then
        for k, v in pairs(exCustomData) do
            customData[k] = v
        end
    end
    self:refreshUI(customData)
end

---@class CustomBoxData
---@field scale number
---@field id number
---@field itemType GE.ItemTypeIndex
---@field itemNum number|string
---@field itemNameTxt string
---@field star number
---@field isLock boolean
---@field isGet boolean
---@field isSelect boolean
---@field ownerId number
---@field isFrist boolean
---@field tipsText string
---@field isIn boolean
---@field isInIsOne boolean
---@field inCountTxtState boolean
---@field inCountTxt string
---@field nullReward boolean
---@field ownerPanelName string
-------------------------------
---@field rid integer 
---@field disableClick boolean  是否禁用点击时间 默认false
---@field CanLock boolean   是否可以锁定 默认 false
---@field clickSound string
---@field tipsPassEventState boolean 默认true
---@field navType GE.NavigationType
---@field showItemName boolean 是否显示道具名字 默认false
---@field needNum integer 需要的数量，用于提示界面显示

---根据 CustomBoxData 刷新 UI 所有显示元素
---@param data CustomBoxData
function CustomBox:refreshUI(data)
    self.customData = data
    if data.scale then
        self.transform.localScale = Vector3.New(data.scale, data.scale, 1)
    end
    self:addListener()
    self:onLongpressListener()
    self:onUpListener()
    self:onDownListener()
    if data.nullReward then
        self.hasDataPanel:SetActive(false)
        self.nullDelItem:SetActive(false)
        self.nullTaskItem:SetActive(false)
        self.nullReward:SetActive(true)
        self.nullDataPanel:SetActive(false)
        return
    end
    if data.nullDelItem then
        self.hasDataPanel:SetActive(false)
        self.nullDelItem:SetActive(true)
        self.nullTaskItem:SetActive(false)
        self.nullReward:SetActive(false)
        self.nullDataPanel:SetActive(false)
        return
    end
    if data.nullDataPanel then
        self.hasDataPanel:SetActive(false)
        self.nullDelItem:SetActive(false)
        self.nullTaskItem:SetActive(false)
        self.nullReward:SetActive(false)
        self.nullDataPanel:SetActive(true)
        return
    end
    self.hasDataPanel:SetActive(true)
    self.nullDelItem:SetActive(false)
    self.nullTaskItem:SetActive(false)
    self.nullReward:SetActive(false)
    self.nullDataPanel:SetActive(false)
    
    if not data.id or not data.itemType then
        return
    end
    self.curShowCfg = nil
    if data.itemType == GE.ItemTypeIndex.weapon then
        self.curShowCfg = Config.GetWeaponInfo(data.id)
    elseif data.itemType == GE.ItemTypeIndex.equip then
        self.curShowCfg = Config.GetEquipmentInfo(data.id)
    elseif data.itemType == GE.ItemTypeIndex.debris then
        self.curShowCfg = Config.GetItemInfo(data.id)
    elseif data.itemType == GE.ItemTypeIndex.materials then
        self.curShowCfg = Config.GetItemInfo(data.id) 
    elseif data.itemType == GE.ItemTypeIndex.item then
        self.curShowCfg = Config.GetItemInfo(data.id)
    elseif data.itemType == GE.ItemTypeIndex.Character then
        self.curShowCfg = Config.GetCharacterInfo(data.id)
        self:updataCharIcon()
        self:updataItemNameTxt()
        self:updateIsGet()
        self:updateItemNum()
        self:updateIsLock()
        self:updateIsLock2()
        self:updateIsSp()
        self:updateRank()
        return
    elseif data.itemType == GE.ItemTypeIndex.skin then
        self.curShowCfg = Config.GetCharacterSkinInfo(data.id)
        self:updataSkinIcon()
        self:updataItemNameTxt()
        self:updateIsGet()
        self:updateTypeIcon()
        self:updateItemNum()
        self:updateIsLock()
        self:updateIsLock2()
        self:updateIsSp()
        self:updateRank()
        return
    end

    if not self.curShowCfg then
        LuaLogger.e("CustomBox:InitLogic curShowCfg nil:"..data.id..","..data.itemType)
        return
    end
    --LuaLogger.ds("self.curShowCfg", tablex.dump(self.curShowCfg))
    self.charIcon:SetActive(false)
    if self.curShowCfg.icon then
        self.itemIcon:SetActive(true)
        self.charIcon:SetActive(false)
        self.mono:LoadSpriteAsync(string.format(itemIconSpritePath[data.itemType], self.curShowCfg.icon), self.itemIcon.image)
    else
        self.itemIcon:SetActive(false)
    end
    self.mono:LoadSpriteAsync(self:getRangeImgPath(), self.rangeImg.image)
    self.mono:LoadSpriteAsync(self:getRankBgPath(), self.rankBg.image)
    self:updateStar()
    self:updateIsLock()
    self:updateIsLock2()
    self:updateIsSp()
    self:updateIsGet()
    self:updateItemNum()
    self:updateTypeIcon()
    self:updateSelect()
    self:updateCommonMask()
    self:updateIsEquipIn()
    self:updateRoleIcon()
    self:updateIsIn()
    self:updateDelBtn()
    self:updataItemNameTxt()
    self:updateIsFrist()
    self:updateNew()
    self:updateOverload()
end

---更新星级显示，根据 customData.star 控制各星级图标的显隐
function CustomBox:updateStar()
    if not self.customData.star then
        self.starList:SetActive(false)
        return
    end
    self.starList:SetActive(true)
    for i = 1, 6 do
        if i <= self.customData.star then
            self["star_"..i]:SetActive(true)
        else
            self["star_"..i]:SetActive(false)
        end
    end
end

---更新锁定标记（isLock）的显隐状态
function CustomBox:updateIsLock()
    if not self.customData.isLock then
        self.isLock:SetActive(false)
        return
    end
    self.isLock:SetActive(self.customData.isLock)
end

---更新第二锁定标记（isLock2）的显隐状态
function CustomBox:updateIsLock2()
    if not self.customData.isLock2 then
        self.isLock2:SetActive(false)
        return
    end
    self.isLock2:SetActive(self.customData.isLock2)
end

---更新 SP 装备标记显隐，SP 装备时隐藏锁定标记
function CustomBox:updateIsSp()
    if self.customData.itemType == GE.ItemTypeIndex.equip and self.curShowCfg and self.curShowCfg.equipType == GE.EquipType.sp then
        self.isSp:SetActive(true)
        self.isLock:SetActive(false)
        self.isLock2:SetActive(false)
        return
    end
    self.isSp:SetActive(false)
end

function CustomBox:updateRank()

    self.mono:LoadSpriteAsync(self:getRangeImgPath(), self.rangeImg.image)
    self.mono:LoadSpriteAsync(self:getRankBgPath(), self.rankBg.image)
end

---更新已获得标记的显隐状态
function CustomBox:updateIsGet()
    if not self.customData.isGet then
        self.isGet:SetActive(false)
        return
    end
    self.isGet:SetActive(self.customData.isGet)
end

---设置已获得标记的本地坐标
---@param position Vector3
function CustomBox:updateIsGetLocalPosition(position)

    self.isGetMark.rectTransform.localPosition = position
end

---更新道具数量文本显示，支持普通数字、分数（x/y）及大数简化（K）
---@param setCount number|string? 可选，强制覆盖显示数量
function CustomBox:updateItemNum(setCount)
    if not self.customData or not self.customData.itemNum then
        self.countObj:SetActive(false)
        return
    end

    self.countObj:SetActive(true)
    local count = self.customData.itemNum
    if setCount then
        count = setCount
    end
    if count == nil or count == 0 then
        self.countObj:SetActive(false)
        return 
    end

    if type(count) == "string" and string.find(count, "/") then
        local current, total = string.match(count, "(%d+)/(%d+)")
        current = tonumber(current) or 0
        total = tonumber(total) or 0
        local showRed = current < total and true or false
        if self.curShowCfg.numShowType and self.curShowCfg.numShowType == GE.ItemNumShowType.OverflowWithK then
            current = UICommonUtils.FormatNumber(current)
            total = UICommonUtils.FormatNumber(total)
        end
        count = current .. "/" .. total
        if showRed then
            count = string.format("<color=#FF3838>%s</color>/%s", current, total)
        end
    elseif type(count) == "number" then
        -- 处理数字形式
        local num = tonumber(count) or 0
        if self.curShowCfg.numShowType and self.curShowCfg.numShowType == GE.ItemNumShowType.OverflowWithK then
            count = UICommonUtils.FormatNumber(num)
        end
        if count == 0 then
            self.countObj:SetActive(false)
        end
    end
    self.itemNum.text.text = count
end

---更新道具类型图标（武器类型子图标或皮肤角标等）
function CustomBox:updateTypeIcon()
    local typePath = nil
    if self.customData.itemType == GE.ItemTypeIndex.skin then
        typePath = "Sprite/UI/Common/skilltree/subscript.png"
    end

    if self.customData.itemType ~= GE.ItemTypeIndex.weapon or not self.curShowCfg.type then
    else
        typePath = string.format(Config.SpritePath.WeaponTypePath, self.curShowCfg.type)
    end
    self.typeIcon:SetActive(typePath ~= nil)
    if typePath == nil then
       return 
    end
    self.mono:LoadSpriteAsync(typePath, self.typeIcon.image)
end

---更新首次获得标记的显隐，并同步提示文字
function CustomBox:updateIsFrist()
    if not self.customData.isFrist then
        self.isFrist:SetActive(false)
        return
    end
    if self.customData.tipsText then
        self.tipsTxt.text.text = self.customData.tipsText
    end
    if self.customData.tipsTextColor then
        self.isFrist.image.color = self.customData.tipsTextColor
    end
    self.isFrist:SetActive(self.customData.isFrist)
end

---更新 New 标记显隐，依据红点管理器状态决定是否展示
function CustomBox:updateNew()
    if not self.customData.showNew then
        self.new:SetActive(false)
        return
    end
    local data = self.customData
    local id = data.id
    if data.rid ~= nil and data.rid ~= 0 then
        id = data.rid
    end
    if not id then
        self.new:SetActive(false)
        return
    end
    local redDotKey = "NewItem"
    if data.itemType == GE.ItemTypeIndex.weapon then
        redDotKey = "NewWeapon"
    elseif data.itemType == GE.ItemTypeIndex.equip then
        redDotKey = "NewEquip"
    end
    self.new:SetActive(RedPointMgr:GetRedDotState(redDotKey.. id) == false)
end

---更新超载标记的显隐状态，有装备持有者时强制隐藏
function CustomBox:updateOverload()
    if self.customData.ownerId and self.customData.ownerId ~= 0 then
        self.overLoad:SetActive(false)
        return
    end
    if not self.customData.overLoad then
        self.overLoad:SetActive(false)
        return
    end
    self.overLoad:SetActive(self.customData.overLoad)
end

---更新选中框的显隐状态
function CustomBox:updateSelect()
    if not self.customData.isSelect then
        self.isSelect:SetActive(false)
        return
    end
    self.isSelect:SetActive(self.customData.isSelect)
end

---直接设置选中框的显隐状态（不依赖 customData）
---@param state boolean
function CustomBox:setSelect(state)
    self.isSelect:SetActive(state)
end

---更新装备持有者信息（预留接口，暂未实现）
function CustomBox:updateOwner()
    
end

---更新通用遮罩的显隐，有持有者时显示遮罩
function CustomBox:updateCommonMask()
    if not self.customData.ownerId then
        self.commonMask:SetActive(false)
        return
    end
    self.commonMask:SetActive(self.customData.ownerId ~= 0 and true or false)
end

---直接设置通用遮罩的显隐状态
---@param state boolean
function CustomBox:setCommonMask(state)
    self.commonMask:SetActive(state)
end

---更新道具已装配标记的显隐，有持有者时显示
function CustomBox:updateIsEquipIn()
    if not self.customData.ownerId then
        self.isEquipIn:SetActive(false)
        return
    end
    self.isEquipIn:SetActive(self.customData.ownerId ~= 0 and true or false)
end

---更新装备持有者的角色头像图标（异步加载）
function CustomBox:updateRoleIcon()
    if not self.customData.ownerId or self.customData.ownerId == 0 then
        return
    end
    local roleData = Me:getPlayerHero(self.customData.ownerId)
    local skinConfig = Config.GetCharacterSkinInfo(roleData.equipSkin)
    local resourceFolder = nil
    if tonumber(skinConfig.resourceFolder) ~= nil then
        resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
    else
        resourceFolder = skinConfig.resourceFolder
    end
    self.roleIcon:SetActive(true)
    self.mono:LoadSpriteAsync(string.format(Config.SpritePath.IconRolePath, resourceFolder, skinConfig.driverKey), self.roleIcon.image)
end

---更新道具使用中标记及相关子节点（isOne、inCountTxt）的显示
function CustomBox:updateIsIn()
    if not self.customData.isIn then
        self.isIn:SetActive(false)
        return
    end
    self.isIn:SetActive(self.customData.isIn)
    
    if self.customData.isInIsOne then
        self.isIn.isOne:SetActive(self.customData.isInIsOne)
    else
        self.isIn.isOne:SetActive(false)
    end
    if self.customData.inCountTxtState then
        self.isIn.inCountTxt:SetActive(true)
        self.isIn.inCountTxt.text.text = self.customData.inCountTxt
    else
        self.isIn.inCountTxt:SetActive(false)
    end
    
end

---更新删除按钮的显隐及点击回调绑定
function CustomBox:updateDelBtn()
    if self.customData.delBtnState then
        self.delBtn:SetActive(true)
        if self.customData.delBtnListener then
            self.delBtn.scaleButton.onClick:RemoveAllListeners()
            self.delBtn.scaleButton.onClick:AddListener(self.customData.delBtnListener)
        end
    else
        self.delBtn:SetActive(false)
    end
end

---更新角色头像图标（异步加载），优先读取已装备皮肤，否则取默认皮肤
function CustomBox:updataCharIcon()
    local function is_numeric(str)
        return tonumber(str) ~= nil
    end
    local equipSkin = nil
    local hero = Me:getPlayerHero(self.customData.id)
    if hero ~= nil then
        equipSkin = hero.equipSkin
    else
        local cfg = Config.GetCharacterInfo(self.customData.id)
        equipSkin = cfg.baseSkinID
    end

    local skinConfig = Config.GetCharacterSkinInfo(equipSkin)
    local resourceFolder = nil
    if is_numeric(skinConfig.resourceFolder) then
        resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
    else
        resourceFolder = skinConfig.resourceFolder
    end
    self.charIcon:SetActive(true)
    self.itemIcon:SetActive(false)

    self.mono:LoadSpriteAsync(string.format(Config.SpritePath.IconRolePath, resourceFolder, skinConfig.driverKey), self.charIcon.image)
end

---更新皮肤图标（异步加载）
function CustomBox:updataSkinIcon()
    local function is_numeric(str)
        return tonumber(str) ~= nil
    end
    local equipSkin = self.customData.id

    local skinConfig = Config.GetCharacterSkinInfo(equipSkin)
    local resourceFolder = nil
    if is_numeric(skinConfig.resourceFolder) then
        resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
    else
        resourceFolder = skinConfig.resourceFolder
    end
    self.charIcon:SetActive(true)
    self.itemIcon:SetActive(false)
    self.mono:LoadSpriteAsync(string.format(Config.SpritePath.IconRolePath, resourceFolder, skinConfig.driverKey), self.charIcon.image)
end

---更新道具名称文本的显示，仅在 showItemName 为 true 且名称非空时显示
function CustomBox:updataItemNameTxt()
    if self.customData.showItemName and not string.isNullOrEmpty( self.customData.itemNameTxt) then
        self.itemNameTxt:SetActive(true)
        self.itemNameTxt.text.text = self.customData.itemNameTxt
    else
        self.itemNameTxt:SetActive(false)
    end
end

---设置使用中数量文本内容
---@param text string
function CustomBox:setInCountTxt(text)
    self.isIn.inCountTxt.text.text = text
end

---设置缩放按钮的可交互状态
---@param state boolean
function CustomBox:setScaleBtnEnable(state)
    self.equipBtn.scaleButton.enabled = state
end

---根据 disableClick 设置装备按钮的可交互状态
function CustomBox:addListener()
   if self.customData.disableClick then
        self:setScaleBtnEnable(false)
        return
    end
    self:setScaleBtnEnable(true)
end

---根据 customData 绑定或禁用长按监听回调
function CustomBox:onLongpressListener()
    if not self.customData.onLongpressListener then
        self.equipBtn.clickLongPressListener.enabled = false
        return
    end
    self.equipBtn.clickLongPressListener.enabled = true
    self.equipBtn.clickLongPressListener.onLongpress = self.customData.onLongpressListener
end

---根据 customData 绑定按下（onDown）回调
function CustomBox:onDownListener()
    if not self.customData.onDownListener then
        return
    end
    self.equipBtn.clickLongPressListener.onDown = self.customData.onDownListener
end

---根据 customData 绑定抬起（onUp）回调
function CustomBox:onUpListener()
    if not self.customData.onUpListener then
        return
    end
    self.equipBtn.clickLongPressListener.onUp = self.customData.onUpListener
end

---获取道具品质边框图片路径
---@return string
function CustomBox:getRangeImgPath()
    if self.customData.itemType == GE.ItemTypeIndex.weapon then
        return string.format(Config.SpritePath.ItemRankFarme2, self.curShowCfg.rare)
    elseif self.customData.itemType == GE.ItemTypeIndex.Character then
        return string.format(Config.SpritePath.ItemRankFarme2, self.curShowCfg.rank)  
    elseif self.customData.itemType == GE.ItemTypeIndex.skin then
        return string.format(Config.SpritePath.ItemRankFarme2, self.curShowCfg.rank)
    else
        return string.format(Config.SpritePath.ItemRankFarme2, self.curShowCfg.quality)
    end
end

---获取道具品质背景图片路径
---@return string
function CustomBox:getRankBgPath()
    if self.customData.itemType == GE.ItemTypeIndex.weapon then
        return string.format(Config.SpritePath.ItemRankFarme, self.curShowCfg.rare)
    elseif self.customData.itemType == GE.ItemTypeIndex.Character then
        return string.format(Config.SpritePath.ItemRankFarme, self.curShowCfg.rank)
    elseif self.customData.itemType == GE.ItemTypeIndex.skin then
        return string.format(Config.SpritePath.ItemRankFarme, self.curShowCfg.rank)
    else
        return string.format(Config.SpritePath.ItemRankFarme, self.curShowCfg.quality)
    end
end
---获取当前显示对象的品质
---@return number
function CustomBox:getQuality()
    if self.customData.itemType == GE.ItemTypeIndex.weapon then
        if self.curShowCfg then
            return self.curShowCfg.rare
        end
    elseif self.customData.itemType == GE.ItemTypeIndex.Character then
        local characterInfo = Config.GetCharacterInfo(self.customData.id)
        return characterInfo.rank
    elseif self.customData.itemType == GE.ItemTypeIndex.skin then
        --皮肤没有品质 ，直接返回5
        return 5
    else
        if self.curShowCfg then
            return self.curShowCfg.quality
        end
    end
    LuaLogger.es("error    CustomBox:getQuality",self.customData.itemType, 0)
    return 0
end

---点击道具格子时触发，播放音效并按配置展示道具提示或执行自定义回调
function CustomBox:OnEquipBtnClick()

    if self.customData.disableClick then
       return 
    end
    
    if self.customData.clickSound == nil then
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    else
        self:play2DSound(self.customData.clickSound)
    end
   
    local data = self.customData
    local id = data.id
    if data.rid ~= nil and data.rid ~= 0 then
        id = data.rid
    end
     local redDotKey = "NewItem"
    if data.itemType == GE.ItemTypeIndex.weapon then
        redDotKey = "NewWeapon"
    elseif data.itemType == GE.ItemTypeIndex.equip then
        redDotKey = "NewEquip"
    end
    if id then
        RedPointMgr:SetRedDotState(redDotKey.. id, true)
        self:updateNew()
    end
    if self.customData.listener == nil then
        Me:ShowItemTips({
            id = id,
            type = Me:ItemTypeToReward(data.itemType),
            CanLock = data.CanLock,
            navType = data.navType,
            tipsPassEventState = data.tipsPassEventState,
            ownerPanelName = data.ownerPanelName,
            needNum = data.needNum,
        })
    else
        local res = self.customData.listener()
        if res == false then
            Me:ShowItemTips({
                id =  id,
                type = Me:ItemTypeToReward(data.itemType),
                CanLock = data.CanLock,
                navType = data.navType,
                tipsPassEventState = data.tipsPassEventState,
                ownerPanelName = data.ownerPanelName,
                needNum = data.needNum,
            })
        end
    end
end

function CustomBox:ShowEffect()
    local showEffect = false
    if self.customData.itemType == GE.ItemTypeIndex.item then
        ---@type ItemTable
        local cfg = self.curShowCfg
        if cfg ~= nil and cfg.quality >= 5 then
           showEffect = true 
        end
    end
    if showEffect == true then
       self.showEf:SetActive(true) 
    end
end

---接收道具锁定状态刷新消息，更新对应 customData 并刷新锁定图标
---@param data table 包含 id 和 type 的消息数据
function CustomBox:RecvRefreshCustomItemLockState(data)
    if data == nil then
       return 
    end
    if self.customData == nil then
       return 
    end
    local type = Me:ItemTypeToReward(self.customData.itemType)

    if data.id ~= self.customData.id or type == data.type then
        return
    end
    local serverData = nil
    if type == GE.RewardType.Weapon then
        serverData = Me:getWeaponDataById(data.id)
    elseif type == GE.RewardType.Equipment then
        serverData = Me:getEquipDataByid(data.id)
    end
    self.customData.isLock = serverData.isLock
    self:updateIsLock()
end

---UI 销毁时清理数据引用并注销消息监听
function CustomBox:OnDestroy()
    self.customData = nil
    self.destroyed = true
	GameMsgMgr:unRegEvent(GameMsgType.RefreshCustomItemLockState, self, self.RecvRefreshCustomItemLockState)
end

return CustomBox
