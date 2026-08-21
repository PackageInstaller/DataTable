---##################### 【BombGamePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【BombGamePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
---@class BombGamePanel : BombGamePanel_Generate
---@field private _state string
---@field private _remainTime number
---@field private _score integer
---@field private _ship BombGameShip
---@field private _bombCd number
---@field private _ammo integer
---@field private _ammoRecoverCd number
---@field private _shipHp integer
---@field private _shipDamageCd number
---@field private _enemyProjectiles table[]
---@field private _floatingTexts table[]
---@field private _fishes BombGameFish[]
---@field private _pendingBombs table[]
---@field private _bombs BombGameBomb[]
---@field private _bombEffects table[]
---@field private _drops BombGameEffect[]
---@field private _effects ActiveEffectData[]
---@field private _respawnQueue table[]
---@field private _fillState fillStateData
---@field private _settleData table
---@field private _bgScrollItems table[]
---@field private _lifeImages UnityEngine.GameObject[]
---@field private _ammoImages table[]
---@field private _lifeAnimatingIndex integer?
---@field private _superBombCount integer
---@field private _superBombBusy boolean
---@field private _enemyProjectileViewPool viewEntry[]
---@field private _countdownStep integer
---@field private _countdownStepLeft number
---@field private _pendingStart boolean
---@field private _topUi UnityEngine.GameObject?
---@field private _settleCloseReady boolean
---@field private _joystickRadius number
---@field private _keyboardJoystickActive boolean
---@field private _touchId number?
---@field private mouseDownPosition any
---@field private _circleOriginalAnchoredPosition any
local BombGamePanel = require "BombGamePanel_Generate"
---@type BombGameShip
local BombGameShip = require "BombGameShip"
---@type BombGameFish
local BombGameFish = require "BombGameFish"
---@type BombGameBomb
local BombGameBomb = require "BombGameBomb"
---@type BombGameEffect
local BombGameEffect = require "BombGameEffect"

local Input = UnityEngine.Input
local KeyCode = UnityEngine.KeyCode

local enemyImgName = "minigame_depthcharge_icon_enemy_0%d"
local enemyProjectileEndDuration = 0.18
local lifeLoseAnimDuration = 0.28
local flowFadeDuration = 0.2
local countdownPopDuration = 0.18
local settleCloseDelay = 1
local shipHitBlinkStep = 0.1
local shipHitBlinkAlpha = 0.25
-- 左右轴死区：相对摇杆半径比例，仅左右二方向
local joystickAxisDeadZone = 0.2

---@type {widget:string, durationKey:string}[]
local COUNTDOWN_STEPS = {
    {widget = "countImg3", durationKey = "countdownNumberDuration"},
    {widget = "countImg2", durationKey = "countdownNumberDuration"},
    {widget = "countImg1", durationKey = "countdownNumberDuration"},
    {widget = "readyImg", durationKey = "countdownReadyDuration"},
    {widget = "goImg", durationKey = "countdownGoDuration"},
}

---@enum BombGameEnemyProjectileType
local ENEMY_PROJECTILE_TYPE = {
    DAO_DAN = "dao_dan",
    SHUI_LEI = "shui_lei",
    YU_LEI = "yu_lei",
}

---@param attack table?
---@return BombGameEnemyProjectileType
local function resolveEnemyProjectileType(attack)
    if attack and attack.projectileType then
        return attack.projectileType
    end
    local mode = attack and attack.mode or "straight"
    if mode == "track_burst" then
        return ENEMY_PROJECTILE_TYPE.DAO_DAN
    end
    if mode == "track" then
        return ENEMY_PROJECTILE_TYPE.YU_LEI
    end
    return ENEMY_PROJECTILE_TYPE.SHUI_LEI
end

---@param projectileType BombGameEnemyProjectileType
---@return number, number
local function getEnemyProjectileHitBox(projectileType, cfg)
    local hitBoxCfg = cfg.enemyProjectileHitBox or {}
    local hitBox = hitBoxCfg[projectileType]
    if hitBox then
        return hitBox.halfWidth or cfg.enemyProjectileHalfWidth, hitBox.halfHeight or cfg.enemyProjectileHalfHeight
    end
    return cfg.enemyProjectileHalfWidth, cfg.enemyProjectileHalfHeight
end

---@param projectileType BombGameEnemyProjectileType
---@return boolean
local function isTrackingEnemyProjectile(projectileType)
    return projectileType == ENEMY_PROJECTILE_TYPE.DAO_DAN
        or projectileType == ENEMY_PROJECTILE_TYPE.YU_LEI
end

---@generic T:number|integer
---@param value T
---@param minValue T
---@param maxValue T
---@return T
local function clamp(value, minValue, maxValue)
    if value < minValue then
        return minValue
    end
    if value > maxValue then
        return maxValue
    end
    return value
end

local function distanceSq(x1, y1, x2, y2)
    local dx = x1 - x2
    local dy = y1 - y2
    return dx * dx + dy * dy
end

---@param minX number
---@param maxX number
---@param minY number
---@param maxY number
---@param centerX number
---@param centerY number
---@param radius number
---@return boolean
local function isCircleIntersectBox(minX, maxX, minY, maxY, centerX, centerY, radius)
    local closestX = clamp(centerX, minX, maxX)
    local closestY = clamp(centerY, minY, maxY)
    return distanceSq(centerX, centerY, closestX, closestY) <= radius * radius
end

---@param leftMinX number
---@param leftMaxX number
---@param leftMinY number
---@param leftMaxY number
---@param rightMinX number
---@param rightMaxX number
---@param rightMinY number
---@param rightMaxY number
---@return boolean
local function isBoxIntersect(leftMinX, leftMaxX, leftMinY, leftMaxY, rightMinX, rightMaxX, rightMinY, rightMaxY)
    return leftMinX <= rightMaxX
        and leftMaxX >= rightMinX
        and leftMinY <= rightMaxY
        and leftMaxY >= rightMinY
end

local function copyTable(source)
    local target = {}
    for key, value in pairs(source) do
        target[key] = value
    end
    return target
end

local function formatScorePrompt(score, comboMul)
    return string.format("%dX%d", score, comboMul)
end

---@param rootTransform UnityEngine.Transform
---@param paths string[]
---@return UnityEngine.Transform?
local function findOptionalTransform(rootTransform, paths)
    if not rootTransform then
        return nil
    end
    for _, path in ipairs(paths) do
        local node = rootTransform:Find(path)
        if node then
            return node
        end
    end
    return nil
end

---@class viewEntry
---@field transform UnityEngine.Transform
---@field inUse boolean
---@field isDynamic boolean?

---@param rootTransform UnityEngine.Transform?
local function buildViewPool(rootTransform)
    local pool = {}
    if not rootTransform then
        return pool
    end
    for index = 0, rootTransform.childCount - 1 do
        local child = rootTransform:GetChild(index)
        child.gameObject:SetActive(false)
        table.insert(pool, {
            transform = child,
            inUse = false,
            isDynamic = false,
        })
    end
    return pool
end

---@param pool viewEntry[]
---@param originObject UnityEngine.Transform
---@param parent UnityEngine.Transform
local function acquireViewEntry(pool, originObject, parent, needLog)
    local getEntry = nil
    for _, entry in ipairs(pool) do
        if entry.inUse ~= true then
            entry.inUse = true
            if entry.transform and not IsNull(entry.transform) and not IsNull(entry.transform.gameObject) then
                entry.transform.gameObject:SetActive(true)
            else
                entry.transform = nil
            end
            getEntry = entry
            break
        end
    end
    if not getEntry then
        ---@type UnityEngine.GameObject
        local newTransform = GameObject.Instantiate(originObject.gameObject)
        newTransform.gameObject:SetActive(true)
        if parent then
            newTransform.transform:SetParent(parent, false)
        end
        getEntry = {
            transform = newTransform.transform,
            inUse = true,
            isDynamic = true,
        }
        table.insert(pool, getEntry)
    end
    return getEntry
end

---@param entry viewEntry
---@param destroy boolean?
local function releaseViewEntry(entry, destroy)
    if not entry then
        return
    end
    entry.inUse = false
    if entry.transform and not IsNull(entry.transform) and not IsNull(entry.transform.gameObject) then
        local gameObject = entry.transform.gameObject
        gameObject:SetActive(false)
        if destroy == true then
            GameObject.Destroy(gameObject)
            entry.transform = nil
        end
    else
        entry.transform = nil
    end
end

---@param index integer
---@param totalCount integer
---@param minX number
---@param maxX number
---@param jitterRange number
---@return number
local function getDistributedSpawnX(index, totalCount, minX, maxX, jitterRange)
    local safeTotal = math.max(totalCount or 1, 1)
    local safeIndex = clamp(index or 1, 1, safeTotal)
    local slotWidth = (maxX - minX) / (safeTotal + 1)
    local spawnX = minX + slotWidth * safeIndex
    local halfJitter = math.min(math.max(jitterRange or 0, 0), slotWidth * 0.35)
    if halfJitter > 0 then
        spawnX = spawnX + math.random(-math.floor(halfJitter), math.floor(halfJitter))
    end
    return clamp(spawnX, minX, maxX)
end

local function getDefaultConfig()
    local defaultCfg = {
        duration = 120,
        startDelay = 1.2,
        introDuration = 1.2,
        countdownNumberDuration = 0.7,
        countdownReadyDuration = 0.4,
        countdownGoDuration = 0.35,
        shipStartX = -60,
        shipCenterX = 0,
        shipMinX = -960,
        shipMaxX = 960,
        shipBaseSpeed = 300,
        shipHp = 5,
        shipDamageInvuln = 2.5,
        shipHitHalfWidth = 53,
        shipHitHalfHeight = 67,
        shipHitOffsetY = 67,
        waterSurfaceY = -255,
        waterBottomY = -1080,
        fishMinX = -1050,
        fishMaxX = 1050,
        enemyProjectileSpeed = 150,
        enemyProjectileTrackSpeed = 400,
        enemyProjectileTrackDuration = 1,
        enemyProjectileTrackStopDistance = 20,
        enemyProjectileBurstSpeedMul = 1.18,
        enemyProjectileBurstTrackSpeedMul = 1.18,
        enemyProjectileHalfWidth = 17,
        enemyProjectileHalfHeight = 17,
        enemyProjectileHitBox = {
            shui_lei = {halfWidth = 29, halfHeight = 29},
            yu_lei = {halfWidth = 15, halfHeight = 55},
            dao_dan = {halfWidth = 5, halfHeight = 26.5},
        },
        enemyProjectileSpawnOffsetY = 48,
        enemyProjectileDespawnOffsetY = 120,
        enemyProjectileSurfaceOvershoot = 5,
        enemyMissileScreenEdgeMargin = 30,
        daoDanSpawnDepth = 80,
        daoDanSpeedMul = 1.25,
        shuiLeiFlashDuration = 0.56,
        shuiLeiFlashAlpha = 0.25,
        shuiLeiFlashStepDuration = 0.08,
        yuLeiEndDuration = 0.12,
        enemyProjectileTrackTiltLeft = 45,
        enemyProjectileTrackTiltRight = -45,
        rushAimTolerance = 15,
        rushPauseDuration = 0.8,
        rushApproachSpeed = 420,
        rushBurstCount = 3,
        rushBurstInterval = 0.16,
        rushOffscreenPadding = 220,
        comboWindow = 2.5,
        riseMoveDuration = 1,
        risePauseDuration = 0.8,
        bombCd = 0.5,
        maxAmmo = 5,
        ammoRecoverCd = 1.5,
        bombSpawnDelay = 0.3,
        bombFallSpeed = 200,
        bombHitHalfWidth = 8.5,
        bombHitHalfHeight = 35,
        bombCollisionRadius = 80,
        bombBlastRadius = 200,
        bombDamage = 200,
        bombDamageFalloff = 0.9,
        bombEffectDuration = 0.5,
        targetFishCount = 15,
        initialFishRatio = 0.6,
        initialFillDuration = 10,
        refillDuration = 10,
        layerRespawnDelay = 0.1,
        maxDropStayTime = 6,
        dropRiseSpeed = 200,
        dropSurfaceOffset = 42,
        dropFloatAmplitude = 8,
        dropFloatSpeed = 1.8,
        pickupRadius = 40,
        initialSpawnJitter = 90,
        edgeSpawnXOffset = 120,
        edgeSpawnLayerOffset = 30,
        edgeSpawnYOffset = 28,
        dropPickupScore = 1000,
        bgRespawnJitterMin = 60,
        bgRespawnJitterMax = 240,
        cloudBgSpeeds = {18, 26, 34},
        fishBgBaseSpeeds = {42, 58},
        fishBgSpeedMulMin = 0.65,
        fishBgSpeedMulMax = 1.4,
        fishBgSpeedChangeMin = 0.8,
        fishBgSpeedChangeMax = 2.2,

        ---@class sprintData
        ---@field cooldown number
        ---@field duration number
        ---@field speedMul number

        ---@class fishData
        ---@field id string
        ---@field hp integer
        ---@field speed number
        ---@field score integer
        ---@field radius number
        ---@field dropChance number
        ---@field respawnDelay number
        ---@field sprint sprintData?
        ---@field layerWeights integer[]
        ---@field fishIconId integer
        ---@field fishScale number[]
        ---@field attack table?
        ---@field moveMode string?
        ---@field explodeOnDeath boolean?
        ---@field explodeRadius number?

        ---@type fishData[] 鱼群信息，实际属性和权重请根据游戏设计调整
        fishTypes = {
            {
                id = "scout",
                hp = 80,
                speed = 150,
                score = 60,
                radius = 50,
                dropChance = 0,
                respawnDelay = 0.9,
                sprint = nil,
                attack = {mode = "straight", projectileType = ENEMY_PROJECTILE_TYPE.SHUI_LEI, cooldown = 25, randomStart = 10},
                layerWeights = {30, 26, 2, 0, 0, 0, 0},
                fishIconId = 1,
                fishScale = {0.4, 0.4, 0.4}
            },
            {
                id = "raider",
                hp = 160,
                speed = 200,
                score = 120,
                radius = 80,
                dropChance = 0,
                respawnDelay = 1.2,
                sprint = {cooldown = 4.2, duration = 0.8, speedMul = 1.8},
                attack = {mode = "track", projectileType = ENEMY_PROJECTILE_TYPE.YU_LEI, cooldown = 8, randomStart = 2.1},
                layerWeights = {0, 0, 5, 5, 16, 0, 0},
                fishIconId = 2,
                fishScale = {0.7, 0.7, 0.7}
            },
            {
                id = "elite",
                hp = 150,
                speed = 300,
                score = 220,
                radius = 96,
                dropChance = 0,
                respawnDelay = 1.6,
                sprint = {cooldown = 5.5, duration = 1.1, speedMul = 2.1},
                attack = {mode = "straight", projectileType = ENEMY_PROJECTILE_TYPE.SHUI_LEI, cooldown = 15, randomStart = 0},
                layerWeights = {0, 4, 8, 15, 20, 20, 16},
                fishIconId = 3,
                fishScale = {0.5, 0.5, 0.5}
            },
            {
                id = "bossling",
                hp = 145,
                speed = 300,
                score = 420,
                radius = 144,
                dropChance = 1,
                respawnDelay = 2,
                sprint = {cooldown = 6.5, duration = 1.3, speedMul = 2.3},
                attack = {mode = "track", projectileType = ENEMY_PROJECTILE_TYPE.YU_LEI, cooldown = 18, randomStart = 1.3},
                layerWeights = {0, 0, 10, 20, 0, 0, 0},
                fishIconId = 4,
                fishScale = {0.5, 0.5, 0.5}
            },
            {
                id = "suicide",
                hp = 110,
                speed = 105,
                score = 260,
                radius = 90,
                dropChance = 0,
                respawnDelay = 1.8,
                sprint = nil,
                attack = nil,
                moveMode = "rise_diagonal",
                explodeOnDeath = true,
                explodeRadius = 170,
                layerWeights = {0, 0, 0, 0, 0, 0, 0},
                fishIconId = 2,
                fishScale = {0.5, 0.5, 0.5}
            },
            {
                id = "ambusher",
                hp = 170,
                speed = 210,
                score = 300,
                radius = 92,
                dropChance = 0,
                respawnDelay = 1.9,
                sprint = nil,
                attack = {
                    mode = "track_burst",
                    projectileType = ENEMY_PROJECTILE_TYPE.DAO_DAN,
                    cooldown = 1,
                    randomStart = 1,
                    burstCount = 3,
                    burstInterval = 0.16,
                    speedMul = 1.18,
                    trackSpeedMul = 1.18,
                },
                moveMode = "rush_track_burst",
                layerWeights = {0, 0, 20, 30, 0, 0, 0},
                fishIconId = 4,
                fishScale = {0.5, 0.5, 0.5}
            },
        },
        ---@class dropData
        ---@field id string
        ---@field isBuff boolean
        ---@field duration number
        ---@field weight integer

        ---@type dropData[] 掉落物假数据，实际掉落物和权重请根据游戏设计调整
        dropTypes = {
            {id = "speed_up", isBuff = true, duration = 8, weight = 0},
            {id = "bomb_up", isBuff = true, duration = 10, weight = 0},
            {id = "range_up", isBuff = true, duration = 10, weight = 0},
            {id = "score_up", isBuff = true, duration = 9, weight = 0},
            {id = "super_bomb", isBuff = true, duration = 0, weight = 0},
            {id = "slow", isBuff = false, duration = 5, weight = 0},
            {id = "stun", isBuff = false, duration = 2, weight = 0},
            {id = "mine", isBuff = false, duration = 0, weight = 0},
        },
    }

    defaultCfg.dropRiseSpeed = defaultCfg.bombFallSpeed

    local layerCount = 4
    local layerSpacing = (defaultCfg.waterSurfaceY - defaultCfg.waterBottomY - 150) / (layerCount + 1)
    defaultCfg.layerCenters = {}
    for i = 1, layerCount do
        local curLayer = layerCount - i + 1
        defaultCfg.layerCenters[i] = defaultCfg.waterBottomY + curLayer * layerSpacing
    end
    return defaultCfg
end

---@generic T:table
---@param items T[]
---@param key string
---@return T
local function getWeightedPick(items, key)
    local total = 0
    for _, item in ipairs(items) do
        total = total + (item[key] or 0)
    end
    if total <= 0 then
        return items[1]
    end
    local roll = math.random() * total
    local acc = 0
    for _, item in ipairs(items) do
        acc = acc + (item[key] or 0)
        if roll <= acc then
            return item
        end
    end
    return items[#items]
end

function BombGamePanel:InitLogic(data)
    self._cfg = getDefaultConfig()
    if data and data.cfg then
        for key, value in pairs(data.cfg) do
            self._cfg[key] = value
        end
    end

    self._stateTimer = 0
    self._remainTime = self._cfg.duration
    self._score = 0
    self._bombCd = 0
    self._ammo = self._cfg.maxAmmo
    self._ammoRecoverCd = self._cfg.ammoRecoverCd
    self._shipHp = self._cfg.shipHp
    self._shipDamageCd = 0
    self._lifeAnimatingIndex = nil
    self._superBombCount = 1
    self._superBombBusy = false
    self._enemyProjectiles = {}
    self._fishes = {}
    self._pendingBombs = {}
    self._bombs = {}
    self._bombEffects = {}
    self._drops = {}
    self._effects = {}
    self._floatingTexts = {}
    self._respawnQueue = {}
    self._fillState = nil
    self._settleData = nil
    self._rewardSent = false
    self._summaryText = ""
    self._openData = data
    self._bgScrollItems = nil
    self._countdownStep = 0
    self._countdownStepLeft = 0
    self._pendingStart = false
    self._topUi = nil
    self._ammoImages = {}
    self._lifeImages = {
        self.lifeImg1,
        self.lifeImg2,
        self.lifeImg3,
        self.lifeImg4,
        self.lifeImg5,
    }

    self:_initEntityViewPools()
    self:_initJoystick()
end

function BombGamePanel:OnOpen(data, initiative)
    if not self._fishViewPool or not self._bombViewPool or not self._effectViewPool or not self._enemyProjectileViewPool then
        self:_initEntityViewPools()
    else
        self:_hideEnemyProjectileTemplates()
    end
    self:SetUpdateInterval(0)
    self._stateTimer = 0
    self._remainTime = self._cfg.duration
    self._score = 0
    self._bombCd = 0
    self._ammo = self._cfg.maxAmmo
    self._ammoRecoverCd = self._cfg.ammoRecoverCd
    self._shipHp = self._cfg.shipHp
    self._shipDamageCd = 0
    self._lifeAnimatingIndex = nil
    self._superBombCount = 1
    self._superBombBusy = false
    self._enemyProjectiles = {}
    self._pendingBombs = {}
    self._fishes = {}
    self._bombs = {}
    self._bombEffects = {}
    self._drops = {}
    self._effects = {}
    self._floatingTexts = {}
    self._respawnQueue = {}
    self._fillState = nil
    self._instanceId = 0
    self._countdownStep = 0
    self._countdownStepLeft = 0
    self._pendingStart = false
    self._rewardSent = false
    self._settleData = nil
    self._settleCloseReady = false
    self._state = "start"
    self:_applyFlowUi("start", true)
    if self.startBtn and self.startBtn.scaleButton then
        self.startBtn.scaleButton.interactable = true
    end

    local prefabName = "Role_kidQ"
    local path = string.format(Config.PrefabPath.BombGameSpine, prefabName)
    self:LoadInstantiatePrefab(path, function(prefab)
        if prefab then
            local newTransform = prefab
            newTransform.transform:SetParent(self.roleObject.rectTransform, false)
            newTransform.gameObject:SetActive(true)
            newTransform.transform.localScale = Vector3.New(0.12, 0.12, 0.12)
            newTransform.transform.localPosition = Vector3.zero
            self._shipViewEntry = {
                transform = self.roleObject.rectTransform,
                roleObj = newTransform,
                waterLineObj = self.effect_Ui_XiaoYouXi_TuoWei,
                inUse = true,
            }
            self.roleObject.rectTransform:SetParent(self.gameArea.rectTransform, false)
            self._ship = BombGameShip:new(nil, self._cfg, self._shipViewEntry)
            self._ship:SetX(self._cfg.shipCenterX)
            self._ship:Stop()
        end
        if self._pendingStart and self._state == "start" then
            self._pendingStart = false
            self:_beginCountdownFlow()
        end
    end)

    local panelSize = self.rectTransform.rect.size
    local leftSizeX = panelSize.x / 2 - self._cfg.shipMaxX
    local areaSizeX = self._cfg.shipMaxX - self._cfg.shipMinX
    self.gameArea.rectTransform:SetSizeWithCurrentAnchors(UnityEngine.RectTransform.Axis.Horizontal, areaSizeX)
    self.topUI.rectTransform:SetSizeWithCurrentAnchors(UnityEngine.RectTransform.Axis.Horizontal, areaSizeX)
    self.leftMask.rectTransform:SetSizeWithCurrentAnchors(UnityEngine.RectTransform.Axis.Horizontal, leftSizeX)
    self.rightMask.rectTransform:SetSizeWithCurrentAnchors(UnityEngine.RectTransform.Axis.Horizontal, leftSizeX)
    self:_initBgScrollItems()
    self:_refreshHud()
    if self._state == "playing" then
        self:_refreshSuperBombBtn()
    else
        self:_setPlayingControlsVisible(false)
    end
end

function BombGamePanel:OnClose(initiative)
    self:_killFlowTweens()
    self:_stopShipHitBlink()
    self:_resetJoystick()
    self._bgScrollItems = nil
    self._pendingStart = false
    self:_cleanupRuntimeEntities()
    if self._ship then
        self._ship:Stop()
        local shipObj = self._shipViewEntry.roleObj
        if shipObj then
            GameObject.Destroy(shipObj)
        end
    end
    self._ship = nil
    self._shipViewEntry = nil
end

function BombGamePanel:OnDestroy()
    self:_cleanupRuntimeEntities()
    self._ship = nil
    self._fishes = nil
    self._pendingBombs = nil
    self._bombs = nil
    self._bombEffects = nil
    self._drops = nil
    self._effects = nil
    self._respawnQueue = nil
    self._floatingTexts = nil

    self.super:OnDestroy(self)
end

---@param pool viewEntry[]?
local function cleanupViewPool(pool)
    if not pool then
        return
    end
    for index = #pool, 1, -1 do
        local entry = pool[index]
        releaseViewEntry(entry, true)
        table.remove(pool, index)
    end
end

function BombGamePanel:_cleanupRuntimeEntities()
    self._lastUpdateTime = nil
    self._fillState = nil
    self._respawnQueue = {}
    self._effects = {}
    self._fishes = {}
    self._pendingBombs = {}
    self._bombs = {}
    self._enemyProjectiles = {}
    self._lifeAnimatingIndex = nil
    self._superBombCount = 1
    self._superBombBusy = false
    self._bombEffects = {}
    self._drops = {}
    self:_clearAmmoImages()
    self:_clearFloatingTexts()
    cleanupViewPool(self._fishViewPool)
    cleanupViewPool(self._bombViewPool)
    if self._enemyProjectileViewPool then
        for _, entry in ipairs(self._enemyProjectileViewPool) do
            self:_clearEnemyProjectileVisuals(entry, true)
        end
        cleanupViewPool(self._enemyProjectileViewPool)
    end
    cleanupViewPool(self._effectViewPool)
    cleanupViewPool(self._bombExploreEffectViewEntry)
    cleanupViewPool(self._scoreTextViewPool)
    self._fishViewPool = nil
    self._bombViewPool = nil
    self._enemyProjectileViewPool = nil
    self._effectViewPool = nil
    self._bombExploreEffectViewEntry = nil
    self._scoreTextViewPool = nil
end

function BombGamePanel:_hideEnemyProjectileTemplates()
    if self.enemyBombObject then
        self.enemyBombObject:SetActive(false)
    end
    local templates = {
        self.effect_Ui_XiaoYouXi_DaoDan,
        self.effect_Ui_XiaoYouXi_ShuiLei,
        self.effect_Ui_XiaoYouXi_YuLei,
    }
    for _, templateObject in ipairs(templates) do
        if templateObject then
            templateObject:SetActive(false)
        end
    end
end

---@param projectileType BombGameEnemyProjectileType
---@return UnityEngine.Transform?
function BombGamePanel:_getEnemyProjectileEffectTemplate(projectileType)
    local templateObject = nil
    if projectileType == ENEMY_PROJECTILE_TYPE.DAO_DAN then
        templateObject = self.effect_Ui_XiaoYouXi_DaoDan
    elseif projectileType == ENEMY_PROJECTILE_TYPE.SHUI_LEI then
        templateObject = self.effect_Ui_XiaoYouXi_ShuiLei
    elseif projectileType == ENEMY_PROJECTILE_TYPE.YU_LEI then
        templateObject = self.effect_Ui_XiaoYouXi_YuLei
    end
    return templateObject and templateObject.transform or nil
end

---@param viewEntry viewEntry
---@param destroy boolean?
function BombGamePanel:_clearEnemyProjectileVisuals(viewEntry, destroy)
    if not viewEntry or not viewEntry.effectVisuals then
        return
    end
    for _, visualTransform in pairs(viewEntry.effectVisuals) do
        if visualTransform and not IsNull(visualTransform) and not IsNull(visualTransform.gameObject) then
            if destroy == true then
                GameObject.Destroy(visualTransform.gameObject)
            else
                visualTransform.gameObject:SetActive(false)
            end
        end
    end
    if destroy == true then
        viewEntry.effectVisuals = nil
    end
end

---@param viewEntry viewEntry
---@param projectileType BombGameEnemyProjectileType
function BombGamePanel:_setupEnemyProjectileVisual(viewEntry, projectileType)
    if not viewEntry or not viewEntry.transform then
        return
    end
    viewEntry.effectVisuals = viewEntry.effectVisuals or {}
    for typeKey, visualTransform in pairs(viewEntry.effectVisuals) do
        if visualTransform and not IsNull(visualTransform) and not IsNull(visualTransform.gameObject) then
            visualTransform.gameObject:SetActive(typeKey == projectileType)
        end
    end

    local _, halfHeight = getEnemyProjectileHitBox(projectileType, self._cfg)
    -- 水雷宽高一致，表现与碰撞盒原点对齐；鱼雷/导弹按半高上移，避免表现偏下
    local effectLocalY = 0
    if projectileType ~= ENEMY_PROJECTILE_TYPE.SHUI_LEI then
        effectLocalY = halfHeight or 0
    end

    local effectTransform = viewEntry.effectVisuals[projectileType]
    if effectTransform and not IsNull(effectTransform) and not IsNull(effectTransform.gameObject) then
        effectTransform.gameObject:SetActive(true)
        effectTransform.localPosition = Vector3.New(0, effectLocalY, 0)
        return
    end

    local templateTransform = self:_getEnemyProjectileEffectTemplate(projectileType)
    if not templateTransform then
        return
    end
    ---@type UnityEngine.GameObject
    local effectObject = GameObject.Instantiate(templateTransform.gameObject)
    effectObject.transform:SetParent(viewEntry.transform, false)
    effectObject:SetActive(true)
    local visualScale = projectileType == ENEMY_PROJECTILE_TYPE.SHUI_LEI and 2 or 3
    effectObject.transform.localScale = Vector3.New(visualScale, visualScale, visualScale)
    effectObject.transform.localPosition = Vector3.New(0, effectLocalY, 0)
    viewEntry.effectVisuals[projectileType] = effectObject.transform
end

function BombGamePanel:_initEntityViewPools()
    self:_hideEnemyProjectileTemplates()
    local shipTransform = findOptionalTransform(self.transform, {
        "poolRoot/ShipObject",
    })
    self._shipViewEntry = shipTransform and {transform = shipTransform.transform, inUse = true} or nil
    self._fishViewPool = buildViewPool(findOptionalTransform(self.transform, {
        "poolRoot/FishRoot",
    }))
    self._bombViewPool = buildViewPool(findOptionalTransform(self.transform, {
        "poolRoot/BombRoot",
    }))
    self._enemyProjectileViewPool = {}
    self._effectViewPool = buildViewPool(findOptionalTransform(self.transform, {
        "poolRoot/EffectRoot",
    }))
    self._bombExploreEffectViewEntry = buildViewPool(findOptionalTransform(self.transform, {
        "poolRoot/BombEffectRoot",
    }))
    self._scoreTextViewPool = buildViewPool(findOptionalTransform(self.transform, {
        "poolRoot/ScoreTextRoot",
    }))
end

function BombGamePanel:_acquireFishViewEntry()
    return acquireViewEntry(self._fishViewPool or {}, self.fishObject.rectTransform, self.gameArea.rectTransform)
end

function BombGamePanel:_acquireBombViewEntry()
    return acquireViewEntry(self._bombViewPool or {}, self.bombObject.rectTransform, self.gameArea.rectTransform, true)
end

function BombGamePanel:_acquireEffectViewEntry()
    return acquireViewEntry(self._effectViewPool or {}, self.effectObject.rectTransform, self.gameArea.rectTransform)
end

---@param projectileType BombGameEnemyProjectileType
function BombGamePanel:_acquireEnemyProjectileViewEntry(projectileType)
    if not self.enemyBombObject or not self.enemyBombObject.rectTransform or not self.gameArea or not self.gameArea.rectTransform then
        return nil
    end
    local viewEntry = acquireViewEntry(
        self._enemyProjectileViewPool or {},
        self.enemyBombObject.rectTransform,
        self.gameArea.rectTransform
    )
    if viewEntry then
        self:_setupEnemyProjectileVisual(viewEntry, projectileType)
    end
    return viewEntry
end

---获取炸弹爆炸特效
function BombGamePanel:_acquireBombEffectViewEntry()
    return acquireViewEntry(self._bombExploreEffectViewEntry or {}, self.bombEffectObject.rectTransform, self.gameArea.rectTransform)
end

function BombGamePanel:_acquireScoreTextViewEntry()
    return acquireViewEntry(self._scoreTextViewPool or {}, self.scoreTextObject.rectTransform, self.gameArea.rectTransform)
end

function BombGamePanel:Update()
    if not self.gameObject or not self.gameObject.activeInHierarchy then
        return
    end

    local time = Time.realtimeSinceStartup
    if not self._lastUpdateTime then
        self._lastUpdateTime = time
    end
    local dt = time - self._lastUpdateTime
    self._lastUpdateTime = time
    if not dt then
        return
    end

    self:_updateEffects(dt)
    self:_updateBgScroll(dt)
    self:_updateFillState(dt)
    self:_updateRespawnQueue(dt)
    self:_updatePendingBombs(dt)
    self:_updateJoystickDrag()

    if self._state == "start" then
        -- 等待点击开始
    elseif self._state == "countdown" then
        self:_updateCountdown(dt)
    elseif self._state == "playing" then
        self:_updatePlaying(dt)
    elseif self._state == "settling" then
        self:_updateSettling(dt)
    end

    self:_updateFishes(dt)
    self:_updateEnemyProjectiles(dt)
    self:_updateBombs(dt)
    self:_updateBombEffects(dt)
    self:_updateFloatingTexts(dt)
    self:_updateDrops(dt)
    self:_tryAutoPickupDrops()
    self:_checkForRefillNeed()
    self:_refreshHud()
end

---@param minValue number
---@param maxValue number
---@return number
local function getRandomRange(minValue, maxValue)
    if maxValue <= minValue then
        return minValue
    end
    return minValue + math.random() * (maxValue - minValue)
end

---@param widget any
---@param baseSpeed number
---@param isFishBg boolean?
---@return table?
function BombGamePanel:_buildBgScrollItem(widget, baseSpeed, isFishBg)
    if not widget or not widget.rectTransform then
        return nil
    end

    local rectTransform = widget.rectTransform
    local anchoredPos = rectTransform.anchoredPosition3D
    local width = math.abs(rectTransform.rect.width * rectTransform.localScale.x)
    local panelHalfWidth = self.rectTransform.rect.width * 0.5
    local halfWidth = width * 0.5
    local item = {
        rectTransform = rectTransform,
        originX = anchoredPos.x,
        y = anchoredPos.y,
        z = anchoredPos.z,
        x = anchoredPos.x,
        halfWidth = halfWidth,
        despawnX = -panelHalfWidth - halfWidth,
        respawnX = panelHalfWidth + halfWidth,
        respawnMinOffset = self._cfg.bgRespawnJitterMin,
        respawnMaxOffset = self._cfg.bgRespawnJitterMax,
        isFishBg = isFishBg == true,
        baseSpeed = baseSpeed,
        speed = baseSpeed,
        speedTimer = 0,
        speedChangeMin = self._cfg.fishBgSpeedChangeMin,
        speedChangeMax = self._cfg.fishBgSpeedChangeMax,
        speedMulMin = self._cfg.fishBgSpeedMulMin,
        speedMulMax = self._cfg.fishBgSpeedMulMax,
    }
    if item.isFishBg then
        self:_randomizeBgScrollSpeed(item, true)
    end
    return item
end

---@param item table
---@param resetTimer boolean?
function BombGamePanel:_randomizeBgScrollSpeed(item, resetTimer)
    if not item or not item.isFishBg then
        return
    end
    item.speed = item.baseSpeed * getRandomRange(item.speedMulMin, item.speedMulMax)
    if resetTimer ~= false then
        item.speedTimer = getRandomRange(item.speedChangeMin, item.speedChangeMax)
    end
end

function BombGamePanel:_initBgScrollItems()
    self._bgScrollItems = {}
    local cloudSpeeds = self._cfg.cloudBgSpeeds or {}
    local fishSpeeds = self._cfg.fishBgBaseSpeeds or {}
    local items = {
        self:_buildBgScrollItem(self.cloudBg1, cloudSpeeds[1] or 18, false),
        self:_buildBgScrollItem(self.cloudBg2, cloudSpeeds[2] or 26, false),
        self:_buildBgScrollItem(self.cloudBg3, cloudSpeeds[3] or 34, false),
        self:_buildBgScrollItem(self.fishBg1, fishSpeeds[1] or 42, true),
        self:_buildBgScrollItem(self.fishBg2, fishSpeeds[2] or 58, true),
    }
    for _, item in ipairs(items) do
        if item then
            table.insert(self._bgScrollItems, item)
        end
    end
end

function BombGamePanel:_rebuildAmmoImages()
    self:_clearAmmoImages()
    if not self.bombNode or not self.bombNode.rectTransform or not self.bombImg or not self.bombImg.gameObject then
        return
    end

    local maxAmmo = self:_getMaxAmmo()
    for index = 1, maxAmmo do
        local ammoEntry = {
            gameObject = nil,
            canvasGroup = nil,
            isTemplate = index == 1,
        }
        if index == 1 then
            ammoEntry.gameObject = self.bombImg.gameObject
            ammoEntry.canvasGroup = self.bombImg.canvasGroup
        else
            ---@type UnityEngine.GameObject
            local ammoGameObject = GameObject.Instantiate(self.bombImg.gameObject)
            local ammoTransform = ammoGameObject.transform
            ammoTransform:SetParent(self.bombNode.rectTransform, false)
            ammoEntry.gameObject = ammoGameObject
            ammoEntry.canvasGroup = ammoGameObject:GetComponent(TypeInfo.CanvasGroup)
        end
        ammoEntry.gameObject:SetActive(true)
        if not ammoEntry.canvasGroup then
            ammoEntry.canvasGroup = ammoEntry.gameObject:GetOrAddComponent(TypeInfo.CanvasGroup)
        end
        table.insert(self._ammoImages, ammoEntry)
    end
    self.bombNode.horizontalLayoutGroup.enabled = true
    self:DoAfter(0.1, function()
        self.bombNode.horizontalLayoutGroup.enabled = false
    end)
end

function BombGamePanel:_clearAmmoImages()
    if not self._ammoImages then
        self._ammoImages = {}
        return
    end
    for _, ammoItem in ipairs(self._ammoImages) do
        if ammoItem and ammoItem.gameObject then
            if ammoItem.isTemplate then
                ammoItem.gameObject:SetActive(false)
            else
                GameObject.Destroy(ammoItem.gameObject)
            end
        end
    end
    self._ammoImages = {}
end

function BombGamePanel:_updateBgScroll(dt)
    if not self._bgScrollItems then
        return
    end
    for _, item in ipairs(self._bgScrollItems) do
        if item.rectTransform then
            if item.isFishBg then
                item.speedTimer = item.speedTimer - dt
                if item.speedTimer <= 0 then
                    self:_randomizeBgScrollSpeed(item)
                end
            end
            item.x = item.x - item.speed * dt
            if item.x <= item.despawnX then
                item.x = item.respawnX + getRandomRange(item.respawnMinOffset, item.respawnMaxOffset)
                if item.isFishBg then
                    self:_randomizeBgScrollSpeed(item)
                end
            end
            item.rectTransform.anchoredPosition3D = Vector3.New(item.x, item.y, item.z)
        end
    end
end

function BombGamePanel:_getTopUi()
    if self._topUi then
        return self._topUi
    end
    if self.closeBtn and self.closeBtn.transform and self.closeBtn.transform.parent then
        self._topUi = self.closeBtn.transform.parent.gameObject
    end
    return self._topUi
end

---@param obj UnityEngine.GameObject|table|nil
---@param active boolean
function BombGamePanel:_setGoActive(obj, active)
    if not obj then
        return
    end
    local gameObject = obj.gameObject or obj
    if gameObject and gameObject.SetActive then
        gameObject:SetActive(active == true)
    end
end

---@param obj UnityEngine.GameObject|table|nil
---@return UnityEngine.CanvasGroup?
function BombGamePanel:_ensureCanvasGroup(obj)
    if not obj then
        return nil
    end
    local gameObject = obj.gameObject or obj
    if not gameObject or not gameObject.GetOrAddComponent then
        return nil
    end
    return gameObject:GetOrAddComponent(TypeInfo.CanvasGroup)
end

function BombGamePanel:_killFlowTweens()
    local targets = {
        self.stateRoot,
        self.startLayer,
        self.countdownLayer,
        self.settleLayer,
        self.readyImg,
        self.countImg1,
        self.countImg2,
        self.countImg3,
        self.goImg,
        self.logoImg,
        self.startBtn,
    }
    for _, target in ipairs(targets) do
        if target then
            local gameObject = target.gameObject or target
            if gameObject and gameObject.transform then
                gameObject.transform:DOKill(false)
            end
            if gameObject and gameObject.GetComponent then
                local canvasGroup = gameObject:GetComponent(TypeInfo.CanvasGroup)
                if canvasGroup then
                    canvasGroup:DOKill(false)
                end
            end
        end
    end
end

---@param obj UnityEngine.GameObject|table|nil
---@param show boolean
---@param instant boolean?
function BombGamePanel:_fadeLayer(obj, show, instant)
    if not obj then
        return
    end
    local gameObject = obj.gameObject or obj
    if not gameObject then
        return
    end
    local canvasGroup = self:_ensureCanvasGroup(obj)
    if show then
        gameObject:SetActive(true)
        if canvasGroup then
            canvasGroup:DOKill(false)
            if instant then
                canvasGroup.alpha = 1
            else
                canvasGroup.alpha = 0
                canvasGroup:DOFade(1, flowFadeDuration)
            end
        end
        return
    end

    if instant or not gameObject.activeSelf then
        if canvasGroup then
            canvasGroup:DOKill(false)
            canvasGroup.alpha = 1
        end
        gameObject:SetActive(false)
        return
    end

    if canvasGroup then
        canvasGroup:DOKill(false)
        canvasGroup:DOFade(0, flowFadeDuration):OnComplete(function()
            if gameObject then
                gameObject:SetActive(false)
            end
            if canvasGroup then
                canvasGroup.alpha = 1
            end
        end)
    else
        gameObject:SetActive(false)
    end
end

---@param phase "start"|"countdown"|"playing"|"settle"
---@param instant boolean?
function BombGamePanel:_applyFlowUi(phase, instant)
    self:_killFlowTweens()
    self:_setGoActive(self.stateRoot, true)

    local showStart = phase == "start"
    local showCountdown = phase == "countdown"
    local showSettle = phase == "settle"
    local showPlayingHud = phase == "playing"

    self:_fadeLayer(self.startLayer, showStart, instant)
    self:_fadeLayer(self.countdownLayer, showCountdown, instant)
    self:_fadeLayer(self.settleLayer, showSettle, instant)

    if not showCountdown then
        self:_hideCountdownWidgets()
    end

    -- topUI 始终保留，方便关闭；局内操作按钮仅 playing 显示
    self:_setGoActive(self:_getTopUi(), true)
    self:_setPlayingControlsVisible(showPlayingHud)
end

---@param visible boolean
function BombGamePanel:_setPlayingControlsVisible(visible)
    -- 左右移动改由摇杆控制，旧按钮保持关闭
    self:_setGoActive(self.leftBtn, false)
    self:_setGoActive(self.rightBtn, false)
    self:_setGoActive(self.touchArea, visible)
    self:_setGoActive(self.hitBtn, visible)
    if not visible then
        self:_resetJoystick()
        self:_setGoActive(self.useSuperBombBtn, false)
    else
        self:_refreshSuperBombBtn()
    end
end

function BombGamePanel:_hideCountdownWidgets()
    local widgets = {
        self.readyImg,
        self.countImg1,
        self.countImg2,
        self.countImg3,
        self.goImg,
    }
    for _, widget in ipairs(widgets) do
        if widget then
            local gameObject = widget.gameObject or widget
            if gameObject and gameObject.transform then
                gameObject.transform:DOKill(false)
                gameObject.transform.localScale = Vector3.New(1, 1, 1)
            end
            local canvasGroup = self:_ensureCanvasGroup(widget)
            if canvasGroup then
                canvasGroup:DOKill(false)
                canvasGroup.alpha = 1
            end
            self:_setGoActive(widget, false)
        end
    end
end

---@param obj UnityEngine.GameObject|table|nil
function BombGamePanel:_playCountdownPop(obj)
    if not obj then
        return
    end
    local gameObject = obj.gameObject or obj
    if not gameObject then
        return
    end
    gameObject:SetActive(true)
    local transform = gameObject.transform
    local canvasGroup = self:_ensureCanvasGroup(obj)
    if transform then
        transform:DOKill(false)
        transform.localScale = Vector3.New(1.4, 1.4, 1)
        transform:DOScale(Vector3.New(1, 1, 1), countdownPopDuration)
    end
    if canvasGroup then
        canvasGroup:DOKill(false)
        canvasGroup.alpha = 0
        canvasGroup:DOFade(1, 0.12)
    end
end

function BombGamePanel:_beginCountdownFlow()
    if self._state ~= "start" and self._state ~= "countdown" then
        return
    end
    self._state = "countdown"
    self._stateTimer = 0
    self._countdownStep = 0
    self._countdownStepLeft = 0
    if self.startBtn and self.startBtn.scaleButton then
        self.startBtn.scaleButton.interactable = false
    end
    self:_applyFlowUi("countdown")
    self:_advanceCountdownStep()
end

function BombGamePanel:_advanceCountdownStep()
    self:_hideCountdownWidgets()
    self._countdownStep = (self._countdownStep or 0) + 1
    local step = COUNTDOWN_STEPS[self._countdownStep]
    if not step then
        self:_enterPlaying()
        return
    end
    local widget = self[step.widget]
    local duration = self._cfg[step.durationKey] or 0.5
    self._countdownStepLeft = duration
    self:_playCountdownPop(widget)
end

function BombGamePanel:_enterPlaying()
    self._state = "playing"
    self._stateTimer = 0
    self._remainTime = self._cfg.duration
    self:_applyFlowUi("playing")
    if self._ship then
        self._ship:SetX(self._cfg.shipCenterX)
        self._ship:Stop()
    end
    self:_beginInitialSpawn()
    self:_refreshHud()
    self:_refreshSuperBombBtn()
end

function BombGamePanel:_updateCountdown(dt)
    if (self._countdownStepLeft or 0) <= 0 then
        return
    end
    self._countdownStepLeft = self._countdownStepLeft - dt
    if self._countdownStepLeft <= 0 then
        self:_advanceCountdownStep()
    end
end

function BombGamePanel:_updatePlaying(dt)
    if not self._ship then
        return
    end
    if GV.IsEditor and Input.GetKey(KeyCode.Space) then
        self:hitBtn_ScaleButton_onClick()
    end
    if self:_isShipStunned() then
        self._ship:SetDir(0)
    end
    self._remainTime = math.max(0, self._remainTime - dt)
    self._ship:UpdateMove(dt, self:_getShipSpeedMul(), self:_isShipStunned())
    self._bombCd = math.max(0, self._bombCd - dt)
    self._shipDamageCd = math.max(0, (self._shipDamageCd or 0) - dt)
    self:_recoverAmmo(dt)
    if self._remainTime <= 0 then
        self:_finishGame("time_up")
    end
end

function BombGamePanel:_initJoystick()
    if not self.touchArea or not self.circle or not self.handle then
        return
    end
    self._joystickRadius = self.circle.rectTransform.sizeDelta.x * 0.5
    self._keyboardJoystickActive = false
    self._touchId = nil
    self.mouseDownPosition = nil
    self._circleOriginalAnchoredPosition = self.circle.rectTransform.anchoredPosition

    self.circle:SetActive(false)
    self.handle.rectTransform.anchoredPosition = Vector2.zero
    self:_setGoActive(self.leftBtn, false)
    self:_setGoActive(self.rightBtn, false)

    self.touchArea.clickLongPressListener.onDown = function()
        if self._state ~= "playing" or self:_isShipStunned() then
            return
        end
        self._touchId = Input.touchCount > 0 and Input.GetTouch(0).fingerId or -1
        self.mouseDownPosition = Input.touchCount > 0 and Input.GetTouch(0).position
            or Vector2(Input.mousePosition.x, Input.mousePosition.y)
        local parentRect = self.circle.rectTransform.parent
        local localPos = UICommonUtils.ScreenToUILocalPos(parentRect, UIMgr.uiCamera, self.mouseDownPosition)
        self.circle.rectTransform.anchoredPosition = localPos
        self.handle.rectTransform.anchoredPosition = Vector2.zero
        self.circle:SetActive(true)
        self:_applyJoystickMoveDir(0)
    end

    self.touchArea.clickLongPressListener.onUp = function()
        self:_resetJoystick()
        self:_applyJoystickMoveDir(0)
    end
end

function BombGamePanel:_resetJoystick()
    self._touchId = nil
    self.mouseDownPosition = nil
    self._keyboardJoystickActive = false
    if self.handle and self.handle.rectTransform then
        self.handle.rectTransform.anchoredPosition = Vector2.zero
    end
    if self.circle and self.circle.rectTransform and self._circleOriginalAnchoredPosition then
        self.circle.rectTransform.anchoredPosition = self._circleOriginalAnchoredPosition
        self.circle:SetActive(false)
    end
end

---仅左右二方向：把摇杆偏移映射为 -1 / 0 / 1
---@param offsetX number
---@return integer
function BombGamePanel:_resolveHorizontalMoveDir(offsetX)
    local radius = self._joystickRadius or 1
    local deadZone = radius * joystickAxisDeadZone
    if offsetX <= -deadZone then
        return -1
    end
    if offsetX >= deadZone then
        return 1
    end
    return 0
end

---@param dir integer
function BombGamePanel:_applyJoystickMoveDir(dir)
    if not self._ship then
        return
    end
    if self._state ~= "playing" or self:_isShipStunned() then
        self._ship:SetDir(0)
        return
    end
    self._ship:SetDir(dir or 0)
end

---摇杆把手只在水平轴移动（二方向优化）
---@param offsetX number
function BombGamePanel:_applyHorizontalJoystickHandle(offsetX)
    local radius = self._joystickRadius or 1
    if offsetX > radius then
        offsetX = radius
    elseif offsetX < -radius then
        offsetX = -radius
    end
    self.handle.rectTransform.anchoredPosition = Vector2(offsetX, 0)
end

function BombGamePanel:_getKeyboardJoystickDirX()
    local x = 0
    if Input.GetKey(KeyCode.A) then
        x = x - 1
    end
    if Input.GetKey(KeyCode.D) then
        x = x + 1
    end
    if x == 0 then
        return nil
    end
    return x
end

function BombGamePanel:_updateJoystickDrag()
    if self._state ~= "playing" then
        if self.mouseDownPosition or self._keyboardJoystickActive then
            self:_resetJoystick()
            self:_applyJoystickMoveDir(0)
        end
        return
    end
    if not self.touchArea or not self.circle or not self.handle then
        return
    end

    local radius = self._joystickRadius or 1

    -- 编辑器：AD 模拟左右摇杆
    if GV.IsEditor then
        local dirX = self:_getKeyboardJoystickDirX()
        if dirX then
            if not self._keyboardJoystickActive then
                self._keyboardJoystickActive = true
                self.circle.rectTransform.anchoredPosition = self._circleOriginalAnchoredPosition
                self.circle:SetActive(true)
            end
            self:_applyHorizontalJoystickHandle(dirX * radius)
            self:_applyJoystickMoveDir(dirX)
            return
        elseif self._keyboardJoystickActive then
            self:_resetJoystick()
            self:_applyJoystickMoveDir(0)
            return
        end
    end

    if not (Input.GetMouseButton(0) and self.mouseDownPosition) then
        return
    end

    local currentMousePosition = nil
    if GV.IsEditor then
        currentMousePosition = Vector2(Input.mousePosition.x, Input.mousePosition.y)
    else
        if Input.touchCount > 0 and self._touchId then
            for i = 0, Input.touchCount - 1 do
                local touch = Input.GetTouch(i)
                if touch.fingerId == self._touchId then
                    currentMousePosition = touch.position
                    break
                end
            end
        end
    end
    if not currentMousePosition then
        return
    end

    local localPos = UICommonUtils.ScreenToUILocalPos(self.circle.rectTransform, UIMgr.uiCamera, currentMousePosition)
    -- 仅取水平分量，锁定为左右二方向
    local offsetX = localPos.x
    self:_applyHorizontalJoystickHandle(offsetX)
    self:_applyJoystickMoveDir(self:_resolveHorizontalMoveDir(offsetX))
end

function BombGamePanel:_updateSettling(dt)
    self._stateTimer = self._stateTimer + dt
    if not self._rewardSent then
        self._rewardSent = true
        self:_settleRewards()
    end
    if not self._settleCloseReady and self._stateTimer >= settleCloseDelay then
        self._settleCloseReady = true
        self:_setSettleCloseInteractable(true)
    end
end

function BombGamePanel:_updateBombs(dt)
    for index = #self._bombs, 1, -1 do
        local bomb = self._bombs[index]
        if bomb.alive then
            bomb:Update(dt)
            local hitFish = self:_findFirstCollidingFish(bomb)
            if hitFish then
                self:_explodeBomb(bomb, hitFish)
            end
            if bomb.y <= self._cfg.waterBottomY then
                bomb:Kill()
            end
        end
        if not bomb.alive then
            releaseViewEntry(bomb:GetViewEntry())
            table.remove(self._bombs, index)
        end
    end
end

function BombGamePanel:_updatePendingBombs(dt)
    for index = #self._pendingBombs, 1, -1 do
        local pendingBomb = self._pendingBombs[index]
        pendingBomb.left = pendingBomb.left - dt
        if pendingBomb.left <= 0 then
            self:_spawnBomb(pendingBomb.x)
            table.remove(self._pendingBombs, index)
        end
    end
end

function BombGamePanel:_updateFishes(dt)
    for index = #self._fishes, 1, -1 do
        local fish = self._fishes[index]
        if fish.moveMode == "rise_diagonal" and self._ship then
            fish.moveTargetX = self._ship:GetX()
        elseif fish.moveMode == "rush_track_burst" and self._ship then
            fish.moveTargetX = self._ship:GetX()
        end
        fish:Update(dt)
        self:_tryFishAttack(fish, dt)
        self:_tryFishTouchShip(fish)
        if fish:IsRemoved() then
            releaseViewEntry(fish:GetViewEntry())
            table.remove(self._fishes, index)
        end
    end
end

function BombGamePanel:_updateEnemyProjectiles(dt)
    if self._state ~= "playing" then
        for _, projectile in ipairs(self._enemyProjectiles) do
            self:_releaseEnemyProjectileView(projectile)
        end
        self._enemyProjectiles = {}
        return
    end
    for index = #self._enemyProjectiles, 1, -1 do
        local projectile = self._enemyProjectiles[index]
        if projectile.state == "ending" then
            projectile.left = projectile.left - dt
            if projectile.left <= 0 then
                self:_releaseEnemyProjectileView(projectile)
                table.remove(self._enemyProjectiles, index)
            end
        else
            self:_updateEnemyProjectile(projectile, dt)
            if self:_isEnemyProjectileHitShip(projectile) then
                self:_onShipHitByEnemyProjectile(projectile)
                self:_beginEnemyProjectileEnd(projectile, "hit")
            else
                local endReason = self:_getEnemyProjectileEndReason(projectile)
                if endReason then
                    self:_beginEnemyProjectileEnd(projectile, endReason)
                end
            end
        end
    end
end

function BombGamePanel:_getWaterSurfaceY()
    return self._cfg.waterSurfaceY or -255
end

---@param x number
---@return boolean
function BombGamePanel:_isNearScreenEdgeForMissile(x)
    if not x then
        return true
    end
    local margin = self._cfg.enemyMissileScreenEdgeMargin or 30
    local minX = self._cfg.shipMinX or -960
    local maxX = self._cfg.shipMaxX or 960
    return x <= minX + margin or x >= maxX - margin
end

---@param projectile enemyProjectileData
---@return string?
function BombGamePanel:_getEnemyProjectileEndReason(projectile)
    if not projectile or projectile.state ~= "flying" then
        return nil
    end
    local surfaceY = self:_getWaterSurfaceY()
    if projectile.projectileType == ENEMY_PROJECTILE_TYPE.DAO_DAN then
        if projectile.y >= self:_getEnemyProjectileDespawnY() then
            return "despawn"
        end
        return nil
    end
    if projectile.projectileType == ENEMY_PROJECTILE_TYPE.SHUI_LEI
        or projectile.projectileType == ENEMY_PROJECTILE_TYPE.YU_LEI then
        local overshoot = self._cfg.enemyProjectileSurfaceOvershoot or 5
        local halfHeight = projectile.halfHeight or 0
        -- 碰撞盒顶部超出水面 overshoot 后消失，避免表现冒出水面
        if projectile.y + halfHeight >= surfaceY + overshoot then
            return "surface"
        end
    end
    return nil
end

function BombGamePanel:_getEnemyProjectileDespawnY()
    local offsetY = self._cfg.enemyProjectileDespawnOffsetY or 0
    if self.gameArea and self.gameArea.rectTransform then
        return self.gameArea.rectTransform.rect.height * 0.5 + offsetY
    end
    return self._cfg.waterSurfaceY + offsetY
end

function BombGamePanel:_updateDrops(dt)
    -- 道具掉落暂时屏蔽
    return
end

function BombGamePanel:_updateBombEffects(dt)
    for index = #self._bombEffects, 1, -1 do
        local effect = self._bombEffects[index]
        effect.left = effect.left - dt
        if effect.left <= 0 then
            releaseViewEntry(effect.viewEntry)
            table.remove(self._bombEffects, index)
        end
    end
end

function BombGamePanel:_updateFloatingTexts(dt)
    for index = #self._floatingTexts, 1, -1 do
        local item = self._floatingTexts[index]
        item.left = item.left - dt
        if item.rectTransform then
            item.rectTransform.anchoredPosition3D = item.rectTransform.anchoredPosition3D + Vector3.New(0, item.riseSpeed * dt, 0)
        end
        if item.canvasGroup then
            item.canvasGroup.alpha = clamp(item.left / math.max(item.duration, 0.01), 0, 1)
        end
        if item.left <= 0 then
            if item.viewEntry then
                releaseViewEntry(item.viewEntry)
            elseif item.gameObject then
                GameObject.Destroy(item.gameObject)
            end
            table.remove(self._floatingTexts, index)
        end
    end
end

function BombGamePanel:_recoverAmmo(dt)
    local maxAmmo = self:_getMaxAmmo()
    if self._ammo >= maxAmmo then
        self._ammo = maxAmmo
        self._ammoRecoverCd = self._cfg.ammoRecoverCd
        return
    end

    self._ammoRecoverCd = self._ammoRecoverCd - dt
    local ammoRecoverInterval = self._cfg.ammoRecoverCd or 0
    while self._ammo < maxAmmo and self._ammoRecoverCd <= 0 and ammoRecoverInterval > 0 do
        self._ammo = self._ammo + 1
        self._ammoRecoverCd = self._ammoRecoverCd + ammoRecoverInterval
    end
end

function BombGamePanel:_updateEffects(dt)
    for index = #self._effects, 1, -1 do
        local effect = self._effects[index]
        effect.left = effect.left - dt
        if effect.left <= 0 then
            table.remove(self._effects, index)
        end
    end
end

function BombGamePanel:_updateRespawnQueue(dt)
    for index = #self._respawnQueue, 1, -1 do
        local item = self._respawnQueue[index]
        item.left = item.left - dt
        if item.left <= 0 then
            self:_spawnFishAtEdge(item.layerIndex)
            table.remove(self._respawnQueue, index)
        end
    end
end

---@param layerIndex integer
---@return boolean
function BombGamePanel:_hasAliveFishInLayer(layerIndex)
    for _, fish in ipairs(self._fishes) do
        if fish:IsAlive() and fish.layerIndex == layerIndex then
            return true
        end
    end
    return false
end

---@param layerIndex integer
---@return boolean
function BombGamePanel:_hasPendingRespawnForLayer(layerIndex)
    for _, item in ipairs(self._respawnQueue) do
        if item.layerIndex == layerIndex then
            return true
        end
    end
    return false
end

---@param layerIndex integer
function BombGamePanel:_queueLayerRespawn(layerIndex)
    if self._state ~= "playing" then
        return
    end
    if self:_hasAliveFishInLayer(layerIndex) or self:_hasPendingRespawnForLayer(layerIndex) then
        return
    end
    table.insert(self._respawnQueue, {
        layerIndex = layerIndex,
        left = self._cfg.layerRespawnDelay,
    })
end

function BombGamePanel:_beginInitialSpawn()
    if self._state ~= "playing" then
        return
    end
    local initialCount = math.floor(self._cfg.targetFishCount * self._cfg.initialFishRatio + 0.5)
    initialCount = clamp(initialCount, 0, self._cfg.targetFishCount)
    for i = 1, initialCount do
        local layerIndex = ((i - 1) % #self._cfg.layerCenters) + 1
        local spawnX = getDistributedSpawnX(i, initialCount, self._cfg.fishMinX + 40, self._cfg.fishMaxX - 40, self._cfg.initialSpawnJitter)
        self:_spawnFish(layerIndex, true, spawnX)
    end

    local remain = self._cfg.targetFishCount - initialCount
    if remain > 0 then
        self._fillState = {
            mode = "initial",
            left = remain,
            interval = self._cfg.initialFillDuration / remain,
            timer = 0,
            nextLayer = 1,
        }
    end
end

function BombGamePanel:_updateFillState(dt)
    if self._state ~= "playing" then
        return
    end
    local fillState = self._fillState
    if not fillState or fillState.left <= 0 then
        self._fillState = nil
        return
    end

    fillState.timer = fillState.timer + dt
    local fillInterval = fillState.interval or 0
    while fillState.left > 0 and fillInterval > 0 and fillState.timer >= fillInterval do
        fillState.timer = fillState.timer - fillInterval
        self:_spawnFishAtEdge(fillState.nextLayer)
        fillState.left = fillState.left - 1
        fillState.nextLayer = fillState.nextLayer + 1
        if fillState.nextLayer > #self._cfg.layerCenters then
            fillState.nextLayer = 1
        end
    end

    if fillState.left <= 0 then
        self._fillState = nil
    end
end

function BombGamePanel:_checkForRefillNeed()
    if self._fillState ~= nil then
        return
    end
    if self:_getAliveFishCount() > 0 then
        return
    end
    if #self._respawnQueue > 0 then
        return
    end
    if self._state ~= "playing" then
        return
    end

    self:_beginFullRefill()
end

---@return integer
function BombGamePanel:_getAliveFishCount()
    local count = 0
    if not self._fishes then
        return 0
    end
    for _, fish in ipairs(self._fishes) do
        if fish and fish:IsAlive() then
            count = count + 1
        end
    end
    return count
end

function BombGamePanel:_beginFullRefill()
    ---@class fillStateData
    ---@field mode string
    ---@field left integer
    ---@field interval number
    ---@field timer number
    ---@field nextLayer integer
    local targetCount = math.max(1, self._cfg.targetFishCount or 1)
    self._fillState = {
        mode = "refill",
        left = targetCount,
        interval = (self._cfg.refillDuration or 1) / targetCount,
        timer = 0,
        nextLayer = 1,
    }
end

function BombGamePanel:_spawnFishAtEdge(layerIndex)
    self:_spawnFish(layerIndex, false)
end

---生成一条鱼
function BombGamePanel:_spawnFish(layerIndex, randomX, overrideSpawnX)
    ---@type fishData
    local fishType = self:_pickFishType(layerIndex)
    local spawnX
    local spawnY = self._cfg.layerCenters[layerIndex] or 0
    local dir
    if fishType.moveMode == "rise_diagonal" then
        -- suicide：在水底随机水平位置生成，不从屏幕两侧入场
        spawnX = math.random(self._cfg.fishMinX + 5, self._cfg.fishMaxX - 5)
        spawnY = self._cfg.waterBottomY
        dir = math.random(0, 1) == 0 and -1 or 1
    elseif overrideSpawnX ~= nil then
        spawnX = clamp(overrideSpawnX, self._cfg.fishMinX, self._cfg.fishMaxX)
        dir = math.random(0, 1) == 0 and -1 or 1
    elseif randomX then
        spawnX = math.random(self._cfg.fishMinX + 5, self._cfg.fishMaxX - 5)
        dir = math.random(0, 1) == 0 and -1 or 1
    else
        local fromLeft = math.random(0, 1) == 0
        local baseOffset = math.max(self._cfg.edgeSpawnXOffset or 0, 0)
        local layerOffset = math.floor(math.max((self._cfg.edgeSpawnLayerOffset or 0) * (layerIndex - 1), 0))
        local xOffset = baseOffset + layerOffset
        spawnX = fromLeft and (self._cfg.fishMinX - xOffset) or (self._cfg.fishMaxX + xOffset)
        dir = fromLeft and 1 or -1
        local yOffsetRange = math.max(self._cfg.edgeSpawnYOffset or 0, 0)
        if yOffsetRange > 0 then
            spawnY = spawnY + math.random(-yOffsetRange, yOffsetRange)
        end
    end

    local sprint = nil
    if fishType.sprint then
        sprint = copyTable(fishType.sprint)
        sprint.left = sprint.cooldown
        sprint.activeLeft = 0
    end

    local attack = nil
    if fishType.attack then
        attack = copyTable(fishType.attack)
        attack.left = getRandomRange(0, attack.randomStart or 0)
    end

    local moveDirX = dir
    if fishType.moveMode == "rise_diagonal" then
        local shipX = self._ship and self._ship:GetX() or 0
        moveDirX = shipX >= spawnX and 1 or -1
        dir = moveDirX
    end

    
    ---@type BombGameFish
    local fish = BombGameFish:new(nil, {
        id = fishType.id,
        x = spawnX,
        y = spawnY,
        layerIndex = layerIndex,
        dir = dir,
        hp = fishType.hp,
        maxHp = fishType.hp,
        speed = fishType.speed,
        radius = fishType.radius,
        score = fishType.score,
        dropChance = fishType.dropChance,
        fishIconId = fishType.fishIconId,
        respawnDelay = fishType.respawnDelay,
        state = "alive",
        sprint = sprint,
        attack = attack,
        moveMode = fishType.moveMode,
        moveTargetY = self._cfg.waterSurfaceY,
        moveDirX = moveDirX,
        explodeOnDeath = fishType.explodeOnDeath,
        explodeRadius = fishType.explodeRadius,
        fishScale = fishType.fishScale,
    }, self._cfg, self:_acquireFishViewEntry())
    local iconName = string.format(enemyImgName, fishType.fishIconId)
    local path = string.format(Config.SpritePath.BombGameImgPath, iconName)
    self._instanceId = self._instanceId + 1
    local gameObject = fish:GetViewEntry().transform.gameObject
    local fishName = tostring(self._instanceId)
    gameObject.name = fishName
    self:LoadSpriteAsync(path, function(sprite)
        if sprite then
            fish:SetImageSprite(sprite)
        end
        table.insert(self._fishes, fish)
    end)
end

---@return fishData
function BombGamePanel:_pickFishType(layerIndex)
    local weighted = {}
    for _, fishType in ipairs(self._cfg.fishTypes) do
        table.insert(weighted, {
            ref = fishType,
            weight = fishType.layerWeights[layerIndex] or 0,
        })
    end
    local pick = getWeightedPick(weighted, "weight")
    return pick.ref
end

---@param fish BombGameFish
---@return number?, number?, number?, number?, number?, number?
function BombGamePanel:_getFishBox(fish)
    if not fish or not fish:IsAlive() then
        return nil
    end
    return fish:GetCollisionBox()
end

---@param bomb BombGameBomb
---@return number?, number?, number?, number?, number?, number?
function BombGamePanel:_getBombBox(bomb)
    if not bomb or not bomb.alive then
        return nil
    end
    return bomb:GetCollisionBox()
end

---@param bomb BombGameBomb
---@return BombGameFish?
function BombGamePanel:_findFirstCollidingFish(bomb)
    local bombMinX, bombMaxX, bombMinY, bombMaxY = self:_getBombBox(bomb)
    if not bombMinX then
        return nil
    end

    for _, fish in ipairs(self._fishes) do
        local fishMinX, fishMaxX, fishMinY, fishMaxY = self:_getFishBox(fish)
        if fishMinX and fishMaxX and fishMinY and fishMaxY
            and bombMaxX and bombMinY and bombMaxY
            and isBoxIntersect(bombMinX, bombMaxX, bombMinY, bombMaxY, fishMinX, fishMaxX, fishMinY, fishMaxY) then
            return fish
        end
    end
    return nil
end

---@param hitFish BombGameFish
---@param radius number
---@return BombGameFish[]
function BombGamePanel:_findFishesInExplosionRadius(hitFish, radius)
    local _, _, _, _, centerX, centerY = self:_getFishBox(hitFish)
    if not centerX then
        return {}
    end

    local fishes = {}
    for _, fish in ipairs(self._fishes) do
        local fishMinX, fishMaxX, fishMinY, fishMaxY = self:_getFishBox(fish)
        if fishMinX and fishMaxX and fishMinY and fishMaxY and centerY
            and isCircleIntersectBox(fishMinX, fishMaxX, fishMinY, fishMaxY, centerX, centerY, radius) then
            table.insert(fishes, fish)
        end
    end
    return fishes
end

---@param bomb BombGameBomb
---@param hitFish BombGameFish
function BombGamePanel:_explodeBomb(bomb, hitFish)
    if not bomb.alive or not hitFish or not hitFish:IsAlive() then
        return
    end
    bomb:Kill()
    local shootSoundPath = string.format(Config.AudioPath.SE, "fight_shoot_large")
    self:play2DSound(shootSoundPath)
    local centerX = hitFish.x
    local centerY = hitFish.y
    local radius = self:_getBombBlastRadius()
    local damage = self:_getBombDamage()
    local falloff = clamp(self._cfg.bombDamageFalloff, 0, 1)
    local hitFishes = self:_findFishesInExplosionRadius(hitFish, radius)
    local orderedFishes = {hitFish}
    for _, fish in ipairs(hitFishes) do
        if fish ~= hitFish then
            table.insert(orderedFishes, fish)
        end
    end
    local killComboMul = 1
    for _, fish in ipairs(orderedFishes) do
        local disSq = distanceSq(centerX, centerY, fish.x, fish.y)
        local dis = math.sqrt(disSq)
        local ratio = 1 - clamp(dis / math.max(radius, 0.01), 0, 1) * falloff
        local realDamage = math.max(1, math.floor(damage * ratio + 0.5))
        killComboMul = self:_damageFish(fish, realDamage, killComboMul)
    end
end

---@param x number
---@param y number
function BombGamePanel:_playExplodeEffect(x, y)
    local viewEntry = self:_acquireBombEffectViewEntry()
    if not viewEntry or not viewEntry.transform then
        return
    end
    ---@type any
    local transform = viewEntry.transform:GetComponent(TypeInfo.RectTransform)
    transform.anchoredPosition3D = Vector3.New(x, y, 0)
    local gameObject = transform.gameObject
    if gameObject then
        gameObject:SetActive(false)
        gameObject:SetActive(true)
    end
    table.insert(self._bombEffects, {
        viewEntry = viewEntry,
        left = self._cfg.bombEffectDuration,
    })
end

---@param fish BombGameFish
---@param damage number
---@param killComboMul integer
---@return integer
function BombGamePanel:_damageFish(fish, damage, killComboMul)
    if not fish:IsAlive() then
        return killComboMul or 1
    end
    if not fish:TakeDamage(damage) then
        return killComboMul or 1
    end
    return self:_killFish(fish, killComboMul)
end

---@param fish BombGameFish
---@param killComboMul integer
---@param skipRespawn boolean?
---@return integer
function BombGamePanel:_killFish(fish, killComboMul, skipRespawn)
    if not fish:IsAlive() then
        return killComboMul or 1
    end
    local layerIndex = fish.layerIndex

    if fish.explodeOnDeath then
        self:_tryFishDeathExplosionDamage(fish)
    end

    local dieSoundPath = string.format(Config.AudioPath.SE, "fight_die")
    self:play2DSound(dieSoundPath)

    self:_playExplodeEffect(fish.x, fish.y)
    fish:SetDying(0.45)

    local scoreMul = self:_getScoreMul()
    local comboMul = killComboMul or 1
    local addScore = math.floor(fish.score * scoreMul * comboMul + 0.5)
    self._score = self._score + addScore
    self.scoreText.text.text = tostring(self._score)
    self:_showKillScorePrompt(fish.x, fish.y, fish.score, comboMul)

    if fish.id == "bossling" and math.random() <= fish.dropChance then
        -- 道具掉落暂时屏蔽
        -- self:_spawnDrop(fish.x, fish.y)
    end

    if self._state == "playing" and skipRespawn ~= true then
        self:_spawnFishAtEdge(layerIndex)
    end

    return comboMul + 1
end

function BombGamePanel:_spawnDrop(x, y)
    -- 道具掉落暂时屏蔽
    return
end

function BombGamePanel:_tryAutoPickupDrops()
    -- 道具掉落暂时屏蔽
    return
end

---@param drop BombGameEffect
function BombGamePanel:_applyDrop(drop)
    -- 道具掉落暂时屏蔽
    return
end

function BombGamePanel:_useSuperBomb()
    if self._state ~= "playing" or self._superBombBusy then
        return false
    end
    if (self._superBombCount or 0) <= 0 then
        return false
    end

    self._superBombBusy = true
    self._superBombCount = self._superBombCount - 1
    self:_refreshSuperBombBtn(true)

    local killComboMul = 1
    local fishesToKill = {}
    for _, fish in ipairs(self._fishes) do
        if fish and fish:IsAlive() then
            table.insert(fishesToKill, fish)
        end
    end
    for _, fish in ipairs(fishesToKill) do
        killComboMul = self:_killFish(fish, killComboMul, true)
    end

    for _, projectile in ipairs(self._enemyProjectiles) do
        self:_releaseEnemyProjectileView(projectile)
    end
    self._enemyProjectiles = {}
    -- 清空进行中的补鱼进度，按最大数量重新补满
    self._respawnQueue = {}
    self:_beginFullRefill()
    self._superBombBusy = false
    return true
end

function BombGamePanel:_getEffectCount(effectId)
    local count = 0
    for _, effect in ipairs(self._effects) do
        if effect.id == effectId then
            count = count + 1
        end
    end
    return count
end

function BombGamePanel:_isShipStunned()
    return self:_getEffectCount("stun") > 0
end

function BombGamePanel:_getShipSpeedMul()
    local speedMul = 1 + self:_getEffectCount("speed_up") * 0.35
    speedMul = speedMul - self:_getEffectCount("slow") * 0.3
    return math.max(0.2, speedMul)
end

function BombGamePanel:_getBombDamage()
    return self._cfg.bombDamage * (1 + self:_getEffectCount("bomb_up") * 0.4)
end

function BombGamePanel:_getBombBlastRadius()
    return self._cfg.bombBlastRadius * (1 + self:_getEffectCount("range_up") * 0.25)
end

function BombGamePanel:_getMaxAmmo()
    return math.max(0, self._cfg.maxAmmo or 0)
end

function BombGamePanel:_getScoreMul()
    return 1 + self:_getEffectCount("score_up")
end

---@param fish BombGameFish
function BombGamePanel:_tryFishAttack(fish, dt)
    if self._state ~= "playing" or not fish or not fish:IsAlive() or not fish.attack then
        return
    end

    if fish.attack.mode == "track_burst" then
        if fish.pendingAttackBurst and fish.pendingAttackBurst > 0 then
            local burstInterval = fish.attack.burstInterval or self._cfg.rushBurstInterval or 0.16
            fish.attack.burstLeft = (fish.attack.burstLeft or 0) - dt
            if fish.attack.burstLeft <= 0 then
                self:_spawnEnemyProjectile(fish, {
                    speedMul = fish.attack.speedMul,
                    trackSpeedMul = fish.attack.trackSpeedMul,
                })
                fish.pendingAttackBurst = fish.pendingAttackBurst - 1
                fish.attack.burstLeft = burstInterval
            end
        else
            fish.attack.burstLeft = 0
        end
        return
    end

    fish.attack.left = (fish.attack.left or fish.attack.cooldown or 0) - dt
    if fish.attack.left > 0 then
        return
    end
    fish.attack.left = fish.attack.cooldown or 0
    self:_spawnEnemyProjectile(fish)
end

---@param fish BombGameFish
---@param override table?
function BombGamePanel:_spawnEnemyProjectile(fish, override)
    if not self._ship then
        return
    end
    local attack = fish.attack or {}
    local speedMul = override and override.speedMul or 1
    local trackSpeedMul = override and override.trackSpeedMul or 1
    local projectileType = resolveEnemyProjectileType(attack)
    -- 靠近屏幕边缘时不发射导弹，避免屏幕外攻击
    if projectileType == ENEMY_PROJECTILE_TYPE.DAO_DAN and self:_isNearScreenEdgeForMissile(fish.x) then
        return
    end
    local spawnX = fish.x
    local spawnY = fish.y + (self._cfg.enemyProjectileSpawnOffsetY or 0)
    local speedY = (self._cfg.enemyProjectileSpeed or 0) * speedMul
    local halfWidth, halfHeight = getEnemyProjectileHitBox(projectileType, self._cfg)

    if projectileType == ENEMY_PROJECTILE_TYPE.DAO_DAN then
        speedY = speedY * (self._cfg.daoDanSpeedMul or 1.25)
    end

    ---@class enemyProjectileData
    ---@field x number
    ---@field y number
    ---@field speedY number
    ---@field halfWidth number
    ---@field halfHeight number
    ---@field projectileType BombGameEnemyProjectileType
    ---@field trackLeft number
    ---@field trackTargetX number?
    ---@field trackSpeed number?
    ---@field state string
    ---@field left number
    ---@field endStyle string?
    ---@field tiltZ number?
    local projectile = {
        x = spawnX,
        y = spawnY,
        speedY = speedY,
        halfWidth = halfWidth,
        halfHeight = halfHeight,
        projectileType = projectileType,
        trackLeft = 0.0,
        trackTargetX = nil,
        trackSpeed = nil,
        state = "flying",
        left = 0,
        endStyle = nil,
        tiltZ = 0,
        viewEntry = self:_acquireEnemyProjectileViewEntry(projectileType),
    }
    if not projectile.viewEntry then
        return
    end

    self:_resetEnemyProjectileView(projectile)
    if projectileType == ENEMY_PROJECTILE_TYPE.DAO_DAN or projectileType == ENEMY_PROJECTILE_TYPE.YU_LEI then
        projectile.trackLeft = self._cfg.enemyProjectileTrackDuration or 0
        projectile.trackTargetX = self._ship:GetX()
        projectile.trackSpeed = (self._cfg.enemyProjectileTrackSpeed or 0) * trackSpeedMul
    end
    table.insert(self._enemyProjectiles, projectile)
end

---@param projectile enemyProjectileData
function BombGamePanel:_applyEnemyProjectileTracking(projectile, dt)
    if not projectile.trackSpeed then
        return
    end
    local prevX = projectile.x
    local surfaceY = self:_getWaterSurfaceY()
    if projectile.projectileType == ENEMY_PROJECTILE_TYPE.YU_LEI then
        local overshoot = self._cfg.enemyProjectileSurfaceOvershoot or 5
        local halfHeight = projectile.halfHeight or 0
        if projectile.y + halfHeight >= surfaceY + overshoot then
            projectile.tiltZ = 0
            return
        end
    end
    if isTrackingEnemyProjectile(projectile.projectileType) then
        if not projectile.trackLeft or projectile.trackLeft <= 0 then
            projectile.tiltZ = 0
            return
        end
        projectile.trackLeft = projectile.trackLeft - dt
    else
        return
    end

    local trackTargetX = self._ship and self._ship:GetX() or projectile.trackTargetX or projectile.x
    projectile.trackTargetX = trackTargetX
    local deltaX = trackTargetX - projectile.x
    local stopDistance = self._cfg.enemyProjectileTrackStopDistance or 5
    if math.abs(deltaX) <= stopDistance then
        projectile.trackLeft = 0
        deltaX = 0
    end
    local maxStep = projectile.trackSpeed * dt
    if deltaX == 0 then
        projectile.tiltZ = 0
        return
    end
    if math.abs(deltaX) <= maxStep then
        projectile.x = trackTargetX
    elseif deltaX > 0 then
        projectile.x = projectile.x + maxStep
    else
        projectile.x = projectile.x - maxStep
    end

    local moveDeltaX = projectile.x - prevX
    if moveDeltaX > 0.001 then
        projectile.tiltZ = self._cfg.enemyProjectileTrackTiltRight or -45
    elseif moveDeltaX < -0.001 then
        projectile.tiltZ = self._cfg.enemyProjectileTrackTiltLeft or 45
    else
        projectile.tiltZ = 0
    end
end

---@param projectile enemyProjectileData
function BombGamePanel:_syncEnemyProjectileView(projectile)
    if not projectile or not projectile.viewEntry or not projectile.viewEntry.transform then
        return
    end
    ---@type any
    local projectileRectTransform = projectile.viewEntry.transform:GetComponent(TypeInfo.RectTransform)
    if not projectileRectTransform then
        return
    end
    projectileRectTransform.anchoredPosition3D = Vector3.New(projectile.x, projectile.y, 0)
    if isTrackingEnemyProjectile(projectile.projectileType) then
        projectileRectTransform.localEulerAngles = Vector3.New(0, 0, projectile.tiltZ or 0)
    else
        projectileRectTransform.localEulerAngles = Vector3.New(0, 0, 0)
    end
end

---@param projectile enemyProjectileData
function BombGamePanel:_updateEnemyProjectile(projectile, dt)
    self:_applyEnemyProjectileTracking(projectile, dt)
    projectile.y = projectile.y + projectile.speedY * dt
    if projectile.projectileType == ENEMY_PROJECTILE_TYPE.SHUI_LEI
        or projectile.projectileType == ENEMY_PROJECTILE_TYPE.YU_LEI then
        local surfaceY = self:_getWaterSurfaceY()
        local overshoot = self._cfg.enemyProjectileSurfaceOvershoot or 5
        local halfHeight = projectile.halfHeight or 0
        local maxY = surfaceY + overshoot - halfHeight
        if projectile.y > maxY then
            projectile.y = maxY
        end
    end
    self:_syncEnemyProjectileView(projectile)
end

---@param projectile enemyProjectileData
function BombGamePanel:_resetEnemyProjectileView(projectile)
    if not projectile or not projectile.viewEntry or not projectile.viewEntry.transform then
        return
    end
    local projectileObject = projectile.viewEntry.transform.gameObject
    if not projectileObject then
        return
    end
    ---@type UnityEngine.RectTransform
    local projectileRectTransform = projectile.viewEntry.transform:GetComponent(TypeInfo.RectTransform)
    ---@type UnityEngine.CanvasGroup
    local canvasGroup = projectileObject:GetOrAddComponent(TypeInfo.CanvasGroup)
    if projectileRectTransform then
        projectileRectTransform:DOKill(false)
        projectileRectTransform.localScale = Vector3.one
        projectileRectTransform.localEulerAngles = Vector3.New(0, 0, 0)
    end
    if canvasGroup then
        canvasGroup:DOKill(false)
        canvasGroup.alpha = 1
    end
    self:_syncEnemyProjectileView(projectile)
end

---@param projectile enemyProjectileData
---@param reason string
function BombGamePanel:_beginEnemyProjectileEnd(projectile, reason)
    if not projectile or projectile.state == "ending" then
        return
    end
    projectile.state = "ending"
    reason = reason or "despawn"

    if not projectile.viewEntry or not projectile.viewEntry.transform then
        projectile.left = 0
        return
    end

    local projectileObject = projectile.viewEntry.transform.gameObject
    local projectileRectTransform = projectile.viewEntry.transform:GetComponent(TypeInfo.RectTransform)
    local canvasGroup = projectileObject and projectileObject:GetOrAddComponent(TypeInfo.CanvasGroup) or nil
    if projectileRectTransform then
        projectileRectTransform:DOKill(false)
    end
    if canvasGroup then
        canvasGroup:DOKill(false)
    end

    if projectile.projectileType == ENEMY_PROJECTILE_TYPE.SHUI_LEI and reason == "surface" then
        self:_playExplodeEffect(projectile.x, projectile.y)
        projectile.endStyle = "flash"
        projectile.left = self._cfg.shuiLeiFlashDuration or 0.56
        if canvasGroup then
            canvasGroup.alpha = 1
            ---@type any
            local flashTween = canvasGroup:DOFade(self._cfg.shuiLeiFlashAlpha or 0.25, self._cfg.shuiLeiFlashStepDuration or 0.08)
            flashTween:SetEase(DG.Tweening.Ease.InOutSine)
            flashTween:SetLoops(6, DG.Tweening.LoopType.Yoyo)
        end
        return
    end

    if projectile.projectileType == ENEMY_PROJECTILE_TYPE.YU_LEI and reason == "surface" then
        self:_playExplodeEffect(projectile.x, projectile.y)
        projectile.endStyle = "fade"
        projectile.left = self._cfg.yuLeiEndDuration or 0.12
        if canvasGroup then
            canvasGroup.alpha = 1
            canvasGroup:DOFade(0, projectile.left)
        end
        return
    end

    projectile.endStyle = "hit"
    projectile.left = enemyProjectileEndDuration
    if projectileRectTransform then
        projectileRectTransform:DOScale(Vector3.New(0.35, 0.35, 1), enemyProjectileEndDuration)
    end
    if canvasGroup then
        canvasGroup.alpha = 1
        canvasGroup:DOFade(0, enemyProjectileEndDuration)
    end
end

---@param projectile enemyProjectileData
function BombGamePanel:_releaseEnemyProjectileView(projectile)
    if not projectile or not projectile.viewEntry then
        return
    end
    local viewEntry = projectile.viewEntry
    local projectileObject = viewEntry.transform and viewEntry.transform.gameObject or nil
    local canvasGroup = projectileObject and projectileObject:GetComponent(TypeInfo.CanvasGroup) or nil
    local projectileRectTransform = viewEntry.transform and viewEntry.transform:GetComponent(TypeInfo.RectTransform) or nil
    if projectileRectTransform then
        projectileRectTransform:DOKill(false)
        projectileRectTransform.localScale = Vector3.one
        projectileRectTransform.localEulerAngles = Vector3.New(0, 0, 0)
    end
    if canvasGroup then
        canvasGroup:DOKill(false)
        canvasGroup.alpha = 1
    end
    self:_clearEnemyProjectileVisuals(viewEntry, false)
    releaseViewEntry(viewEntry)
    projectile.viewEntry = nil
end

---@param projectile table
---@return boolean
function BombGamePanel:_isEnemyProjectileHitShip(projectile)
    if not self._ship then
        return false
    end
    local shipMinX, shipMaxX, shipMinY, shipMaxY = self._ship:GetCollisionBox()
    local bulletMinX = projectile.x - projectile.halfWidth
    local bulletMaxX = projectile.x + projectile.halfWidth
    local bulletMinY = projectile.y - projectile.halfHeight
    local bulletMaxY = projectile.y + projectile.halfHeight
    return isBoxIntersect(bulletMinX, bulletMaxX, bulletMinY, bulletMaxY, shipMinX, shipMaxX, shipMinY, shipMaxY)
end

---@param projectile table
function BombGamePanel:_onShipHitByEnemyProjectile(projectile)
    self:_tryDamageShip("enemy_projectile")
end

---@param fish BombGameFish
function BombGamePanel:_tryFishTouchShip(fish)
    if self._state ~= "playing" or not fish or not fish:IsAlive() or not self._ship then
        return
    end
    local fishMinX, fishMaxX, fishMinY, fishMaxY = self:_getFishBox(fish)
    if not fishMinX or not fishMaxX or not fishMinY or not fishMaxY then
        return
    end
    local shipMinX, shipMaxX, shipMinY, shipMaxY = self._ship:GetCollisionBox()
    if not shipMinX or not shipMaxX or not shipMinY or not shipMaxY then
        return
    end
    if isBoxIntersect(fishMinX, fishMaxX, fishMinY, fishMaxY, shipMinX, shipMaxX, shipMinY, shipMaxY) then
        self:_tryDamageShip("fish_touch")
    end
end

---@param fish BombGameFish
function BombGamePanel:_tryFishDeathExplosionDamage(fish)
    if not self._ship then
        return
    end
    local _, _, _, _, fishCenterX, fishCenterY = fish:GetCollisionBox()
    local _, _, _, _, shipCenterX, shipCenterY = self._ship:GetCollisionBox()
    if not fishCenterX or not shipCenterX then
        return
    end
    local explodeRadius = fish.explodeRadius or 0
    if distanceSq(fishCenterX, fishCenterY, shipCenterX, shipCenterY) <= explodeRadius * explodeRadius then
        self:_tryDamageShip("fish_explode")
    end
end

---@param reason string
function BombGamePanel:_tryDamageShip(reason)
    if self._state ~= "playing" then
        return false
    end
    if (self._shipDamageCd or 0) > 0 then
        return false
    end
    local previousHp = self._shipHp or 0
    self._shipDamageCd = self._cfg.shipDamageInvuln or 0
    self._shipHp = math.max(0, (self._shipHp or 0) - 1)
    self:_playShipHitBlink(self._shipDamageCd)
    self:_playLifeLoseAnim(previousHp)
    if self._shipHp <= 0 then
        self:_finishGame(reason or "ship_down")
    end
    return true
end

function BombGamePanel:_getShipBlinkTarget()
    if not self._ship then
        return nil
    end
    return self._ship.gameObject or (self._shipViewEntry and self._shipViewEntry.roleObj)
end

function BombGamePanel:_stopShipHitBlink()
    local shipObject = self:_getShipBlinkTarget()
    if not shipObject then
        return
    end
    local canvasGroup = shipObject:GetComponent(TypeInfo.CanvasGroup)
    if canvasGroup then
        canvasGroup:DOKill(false)
        canvasGroup.alpha = 1
    end
end

---@param duration number
function BombGamePanel:_playShipHitBlink(duration)
    local shipObject = self:_getShipBlinkTarget()
    if not shipObject or not duration or duration <= 0 then
        return
    end
    ---@type UnityEngine.CanvasGroup
    local canvasGroup = shipObject:GetOrAddComponent(TypeInfo.CanvasGroup)
    canvasGroup:DOKill(false)
    canvasGroup.alpha = 1
    local step = shipHitBlinkStep
    local loopCount = math.max(2, math.floor(duration / step))
    if loopCount % 2 ~= 0 then
        loopCount = loopCount + 1
    end
    ---@type any
    local blinkTween = canvasGroup:DOFade(shipHitBlinkAlpha, step)
    blinkTween:SetEase(DG.Tweening.Ease.InOutSine)
    blinkTween:SetLoops(loopCount, DG.Tweening.LoopType.Yoyo)
    blinkTween:OnComplete(function()
        if canvasGroup then
            canvasGroup.alpha = 1
        end
    end)
end

---@param lifeIndex integer
function BombGamePanel:_playLifeLoseAnim(lifeIndex)
    if not self._lifeImages or not lifeIndex or lifeIndex <= 0 then
        return
    end
    local lifeObject = self._lifeImages[lifeIndex]
    if not lifeObject then
        return
    end
    self._lifeAnimatingIndex = lifeIndex
    lifeObject:SetActive(true)
    ---@type any
    local lifeTransform = lifeObject.transform
    if lifeTransform then
        lifeTransform:DOKill(false)
        lifeTransform.localScale = Vector3.New(1, 1, 1)
        ---@type any
        local scaleUpTween = lifeTransform:DOScale(Vector3.New(1.28, 1.28, 1), lifeLoseAnimDuration * 0.5)
        scaleUpTween:OnComplete(function()
            if lifeTransform then
                lifeTransform:DOScale(Vector3.New(1, 1, 1), lifeLoseAnimDuration * 0.5)
            end
        end)
        scaleUpTween:OnComplete(function()
            if lifeTransform then
                local scaleDownTween = lifeTransform:DOScale(Vector3.New(1, 1, 1), lifeLoseAnimDuration * 0.5)
                scaleDownTween:OnComplete(function()
                    if lifeTransform then
                        lifeTransform.localScale = Vector3.New(1, 1, 1)
                    end
                    if self._shipHp < lifeIndex and lifeObject then
                        lifeObject:SetActive(false)
                    end
                    if self._lifeAnimatingIndex == lifeIndex then
                        self._lifeAnimatingIndex = nil
                    end
                end)
            end
        end)
    end
end

function BombGamePanel:_finishGame(reason)
    if self._state == "settling" then
        return
    end
    self._state = "settling"
    self._stateTimer = 0
    self._settleCloseReady = false
    self:_stopShipHitBlink()
    if self._ship then
        self._ship:Stop()
    end
    self._settleData = {
        reason = reason,
        score = self._score,
        reward = math.floor(self._score / 10),
    }
    self:_applyFlowUi("settle")
    self:_setSettleCloseInteractable(false)
    if self.settleScoreText and self.settleScoreText.text then
        self.settleScoreText.text.text = tostring(self._score or 0)
    end
end

---@param enabled boolean
function BombGamePanel:_setSettleCloseInteractable(enabled)
    if self.mask and self.mask.button then
        self.mask.button.interactable = enabled == true
    end
end

function BombGamePanel:_canClosePanel()
    if self._state == "settling" then
        return self._settleCloseReady == true
    end
    return true
end

function BombGamePanel:_settleRewards()
    self._summaryText = string.format("%s|%d|%d", self._settleData.reason, self._settleData.score, self._settleData.reward)
    if self._openData and self._openData.onFinish then
        self._openData.onFinish(self._settleData)
    end
end

function BombGamePanel:_refreshHud()
    if self.timeText and self.timeText.text then
        if self._state == "playing" then
            local remain = math.ceil(self._remainTime)
            self.timeText.text.text = string.format(tostring(remain))
        else
            self.timeText.text.text = "-"
        end
    end

    if self.scoreText and self.scoreText.text then
        self.scoreText.text.text = tostring(self._score or 0)
    end

    if self._ammoImages and #self._ammoImages ~= self:_getMaxAmmo() then
        self:_rebuildAmmoImages()
    end
    if self._ammoImages then
        local ammoCount = self._ammo or 0
        for index, ammoItem in ipairs(self._ammoImages) do
            if ammoItem and ammoItem.gameObject then
                if ammoItem.canvasGroup then
                    ammoItem.canvasGroup.alpha = index <= ammoCount and 1 or 0.3
                end
            end
        end
    end

    if self._lifeImages then
        for index, lifeObject in ipairs(self._lifeImages) do
            if lifeObject then
                local shouldKeepAnim = self._lifeAnimatingIndex == index and index > (self._shipHp or 0)
                if not shouldKeepAnim then
                    lifeObject:SetActive(index <= (self._shipHp or 0))
                end
            end
        end
    end

    if self.hitBtn and self.hitBtn.scaleButton then
        self.hitBtn.scaleButton.interactable = self:_canAttack()
    end
end

function BombGamePanel:_refreshSuperBombBtn(deferHide)
    if not self.useSuperBombBtn then
        return
    end

    -- 非对局状态不显示操作按钮
    if self._state ~= "playing" then
        self:_setGoActive(self.useSuperBombBtn, false)
        return
    end

    local superBombCount = self._superBombCount or 0
    local superBombObject = self.useSuperBombBtn.gameObject or self.useSuperBombBtn
    if self.useSuperBombBtn.scaleButton then
        self.useSuperBombBtn.scaleButton.interactable = superBombCount > 0
    end
    if not superBombObject then
        return
    end

    if superBombCount > 0 then
        superBombObject:SetActive(true)
        return
    end

    -- 仅在按钮点击回调里延迟隐藏，避免多指触控时 EventSystem 卡死。
    if deferHide == true then
        self:DoAfter(0.05, function()
            if not self.useSuperBombBtn or self._state ~= "playing" then
                return
            end
            local count = self._superBombCount or 0
            if count > 0 then
                return
            end
            local btnObject = self.useSuperBombBtn.gameObject or self.useSuperBombBtn
            if btnObject then
                btnObject:SetActive(false)
            end
        end)
        return
    end

    superBombObject:SetActive(false)
end

function BombGamePanel:_canAttack()
    return self._state == "playing"
        and not self:_isShipStunned()
        and self._bombCd <= 0
        and (self._ammo or 0) > 0
end

function BombGamePanel:_consumeAmmo()
    self._ammo = math.max(0, (self._ammo or 0) - 1)
    if self._ammo < self:_getMaxAmmo() and self._ammoRecoverCd <= 0 then
        self._ammoRecoverCd = self._cfg.ammoRecoverCd
    end
end

function BombGamePanel:_clearFloatingTexts()
    if not self._floatingTexts then
        return
    end
    for index = #self._floatingTexts, 1, -1 do
        local item = self._floatingTexts[index]
        if item.viewEntry then
            releaseViewEntry(item.viewEntry)
        elseif item.gameObject then
            GameObject.Destroy(item.gameObject)
        end
        table.remove(self._floatingTexts, index)
    end
end

---@param x number
---@param y number
---@param score integer
---@param mulite integer
function BombGamePanel:_showKillScorePrompt(x, y, score, mulite)
    if not self.gameArea or not self.gameArea.rectTransform then
        return
    end

    local viewEntry = self:_acquireScoreTextViewEntry()
    if not viewEntry or not viewEntry.transform then
        return
    end

    ---@type UnityEngine.RectTransform
    local rectTransform = viewEntry.transform:GetComponent(TypeInfo.RectTransform)
    local promptObject = rectTransform.gameObject
    local scoreTextTransform = rectTransform:Find("GetScoreText")
    ---@type UnityEngine.UI.Text
    local text = scoreTextTransform:GetComponent(TypeInfo.Text)
    ---@type UnityEngine.CanvasGroup
    local canvasGroup = promptObject:GetOrAddComponent(TypeInfo.CanvasGroup)
    if text then
        text.text = tostring(score)
    end
    local muliteTextTransform = scoreTextTransform:Find("MuliteText")
    ---@type UnityEngine.UI.Text
    local muliteText = muliteTextTransform:GetComponent(TypeInfo.Text)
    if muliteText then
        muliteText.text = tostring(mulite)
    end
    if rectTransform then
        rectTransform.anchoredPosition3D = Vector3.New(x, y, 0)
        rectTransform.localScale = Vector3.New(0.7, 0.7, 0.7)
    end
    if canvasGroup then
        canvasGroup.alpha = 1
    end

    table.insert(self._floatingTexts, {
        viewEntry = viewEntry,
        gameObject = promptObject,
        rectTransform = rectTransform,
        canvasGroup = canvasGroup,
        left = 2,
        duration = 2,
        riseSpeed = 45,
    })
end

---@param posX number
function BombGamePanel:_spawnBomb(posX)
    ---@type BombGameBomb
    local bomb = BombGameBomb:new(nil, {
        x = posX,
        y = self._cfg.waterSurfaceY,
        speed = self._cfg.bombFallSpeed,
        halfWidth = self._cfg.bombHitHalfWidth or 8.5,
        halfHeight = self._cfg.bombHitHalfHeight or 35,
        alive = true,
    }, self:_acquireBombViewEntry())
    table.insert(self._bombs, bomb)
end

function BombGamePanel:_closeFunc()
    if not self:_canClosePanel() then
        return
    end
    self:_stopShipHitBlink()
    self:OnClose()
    UIMgr:closeUI("BombGamePanel")
end

function BombGamePanel:closeBtn_ScaleButton_onClick(closeBtn)
    self:_closeFunc()
end

function BombGamePanel:hitBtn_ScaleButton_onClick(hitBtn)
    if not self:_canAttack() then
        return
    end
    self._ship:PlayAttack()
    self:_consumeAmmo()
    self._bombCd = self._cfg.bombCd
    table.insert(self._pendingBombs, {
        x = self._ship:GetX(),
        left = self._cfg.bombSpawnDelay,
    })
end

--[[
/UseSuperBombBtn onClick 
--]]
function BombGamePanel:useSuperBombBtn_ScaleButton_onClick(useSuperBombBtn)
    self:_useSuperBomb()
end

--[[
/StateRoot/StartLayer/StartBtn onClick 
--]]
function BombGamePanel:startBtn_ScaleButton_onClick(startBtn)
    if self._state ~= "start" then
        return
    end
    if not self._ship then
        self._pendingStart = true
        return
    end
    self:_beginCountdownFlow()
end

--[[
/touchArea onClick 
--]]
function BombGamePanel:touchArea_Button_onClick(touchArea)

end

--[[
/StateRoot/SettleLayer/Mask onClick 
--]]
function BombGamePanel:mask_Button_onClick(mask)
    self:_closeFunc()
end

return BombGamePanel
