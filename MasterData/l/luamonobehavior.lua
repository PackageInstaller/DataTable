LuaMonoBehavior = class("LuaMonoBehavior")

function LuaMonoBehavior:InitGameObject(go)
	if go then
		self.gameObject = go
		self.transform = go.transform
		-- self.RefTable = self
		
		-- 如果是同一个Root，前一个次如果还在执行中，后一次又请求了，需要把前一次都取消删除
		self.FillTemplateBatchesId = {}
	end
end

function LuaMonoBehavior:IncrementalContentAsynBatchesId(fillRoot)
    self.FillTemplateBatchesId[fillRoot] = self:GetContentAsynBatchesId(fillRoot) + 1
end

---@return number
function LuaMonoBehavior:GetContentAsynBatchesId(fillRoot)
	local id = self.FillTemplateBatchesId[fillRoot]
	if id == nil then
		id = 1
		self.FillTemplateBatchesId[fillRoot] = id
	end
    return id
end

function LuaMonoBehavior:InitMono(mono)
	self._mono = mono
end

function LuaMonoBehavior:GetMonoRegisterID()
	if self._mono and self._mono.GetRegisteredRequestId then
		return self._mono:GetRegisteredRequestId()
	end
	return
end

function LuaMonoBehavior:NewResourceVersion()
	if EngineGlobal.useNewResource then
		return true
	end
	return false
end


function LuaMonoBehavior:SpawnTemplate_Old(template, identity)
	return PoolMgr.SpawnTemplate(template, identity)
end

function LuaMonoBehavior:SpawnTemplate(template, identity)
	local newMode = self:NewResourceVersion()
	if not newMode then
		local obj = self:SpawnTemplate_Old(template, identity)
		return obj
	end
	return PoolMgr.SpawnTemplate(self.gameObject, template, identity)
end

function LuaMonoBehavior:SpawnTemplateAsync(template, callBack, identity)
	local newMode = self:NewResourceVersion()
	if not newMode then
		local obj = self:SpawnTemplate_Old(template, identity)
		callBack(obj)
		return
	end
	PoolMgr.SpawnTemplateAsync(self.gameObject, template, callBack, identity)
end

function LuaMonoBehavior:FillTemplateContent(template, root, num, func, completeFun)
	EngineUtil.FillTemplateContent(self, template, root, num, func, completeFun)
end

---@param path string
---@param spriteComponent UnityEngine.UI.Image
---@param callBack function
function LuaMonoBehavior:DoLoadSprite(path, spriteComponent, callBack, useCache)
	--if EngineUtil.IsWebGL() then


	if true and spriteComponent ~= nil then
	
		UIMgr:LoadSprite(spriteComponent, path, self.gameObject, callBack)
		return
	end

	if true then
		local spriteDefault = ResMgr:GetSpriteDefault()
		if spriteDefault and spriteComponent then
			if tolua.getpeer(spriteComponent) == nil then
				tolua.setpeer(spriteComponent, {})
			end
			local spriteTable = tolua.getpeer(spriteComponent)
			if not spriteTable.defaultSpriteLoaded then
				spriteComponent.sprite = spriteDefault
				spriteTable.defaultSpriteLoaded = true
			end
		end
		-- LuaLogger.ds("LuaMonoBehavior:DoLoadSprite", path)
		self._mono:LoadSpriteRes(path, function(sprite)
			if sprite and spriteComponent then
				spriteComponent.sprite = sprite
			end
			if callBack then
				callBack(sprite)
			end
		end)
	else
		local sprite = self._mono:LoadSpriteSync(path)
		if sprite and spriteComponent then
			spriteComponent.sprite = sprite
		end
		if callBack then
			callBack(sprite)
		end
	end
end

function LuaMonoBehavior:LoadPrefab_Old(path, callback)
	ResMgr:LoadPrefab(path, callback)
end

function LuaMonoBehavior:LoadPrefab(path, callback)
	local newMode = self:NewResourceVersion()
	if not newMode then
		self:LoadPrefab_Old(path, callback)
		return
	end
	--if EngineUtil.IsWebGL() then
	if true then
		self._mono:LoadPrefabRes(path, callback)
	else
		local effect = self._mono:LoadSync(path)
		callback(effect)
	end
end

function LuaMonoBehavior:LoadInstantiatePrefab(path, callback)
	local newMode = self:NewResourceVersion()
	if not newMode then
		self:LoadPrefab_Old(path, function(obj)
			local new_obj = Instantiate(obj)
			callback(new_obj)
		end)
		return
	end
	--if EngineUtil.IsWebGL() then
	if true then
		self._mono:LoadInstantiatePrefabRes(path, callback)
	else
		-- local effect = self._mono:LoadSync(path)
		-- callback(effect)
	end
end

function LuaMonoBehavior:LoadSprite_Old(path, spriteComponent, callBack)
	ResMgr:LoadSprite(path, -1, spriteComponent, callBack)
end

function LuaMonoBehavior:LoadSprite(path, spriteComponent, callBack)
	local newMode = self:NewResourceVersion()
	if not newMode then
		self:LoadSprite_Old(path, spriteComponent, callBack)
		return
	end
	self:DoLoadSprite(path, spriteComponent, callBack)
end

function LuaMonoBehavior:LoadSpriteAsync(path, callBack, image)
	local newMode = self:NewResourceVersion()
	if not newMode then
		self:LoadSprite_Old(path, nil, callBack)
		return
	end
	self:DoLoadSprite(path, nil, callBack)
end

function LuaMonoBehavior:LoadSpineGraphic(name, callBack)
	local path = ResMgr:GetSpineGraphicPath(name)
	self:LoadPrefab(path, callBack)
end

function LuaMonoBehavior:LoadCharQImgSprite(path, spriteComponent, callBack)
	local path = ResMgr:GetCharQImgSpritePath(path)
	self:LoadSprite(path, spriteComponent, callBack)
end

function LuaMonoBehavior:LoadCharImgSprite(id, spriteComponent, callBack)
	local path = ResMgr:GetCharImgSpritePath(id)
	self:LoadSprite(path, spriteComponent, callBack)
end

function LuaMonoBehavior:LoadCharSmallImgSprite(id, spriteComponent, callBack)
	local path = ResMgr:GetCharSmallImgSpritePath(id)
	self:LoadSprite(path, spriteComponent, callBack)
end

function LuaMonoBehavior:LoadHeadSprite(id, spriteComponent, callBack)
	local path = ResMgr:GetHeadSpritePath(id)
	self:LoadSprite(path, spriteComponent, callBack)
end


function LuaMonoBehavior:LoadLevelImageSprite(id, spriteComponent, callBack)
	local path = ResMgr:GetLevelImageSpritePath(id)
	self:LoadSprite(path, spriteComponent, callBack)
end


function LuaMonoBehavior:LoadLianGongFangSprite(id, spriteComponent, callBack)
	local path = ResMgr:GetLianGongFangSpritePath(id)
	self:LoadSprite(path, spriteComponent, callBack)
end

function LuaMonoBehavior:LoadBattleEffect(id, callback)  
	local path = ResMgr:GetBattleEffect(id)
	self:LoadPrefab(path, callback)
end

function LuaMonoBehavior:LoadEffect(id, callback)  
	local path = ResMgr:GetEffectPath(id)
	self:LoadPrefab(path, callback)
end

function LuaMonoBehavior:LoadBattleEffectInstantiate(id, callback)  
	local path = ResMgr:GetBattleEffect(id)
	self:LoadInstantiatePrefab(path, callback)
end


function LuaMonoBehavior:LoadUniqueEquipSprite(id, spriteComponent, callBack)
	local path = ResMgr:GetUniqueEquipSpritePath(id)
	self:LoadSprite(path, spriteComponent, callBack)
end


function LuaMonoBehavior:LoadHunYuanWuXingSprite(id, spriteComponent, callBack)
	local path = ResMgr:GetHunYuanWuXingSpritePath(id)
	self:LoadSprite(path, spriteComponent, callBack)
end

function LuaMonoBehavior:LoadMoonIdentifySprite(id, spriteComponent, callBack)
	local path = ResMgr:GetMoonIdentifySpritePath(id)
	self:LoadSprite(path, spriteComponent, callBack)
end
function LuaMonoBehavior:LoadTikTokSprite(name, spriteComponent, callBack)   
	local path = ResMgr:GetTikTokSpritePath(name)
	self:LoadSprite(path, spriteComponent, callBack)
end


function LuaMonoBehavior:LoadTikTokPngSprite(name, spriteComponent, callBack)
	local path = ResMgr:GetTikTokPngSpritePath(name)
	self:LoadSprite(path, spriteComponent, callBack)
end

function LuaMonoBehavior:LoadGiftPreviewSprite(name, spriteComponent, callBack)
	local path = ResMgr:GetGiftPreviewSpritePath(name)
	self:LoadSprite(path, spriteComponent, callBack)
end

function LuaMonoBehavior:LoadEscortSprite(name, spriteComponent, callBack)
	local path = ResMgr:GetEscortSpritePath(name)
	self:LoadSprite(path, spriteComponent, callBack)
end

function LuaMonoBehavior:LoadAudioClipAsync(path, callback)
	self._mono:LoadAudioClipRes(path, callback)
end
function LuaMonoBehavior:LoadFontAsync(path, callback)
	self._mono:LoadFontRes(path, callback)
end
function LuaMonoBehavior:LoadMaterialAsync(path, callback)
	self._mono:LoadMaterialRes(path, callback)
end
function LuaMonoBehavior:LoadCurveLibraryAsync(path, callback)
	self._mono:LoadCurveLibraryRes(path, callback)
end
function LuaMonoBehavior:LoadSceneAsync(path, additive, callback)
	self._mono:LoadSceneRes(path, additive, callback)
end

function LuaMonoBehavior:LuaPlayBgm(path, loop, callback)
	local ret = AudioMgr:LuaPlayBgm(path, LuaMain.gameObject, loop, callback)
	return ret
end

function LuaMonoBehavior:LuaPlayBgmFade(path, loop, callback, fadeTime)
	local ret = AudioMgr:LuaPlayBgmFade(path, LuaMain.gameObject, loop, callback, fadeTime)
	return ret
end

function LuaMonoBehavior:play2DSound(audioPath, volume, loopTime, callBack, track, fadeTime, fadeEase)
	local ret = AudioMgr:play2DSound(audioPath, self.gameObject, volume, loopTime, callBack, track, fadeTime, fadeEase)
	return ret
end

function LuaMonoBehavior:play2DVoice(audioPath, volume, loopTime, callBack, track, fadeTime, fadeEase)
	local ret = AudioMgr:play2DVoice(audioPath, self.gameObject, volume, loopTime, callBack, track, fadeTime, fadeEase)
	return ret
end

function LuaMonoBehavior:play3DSound(audioPath, volume, loopTime, callBack, track, fadeTime, fadeEase, obj, maxDistanceSE, minDistance)
	local ret = AudioMgr:play3DSound(audioPath, self.gameObject, volume, loopTime, callBack, track, fadeTime, fadeEase, obj, maxDistanceSE, minDistance)
	return ret
end

function LuaMonoBehavior:DoAfter(delayTime, callback, ...)
	local ret = DLuaTimer:DoAfterIfValid(self.gameObject, delayTime, callback, ...)
	return ret
end

function LuaMonoBehavior:DoRepeat(interval, times, callback)
	local ret = DLuaTimer:DoRepeatIfValid(self.gameObject, interval, times, callback)
	return ret
end

function LuaMonoBehavior:DoRepeatForever(interval, callback)
	local ret = DLuaTimer:DoRepeatForeverIfValid(self.gameObject, interval, callback)
	return ret
end

function LuaMonoBehavior:Attach(go)
	local ins = self:New(go)
	LuaHelper.AddLuaMonoComp(go, ins)
	if ins.Awake then
		ins:Awake()
	end
	if ins.OnEnable and go.activeSelf then
		ins:OnEnable()
	end
	return ins
end

return LuaMonoBehavior