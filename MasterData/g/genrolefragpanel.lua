---@class GenRoleFragPanel : GenRoleFragPanel_Generate
---##################### 【GenRoleFragPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【GenRoleFragPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local GenRoleFragPanel = require "GenRoleFragPanel_Generate"

function GenRoleFragPanel:InitLogic(data)

end

--function GenRoleFragPanel:StartCreating(time)
--
--end

--function GenRoleFragPanel:StartEnter(time)
--
--end

--function GenRoleFragPanel:StartRemoving(time)
--
--end

--function GenRoleFragPanel:StartExit(time)
--
--end

local roleShowData = {
    [1] = {
        pos = Vector3.New(1002.41,3,3.72),
        rot = Quaternion.Euler(0,226,0),
    },
    [2] = {
        pos = Vector3.New(1008.15,3,-2.54),
        rot = Quaternion.Euler(0,283,0),
    },
    [3] = {
        pos = Vector3.New(994.07,3,8.54),
        rot = Quaternion.Euler(0,203,0),
    },
}

function GenRoleFragPanel:OnOpen(data, initiative)
    if initiative then
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.GenRoleFrag)
        self.customBackPanel.customBackPanel:OverrideBackFunc(function()
            
            self:clearAllModel()
            self:exitFunc()
        end)
        self.customBackPanel.customBackPanel:OverrideMainBackFunc(function()
            self:clearAllModel()
            self:exitFunc()
        end)
    end
    --CoveRoleManager.instance():SetRoleShowState(false)
    self:initData()
    self:bindList()
    self:initUI()
    self:refreshUI()
    self:preLoad()
    GuideMgr:StartGuideTrigger("GenRoleFragPanel")
end

function GenRoleFragPanel:initData()
    --当前选择跑片的角色列表
    self.curSelRoleList = {0,0,0}
    --是否展示加成
    self.isShowBonus = false
    --角色Obj列表
    self.roleObjList = {}
    --当前展示的角色列表
    self.curShowRoleObjList = {}
    --定时器列表
    self.timeList = {}
    --进度条列表
    self.d1ChildList = {}
    self.d4ChildList = {}
    --跑片加成活动是否开启
    self.activityOpen = false
    ---加成列表
    self.addRoleList = {}

    self.activityConfig = Config.GetActivityByType(GE.ActivityType.GenRoleFragExtra)[1]
    if self.activityConfig then
        local activityInfo = Me:getActivityInfo(self.activityConfig.id)
        if activityInfo and activityInfo.state == GE.ActivityState.Open then
            self.activityOpen = true
            for _, v in pairs(self.activityConfig.activityPara) do
                table.insert(self.addRoleList, v)
            end
        end
    end
    self.curCanSelRoleList = {}

    self.roleCount = Me:genRoleFragSlotUnlockCount()
end

function GenRoleFragPanel:bindList()
    self.selRoleList.loopGridView:InitGridView(tablex.size(self.curCanSelRoleList), function(gridView, index, row, col)
        --LuaLogger.ds("index", index)
        local loopGridViewItem = gridView:GetShownItemByItemIndex(index)
        if loopGridViewItem == nil then
            loopGridViewItem = gridView:NewListViewItem("RoleBox")
        end
        index = index + 1
        local itemObj = loopGridViewItem.gameObject
        EngineUtil.FillPeer(self.roleBox, itemObj)
        local data = self.curCanSelRoleList[index]
        if not data then
            itemObj:SetActive(false)
            return
        end
         itemObj:SetActive(true)
        itemObj.mask:SetActive(false)
        itemObj.scaleButton.onClick:RemoveAllListeners()
        local roleData = data.serverData
        if not roleData then
            return
        end
        local skinConfig = Config.GetCharacterSkinInfo(roleData.equipSkin)
        if not skinConfig then
            return
        end
        local roleConfig = data.configData
        local function is_numeric(str)
            return tonumber(str) ~= nil
        end
        local resourceFolder = nil
        if is_numeric(skinConfig.resourceFolder) then
            resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
        else
            resourceFolder = skinConfig.resourceFolder
        end

        local iconPath = string.format(Config.SpritePath.IconRolePath, resourceFolder, skinConfig.driverKey)
        self:LoadSpriteAsync(iconPath, itemObj.roleImg.image)
        local farmePath = string.format(Config.SpritePath.RankFrameSmall, roleConfig.rank)
        self:LoadSpriteAsync(farmePath, itemObj.frameImg.image)
        local starPath = string.format(Config.SpritePath.StarLevelImg, roleData.star)
        self:LoadSpriteAsync(starPath, itemObj.starImg.image)
        itemObj.roleName.text.text = roleConfig.name

        local fragItemId = roleConfig.getPatch[1][2]
        local fragItemConfig = Config.GetItemInfo(fragItemId)
        self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, fragItemConfig.icon), itemObj.fragImg.image)
        local activityAddNum = 0
        for _, v in pairs(self.addRoleList) do
            if v[1] == roleConfig.id then
                activityAddNum = v[2]
                break
            end
        end
        itemObj.fragNum.text.text = Config.GetConfigInfo("GenRoleFragBasicNum") + Me:getGenRoleFragExtraAdd(roleData.id) + activityAddNum
        itemObj.sel:SetActive(data.selIndex > 0)
        itemObj.selIndex.text.text = data.selIndex

        itemObj.buleTipBg:SetActive(false)
        if self.isShowBonus then
            itemObj.mask:SetActive(true)
            --itemObj.t1Bg:SetActive(true)
            itemObj.t2Bg:SetActive(true)
            -- local techAdd = Me:getGenRoleFragExtraAddByTechTree(data.serverData.id)
            -- itemObj.t1.text.text = string.format("基盘(%d/1)", techAdd)
            local addCfg = Config.GetConfigInfo("AffectionAddFrag")
            local addNum = 0
            local curAdd = 0
            if addCfg then
                addNum = tablex.size(addCfg)
                for index, v in pairs(addCfg) do
                    if roleData.affectionLevel >= v[1] then
                        curAdd = curAdd + v[2]
                    end
                end
            end
            itemObj.t2.text.text = string.format("共鸣(%d/%d)", curAdd, addNum)
        else
            if data.isGetToday then
                itemObj.mask:SetActive(true)
                itemObj.buleTipBg:SetActive(true)
                itemObj.buleTip.text.text = LocalStrEnum["GenRoleT1"]
            end
            if data.isFragFull then
                itemObj.mask:SetActive(true)
                itemObj.buleTipBg:SetActive(true)
                itemObj.buleTip.text.text = LocalStrEnum["GenRoleT2"]
            end
            itemObj.t1Bg:SetActive(false)
            itemObj.t2Bg:SetActive(false)
        end
        itemObj.scaleButton.onClick:AddListener(function ()
            if data.isFragFull or data.isGetToday then
                return
            end
            self:selectBox(data.serverData.id, itemObj)
        end)
        return loopGridViewItem
    end)
end

function GenRoleFragPanel:initUI()
    self.progress.text.text = "0%"
    self.progressShadow.text.text = "0%"
    self.progressCircle.image.fillAmount = 0
    self.skipBtn:SetActive(false)
    self.boxBg:SetActive(false)
    self.selRoleMask:SetActive(false)
    self.timeTip.text.text = string.format(LocalStrEnum["GenRoleFragSyncTip"], Config.GetConfigInfo("DailyResetTime"))
    self.curShowRoleObjList = {}
    self.timeList = {}
    if UICommonUtils.Checkobj(self.curMonsterObj) then
        self.curMonsterObj:SetActive(false)
    end

    self.d1Count = self.d1.transform.childCount
    self.d1ChildList = {}
    for i = 1, self.d1Count do
        local obj = self.d1.transform:GetChild(i -1).gameObject
        obj:SetActive(false)
        table.insert(self.d1ChildList, obj)
    end
    self.d4Count = self.d4.transform.childCount
    self.d4ChildList = {}
    for i = 1, self.d4Count do
        local obj = self.d4.transform:GetChild(i -1).gameObject
        obj:SetActive(false)
        table.insert(self.d4ChildList, obj)
    end
    if self.activityOpen then
        self.d2:SetActive(false)
        self.d6:SetActive(false)
        self.d7:SetActive(false)
        self.activityBg:SetActive(true)
        self:FillTemplateContent(self.activityRoleBox, self.selectList, tablex.size(self.addRoleList), function (index, itemObj)
            local roleId = self.addRoleList[index][1]
            local count = self.addRoleList[index][2]
            local roleData = Me:getPlayerHero(roleId)
            local roleConfig = Config.GetCharacterInfo(roleId)
            if not roleConfig then
                return
            end
            local equipSkin = roleData and roleData.equipSkin or roleConfig.baseSkinID
            local skinConfig = Config.GetCharacterSkinInfo(equipSkin)
            if not skinConfig then
                return
            end
            local function is_numeric(str)
                return tonumber(str) ~= nil
            end
            local resourceFolder = nil
            if is_numeric(skinConfig.resourceFolder) then
                resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
            else
                resourceFolder = skinConfig.resourceFolder
            end
            local iconPath = string.format(Config.SpritePath.IconRolePath, resourceFolder, skinConfig.driverKey)
            self:LoadSpriteAsync(iconPath, itemObj.roleImg.image)
            local farmePath = string.format(Config.SpritePath.RankFrameSmall, roleConfig.rank)
            self:LoadSpriteAsync(farmePath, itemObj.frameImg.image)
            local starPath = string.format(Config.SpritePath.StarLevelImg, roleData and roleData.star or 1)
            self:LoadSpriteAsync(starPath, itemObj.starImg.image)
            itemObj.extraText.text.text = string.format(LocalStrEnum["GenRoleTip1"], count)
        end)
        local timeTable = os.date("*t", self.activityConfig.EndTime)
        self.acxtivityTimeTip.text.text = string.format(LocalStrEnum["GenRoleTip2"], string.format("%d.%02d.%02d", timeTable.year, timeTable.month, timeTable.day))
    else
        self.d2:SetActive(true)
        self.d6:SetActive(true)
        self.d7:SetActive(true)
        self.activityBg:SetActive(false)
    end
    
end

function GenRoleFragPanel:refreshUI()
    self:refreshWaitRole()
    self:refreshGenBtn()
end

function GenRoleFragPanel:preLoad()
    local effectConfig = Config.GetSoundAndEffectInfo(1077)
	if not effectConfig then
		return
	end
    local effectName = effectConfig.effectResource
	local effectPath = string.format(Config.PrefabPath.BattleEffect, effectName, effectName)
    PoolMgr:Get(effectPath, function (obj)
        obj:SetActive(false)
    end)
end

function GenRoleFragPanel:refreshGenBtn()
    local canGenNum = Config.GetConfigInfo("GenRoleFragBasicTimes") - Me:getGenRoleFragCount()
    if canGenNum < 0 then
        canGenNum = 0
    end
    if canGenNum == 0 then
        self.genBtn.scaleButton.interactable = false
        self.genBtn.gray:SetActive(true)
    else
        self.genBtn.gray:SetActive(false)
        self.genBtn.scaleButton.interactable = self:getCurSelNum() > 0 and true or false
    end
    self.genBtn.tip.text.text = string.format(LocalStrEnum["GenRoleTip3"], canGenNum)
end

function GenRoleFragPanel:refreshWaitRole()
    self.curCanUsePosNum = 0
    self:FillTemplateContent(self.roleNode, self.waitRoleList, 3, function (index, itemObj)
        itemObj.index.text.text = "NO."..index
        local isLock = index > Me:genRoleFragSlotUnlockCount()
        if isLock then
            itemObj.detail:SetActive(false)
            itemObj.empty:SetActive(false)
            itemObj.scaleButton.onClick:RemoveAllListeners()
            itemObj.lockTip.text.text = LocalStrEnum["GenRoleSlotUnlockTip"..index]
        else
            self.curCanUsePosNum = self.curCanUsePosNum + 1
            local roleId = self.curSelRoleList[index]
            if roleId == 0 then
                itemObj.detail:SetActive(false)
                itemObj.empty:SetActive(true)
                local curRoleObj = self.curShowRoleObjList[index]
                if UICommonUtils.Checkobj(curRoleObj) then
                    curRoleObj:SetActive(false)
                end
            else
                local roleData = Me:getPlayerHero(roleId)
                if not roleData then
                    return
                end
                itemObj.detail:SetActive(true)
                itemObj.empty:SetActive(false)
                local skinConfig = Config.GetCharacterSkinInfo(roleData.equipSkin)
                local roleConfig = Config.GetCharacterInfo(roleId)
                if not skinConfig or not roleConfig then
                    return
                end
                local function is_numeric(str)
                    return tonumber(str) ~= nil
                end
                local resourceFolder = nil
                if is_numeric(skinConfig.resourceFolder) then
                    resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
                else
                    resourceFolder = skinConfig.resourceFolder
                end

                self:createRole(skinConfig.modelKey, index)

                local iconPath = string.format(Config.SpritePath.BannerRolePath, resourceFolder, skinConfig.driverKey)
                self:LoadSpriteAsync(iconPath, itemObj.headIcon.image)
                local fragItemId = roleConfig.getPatch[1][2]
                local fragItemConfig = Config.GetItemInfo(fragItemId)
                self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, fragItemConfig.icon), itemObj.fragImg.image)
                local activityAddNum = 0
                for _, v in pairs(self.addRoleList) do
                    if v[1] == roleId then
                        activityAddNum = v[2]
                        break
                    end
                end
                itemObj.fragNum.text.text = Config.GetConfigInfo("GenRoleFragBasicNum") + Me:getGenRoleFragExtraAdd(roleId) + activityAddNum
                local starPath = string.format(Config.SpritePath.StarLevelImg, roleData.star)
                self:LoadSpriteAsync(starPath, itemObj.starImg.image)
            end
            itemObj.scaleButton.onClick:RemoveAllListeners()
            itemObj.scaleButton.onClick:AddListener(function ()
                self.selRoleMask:SetActive(true)
                self.boxBg:SetActive(true)
                self:refreshRoleSelPage()
            end)
        end
    end)
end

function GenRoleFragPanel:refreshRoleSelPage()
    local roleList = ClientData:GetRoleList()
    self.curCanSelRoleList = {}
    for _, v in pairs(roleList) do
        local config = Config.GetCharacterInfo(v.id)
        local temp = {
            ---@type HeroInfo
            serverData = v,
            ---@type CharacterTable
            configData = config,
            --是否今日已获取
            isGetToday = Me:getGenRoleFragIsGen(v.id),
            --碎片是否已达上限
            isFragFull = self:getRoleFragIsFull(config, v),
            --是否已被选择
            selIndex = self:getSelIndexByRoleId(v.id)
        }
        table.insert(self.curCanSelRoleList, temp)
    end
    table.sort(self.curCanSelRoleList, function (a, b)
        if a.isGetToday ~= b.isGetToday then
            return not a.isGetToday
        end
        if a.isFragFull ~= b.isFragFull then
            return not a.isFragFull
        end
        if a.serverData.star ~= b.serverData.star then
            return a.serverData.star > b.serverData.star
        end
        if a.serverData.level ~= b.serverData.level then
            return a.serverData.level > b.serverData.level
        end
        return a.serverData.id < b.serverData.id
    end)
    self.selRoleList.loopGridView:SetListItemCount(tablex.size(self.curCanSelRoleList))
    self.selRoleList.loopGridView:RefreshAllShownItem2()
end

---碎片是否已达上限
function GenRoleFragPanel:getRoleFragIsFull(configData, serverData)
    if not configData or not serverData then
        return false
    end
    if serverData.star >= tablex.size(configData.talentId) then
        return true
    end
    local itemId = configData.patchCost[1][2]
    local itemCount = Me:getItemCountById(itemId)
    local maxNeed = 0
    for index = serverData.star + 1, tablex.size(configData.patchCost) do
        maxNeed = maxNeed + configData.patchCost[index][3]
    end
    if itemCount >= maxNeed then
        return true
    end
    return false
end

function GenRoleFragPanel:getSelIndexByRoleId(roleId)
    for i = 1, 3 do
        if self.curSelRoleList[i] == roleId then
            return i
        end
    end
    return 0
end

function GenRoleFragPanel:selectBox(roleId, obj)
    local selIndex = self:getSelIndexByRoleId(roleId)
    if selIndex > 0 then
        self:removeSelRole(roleId, obj)
    else
        if self:getCurSelNum() >= self.roleCount then
            UICommonUtils.PopToast("可部署栏位已达到上限")
            return
        end
        self:addSelRole(roleId, obj)
    end
end

function GenRoleFragPanel:removeSelRole(roleId, obj)
    for i = 1, 3 do
        if self.curSelRoleList[i] == roleId then
            self.curSelRoleList[i] = 0
            break
        end
    end
    obj.sel:SetActive(false)
end

function GenRoleFragPanel:addSelRole(roleId, obj)
    for i = 1, 3 do
        if self.curSelRoleList[i] == 0 then
            self.curSelRoleList[i] = roleId
            break
        end
    end
    obj.sel:SetActive(true)
    obj.selIndex.text.text = self:getSelIndexByRoleId(roleId)
end

--获取当前已选择的英雄数量
function GenRoleFragPanel:getCurSelNum()
    local num = 0
    for i = 1, 3 do
        if self.curSelRoleList[i] > 0 then
            num = num + 1
        end
    end
    return num
end

function GenRoleFragPanel:startGen()
    self.genBtn.scaleButton.interactable = false
    Me:genRoleFragStartReq({roleIdList = self.curSelRoleList}, function (resp)
        if resp.ret == 0 then
            resp.list = resp.list or {}
            self.curRewardList = resp.list

            self.inShow = true
            self.skipBtn:SetActive(true)
            self:doUIShow()
            self:onGenSec(function ()
                --奖励展示
                Me:ReceiveReward(resp.list)
                
                self:initData()
                self:initUI()
                self:refreshUI()
                self.animator.enabled = true
                self.animator:SetTrigger("Out")
                self.genBtn.scaleButton.interactable = true
                self.inShow = false
            end)
        end
    end)
end

---跑片成功后展示
function GenRoleFragPanel:onGenSec(callback)
    self.tweener = DG.Tweening.DOVirtual.Int(0, 100, 7.5, function(v)
        self.progress.text.text = string.format("%d%%", v)
        self.progressShadow.text.text = string.format("%d%%", v)
        self.progressCircle.image.fillAmount = v / 100
        self:updateProgress(v / 100)
    end):SetEase(DG.Tweening.Ease.OutCubic):OnComplete(function()
        self.progress.text.text = "100%"
        self.progressShadow.text.text = "100%"
        self.progressCircle.image.fillAmount = 1
        self:updateProgress(1)
        callback()
    end)
    self:createMonster()
    for i = 1, 3 do
        local roleObj = self.curShowRoleObjList[i]
        if UICommonUtils.Checkobj(roleObj) then
            local model = roleObj.transform:GetComponent("RoleModelController")
            local timer
            local time = 2
            for j = 1, 3 do
                timer = DLuaTimer:DoAfter(time, function ()
                    --model:PlayAnim(RoleModelAnimEnum.Attack)
                    self:doAttack(roleObj, self.curSelRoleList[i])
                end)
                table.insert(self.timeList, timer)
                time = time + 2
            end
            timer = DLuaTimer:DoAfter(6.5, function ()
                model:FadeOut()
            end)
            table.insert(self.timeList, timer)
            timer = DLuaTimer:DoAfter(7, function ()
                roleObj:SetActive(false)
            end)
            table.insert(self.timeList, timer)
        end
    end
end

function GenRoleFragPanel:doAttack(roleObj, roleId)
    if UICommonUtils.Checkobj(roleObj) == false then
        return
    end
    local roleData = Me:getPlayerHero(roleId)
    if not roleData then
        return
    end
    local skinConfig = Config.GetCharacterSkinInfo(roleData.equipSkin)
    if not skinConfig then
        return
    end
    -- local attackData = {
	-- 	id = roleId,
	-- 	effectName = skinConfig["skillActEff1"],
	-- }
    local timer
    local animName = skinConfig["skillAct1"] or "Attack"
    local model = roleObj.transform:GetComponent("RoleModelController")
    local monterModel = self.curMonsterObj.transform:GetComponent("RoleModelController")
    
    --local shootRootTrans = self:findShootTrans(model, 1)
    local shootRootTrans = model.transform
    --TODO 怪物受击位置
	local targetPos = self:findHitPos(model, 1)
    model:PlayAnim(RoleModelAnimEnum[animName])
    local shootEffect = skinConfig["skillHitEff2"].shooteff or 1077
    for _, bulletInfo in pairs(skinConfig["skillHitEff2"].bulletList) do
        shootRootTrans = self:findShootTrans(model, bulletInfo.shoot)
        timer = DLuaTimer:DoAfter( bulletInfo.delay or 0,function()
            self:playEffect(shootRootTrans.position, shootEffect, Quaternion.LookRotation(-shootRootTrans.right, shootRootTrans.up) * Quaternion.Euler(0, 180, 0))    
        end)
        table.insert(self.timeList, timer)
    end
    
    monterModel:PlayAnim(RoleModelAnimEnum.Hit)
    local hitEffect = 1081
    self:playEffect(targetPos, hitEffect)
end

function GenRoleFragPanel:findShootTrans(model, shoot)
    if not shoot or #shoot < 2 then
        return model.shootPoints[math.random(0, model.shootPoints.Length - 1)]
    end
    local shootRootsList
    if shoot[1] == 1 then
        shootRootsList = model.shootPoints
    elseif shoot[1] == 2 then
        shootRootsList = model.shootPoints2
    end
    local Length = shootRootsList.Length
    if Length == 0 then
        return model.transform
    end
    local index = shoot[2]
    if index > Length then
        index = math.random(1, Length)
    end
    index = index -1
    return shootRootsList[index]
end

function GenRoleFragPanel:findHitPos(model, index)
    local hitPointsList = model.hitPoints
    local Length = hitPointsList.Length
    if Length == 0 then
        return model.transform.position
    end
    if index > Length then
        index = math.random(1, Length)
    end
    index = index -1
    return hitPointsList[index].position
end

function GenRoleFragPanel:playEffect(pos, id, rotation)
    if id == 0 or id == "" then
		return
	end
    local effectConfig = Config.GetSoundAndEffectInfo(id)
	if not effectConfig then
		LuaLogger.es("特效配置不存在  ", id)
		return
	end
    local effectName = effectConfig.effectResource
	local effectPath = string.format(Config.PrefabPath.BattleEffect, effectName, effectName)
    	PoolMgr:Get(effectPath, function (obj)
		if (obj) then
			LuaLogger.ds("BattleShowManager:playEffect", effectPath)
			obj.transform.position = pos
			if rotation then
				LuaLogger.ds("BattleShowManager:playEffect rotation", rotation)
				obj.transform.rotation = rotation
			end
			---@type UnityEngine.ParticleSystem
			local particle = obj.transform:Find("Effect"):GetComponent("ParticleSystem")
			particle:Simulate(0)
			particle:Play()
			local effect2 = obj.transform:Find("Effect_2")
			if (effect2) then
				---@type UnityEngine.ParticleSystem
				local particle2 = effect2:GetComponent("ParticleSystem")
				particle2:Simulate(0)
				particle2:Play()
			end
			-- --判断是否为循环特效 是的话需要和角色绑定
			-- local isLoop = effectConfig.isLoop == 1
			-- if isLoop then
			-- 	local role = self:getRole(roleId)
			-- 	obj:SetParent(role.model.transform)
			-- 	self:setRoleEffectObjByBuffId(roleId, buffid, obj)
			-- else
			-- 	self:_DoAfter(2, function()
			-- 		PoolMgr.Free(obj)
			-- 	end)
			-- end
		end
	end)
	--特效对应音效
	local soundName = effectConfig.SoundResource
	local soundPath = string.format(Config.AudioPath.SE, soundName)
	if soundName and soundName ~= "" then
		LuaLogger.ds("BattleShowManager:playEffect soundPath", soundPath)
		DLuaTimer:DoAfter(effectConfig.delay, function()
			self:play2DSound(soundPath)
		end)
	end
end

function GenRoleFragPanel:updateProgress(value)
    for i = 1, self.d1Count do
        if value >= (i / self.d1Count) then
            local obj = self.d1ChildList[i]
            if UICommonUtils.Checkobj(obj) then
                obj:SetActive(true)                
            end
        end
    end
    for i = 1, self.d4Count do
        if value >= (i / self.d4Count) then
            local obj = self.d4ChildList[i]
            if UICommonUtils.Checkobj(obj) then
                obj:SetActive(true)                
            end
        end
    end
end

function GenRoleFragPanel:createRole(modelKey, slotIndex)
    self:createModelObj(modelKey, roleShowData[slotIndex].pos, roleShowData[slotIndex].rot, true, slotIndex)
end
function GenRoleFragPanel:createMonster()
    local monsterId = 20000 + math.random(1,3)
    -- local monsterConfig = Config.GetMonsterInfo(monsterId)
    -- if not monsterConfig then
    --     return
    -- end
    local modelKey = "enemy_".. tostring(monsterId)
    self:createModelObj(modelKey, Vector3.New(996.13,3,-5.73), Quaternion.Euler(0,-10,0))
end

--创建模型对象
---@param modelKey string 模型key
---@param pos Vector3 位置
---@param rot Quaternion 旋转
---@param isRole boolean 是否是角色模型
function GenRoleFragPanel:createModelObj(modelKey, pos, rot, isRole, index)
    PoolMgr:Get(string.format(Config.PrefabPath.RoleModelPrefab, modelKey, modelKey) , function (modelObj)
        modelObj.transform.localPosition = pos
        modelObj.transform.localRotation = rot
        modelObj.transform.localScale = Vector3.New(3,3,3)
        local model = modelObj.transform:GetComponent("RoleModelController")
        model:SetDefaultState(RoleAnimStateType.IdleShip)
        model:FadeIn()
        modelObj:SetActive(true)
        table.insert(self.roleObjList, modelObj)
        if isRole then
            local preObj = self.curShowRoleObjList[index]
            if UICommonUtils.Checkobj(preObj) then
                preObj:SetActive(false)
            end
            self.curShowRoleObjList[index] = modelObj
        else
            local timer
            timer = DLuaTimer:DoAfter(6.5, function ()
                model:FadeOut()
            end)
            table.insert(self.timeList, timer)
            timer = DLuaTimer:DoAfter(7, function ()
                modelObj:SetActive(false)
            end)
            table.insert(self.timeList, timer)
            self.curMonsterObj = modelObj
        end
    end)
end

function GenRoleFragPanel:clearAllModel()
    for _, v in pairs(self.roleObjList) do
        if UICommonUtils.Checkobj(v) then
            PoolMgr.Free(v)
        end
    end
    for _, t in pairs(self.timeList) do
        if t then
            t:Stop()
        end
    end
    if self.tweener then
        self.tweener:Kill()
    end

end

function GenRoleFragPanel:doUIShow()
    self.animator:SetTrigger("Show")
end

--function GenRoleFragPanel:OnClose(initiative)
--
--end

--function GenRoleFragPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function GenRoleFragPanel:OnRefresh(data)
--
--end

--[[
/Main/SkipBtn onClick 
--]]
function GenRoleFragPanel:skipBtn_ScaleButton_onClick(skipBtn)
    if not self.inShow then
        return
    end
    for _, t in pairs(self.timeList) do
        if t then
            t:Stop()
        end
    end
    if self.tweener then
        self.tweener:Kill()
    end
    -- for _, v in pairs(self.roleObjList) do
    --     if UICommonUtils.Checkobj(v) then
    --         v:SetActive(false)
    --     end
    -- end
    for i = 1, 3 do
        local roleObj = self.curShowRoleObjList[i]
        if UICommonUtils.Checkobj(roleObj) then
            roleObj:SetActive(false)
        end
    end
    self.progress.text.text = "100%"
    self.progressShadow.text.text = "100%"
    self.progressCircle.image.fillAmount = 1
    Me:ReceiveReward(self.curRewardList)
    self:initData()
    self:initUI()
    self:refreshUI()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.genBtn.scaleButton.interactable = true
    self.inShow = false
end

--[[
/Main/RightPanel/GenBtn onClick 
--]]
function GenRoleFragPanel:genBtn_ScaleButton_onClick(genBtn)
    --异常检测
    local genRoleList = Me:genGenRoleFragGenRoleList()
    for _, roleId in pairs(self.curSelRoleList) do
        if roleId ~= 0 then
            local roleData = Me:getPlayerHero(roleId)
            if not roleData then
                UICommonUtils.PopToast(Config.GetFailReasonStr(ActionFailReason.HeroNoFind))
                self:clearUIDis()
                return
            end
            local heroCfg = Config.GetCharacterInfo(roleId)
            if not heroCfg then
                UICommonUtils.PopToast(Config.GetFailReasonStr(ActionFailReason.HeroNoFind))
                self:clearUIDis()
                return
            end
            if roleData.star >= #heroCfg.talentId then
                UICommonUtils.PopToast(Config.GetFailReasonStr(ActionFailReason.HeroStarMax))
                self:clearUIDis()
                return
            end
            if tablex.find(genRoleList, roleId) then
                UICommonUtils.PopToast(Config.GetFailReasonStr(ActionFailReason.RoleAlreadyGen))
                self:clearUIDis()
                return
            end
            --碎片数量检测
            local itemId = heroCfg.patchCost[1][2]
            local itemCount = Me:getItemCountById(itemId)
            local maxNeed = 0
            for index = roleData.star + 1, tablex.size(heroCfg.patchCost) do
                maxNeed = maxNeed + heroCfg.patchCost[index][3]
            end
            if itemCount >= maxNeed then
                UICommonUtils.PopToast(Config.GetFailReasonStr(ActionFailReason.HeroFragIsFull))
                self:clearUIDis()
                return
            end
        end
    end
    if self:getCurSelNum() < self.curCanUsePosNum then
        UICommonUtils.PopPromptOkCancelBox("位置未放满，是否继续", function ()
            self:startGen()
        end)
    else
        self:startGen()
    end
end

--清除ui显示
function GenRoleFragPanel:clearUIDis()
    for _, obj in pairs(self.curShowRoleObjList) do
        if UICommonUtils.Checkobj(obj) then
            obj:SetActive(false)
        end
    end
    self:initData()
    self:initUI()
    self:refreshUI()
end

function GenRoleFragPanel:exitFunc()
    LoadingMgr:SetUISwitchStart(function()
        --CoveRoleManager.instance():SetRoleShowState(true)
		if self.loadSceneTimer2 then
			DLuaTimer:RemoveTimer(self.loadSceneTimer2)
		end
		local asyncOperation = UnityEngine.SceneManagement.SceneManager.UnloadSceneAsync("GenRoleFrag");
		self.loadSceneTimer2 = DLuaTimer:DoRepeatForever(0.1, function()
			if (asyncOperation.isDone) then
				-- if callback then
				-- 	callback()
				-- end
				DLuaTimer:RemoveTimer(self.loadSceneTimer2)
				UIMgr:closeSpecificUI("GenRoleFragPanel")
				LoadingMgr:SetUISwitchOver()
			end
		end)
	end)
end

--[[
/SelRoleMask onClick 
--]]
function GenRoleFragPanel:selRoleMask_Button_onClick(selRoleMask)
    self.selRoleMask:SetActive(false)
    self.boxBg:SetActive(false)
    self.isShowBonus = false
    self:refreshUI()
end

--[[
/BoxBg/CloseBtn onClick 
--]]
function GenRoleFragPanel:closeBtn_ScaleButton_onClick(closeBtn)
    self.selRoleMask:SetActive(false)
    self.boxBg:SetActive(false)
    self.isShowBonus = false
    self:refreshUI()
end

--[[
/BoxBg/SureBtn onClick 
--]]
function GenRoleFragPanel:sureBtn_ScaleButton_onClick(sureBtn)
    self.selRoleMask:SetActive(false)
    self.boxBg:SetActive(false)
    self.isShowBonus = false
    self:refreshUI()
end

--[[
/BoxBg/ChangeBtn onClick 
--]]
function GenRoleFragPanel:changeBtn_ScaleButton_onClick(changeBtn)
    if self.isShowBonus then
        self.isShowBonus = false
    else
        self.isShowBonus = true
    end
    self:refreshRoleSelPage()
end

--[[
/Custom/RoleBox onClick 
--]]
function GenRoleFragPanel:roleBox_ScaleButton_onClick(roleBox)

end

--[[
/Custom/ActivityRoleBox onClick 
--]]
function GenRoleFragPanel:activityRoleBox_ScaleButton_onClick(activityRoleBox)

end

return GenRoleFragPanel
