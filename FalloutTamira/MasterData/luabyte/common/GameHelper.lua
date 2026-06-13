GameHelper = {}

local CS_LuaUtils = CS.GameX.LuaUtils
local CS_RoleResMgr = CS.GameX.RoleResMgr
local CS_GameHelper = CS.GameX.GameHelper
local CS_AudioHelper = CS.AudioHelper
local CS_TimelineHelper = CS.TimelineHelper
local CS_GuideHelper = CS.GameX.Guide.GuideHelper
local CS_SystemHelper = CS.GameX.Const.SystemHelper
local CS_TransformHelper = CS.GameX.TransformHelper
local CS_ConfigHelper = CS.GameX.Config.ConfigHelper

function GameHelper.GetCardQualityColor(quality)
    return CS_GameHelper.GetCardQualityColor(quality)
end

function GameHelper.Confirm1(context, callback)
    CS_GameHelper.Confirm1(context, callback)
end

---itemGroupId
---------title  标题
---------tip    底部tip提示，如果传nil或'' 会隐藏tip
---------showGetBtn 显示领取奖励按钮
---------showreceived 显示已领取图标
---callback 回调函数
function GameHelper.ConfirmReward(itemGroupId, title, describe, tip, showGetBtn, showreceived, callback)
    UIContextMgr:GetInstance():Show("ConfirmRewardUI", itemGroupId, title, describe,
        tip, showGetBtn, showreceived, callback)
end

function GameHelper.Confirm(context, callback, keyName)
    CS_GameHelper.Confirm(context, callback, keyName or "")
end

function GameHelper.ConfirmUI(context, onClick, onCancel, sortOrder, labCancel, labOk)
    if not labOk then labOk = 56 end
    if not sortOrder then sortOrder = 31 end
    if not labCancel then labCancel = 323 end
    CS_GameHelper.Confirm(context, onClick, onCancel, sortOrder, labCancel, labOk)
end

function GameHelper.ConfirmPopupUI(context, onClick, onCancel, sortOrder, labCancel, labOk)
    if not labOk then labOk = 56 end
    if not sortOrder then sortOrder = 31 end
    if not labCancel then labCancel = 323 end
    CS_GameHelper.ConfirmPopupUI(context, onClick, onCancel, sortOrder, labCancel, labOk)
end

function GameHelper.Tips(context)
    if type(context) == "number" then
        GameHelper.TipsById(context)
        return
    end
    CS_GameHelper.Tips(context)
end

function GameHelper.TipsById(languageId)
    CS_GameHelper.TipsById(languageId)
end

function GameHelper.TipsByLockId(lockId)
    local openCondition = ConfigHelper.GetCfgByLua("openCondition", lockId)
    if openCondition then
        GameHelper.TipsById(openCondition.tips)
    else
        Logger.LogError("[openCondition] is nil, id = " .. lockId)
    end
end

function GameHelper.ItemTipsByTableArr(itemTableArr)
    local dic = {}

    for _, v in ipairs(itemTableArr) do
        dic[v.Id] = v.Cnt
    end

    CS_GameHelper.ItemTipsByDic(dic)
end

function GameHelper.ItemTips(citems, isReward)
    if not isReward then
        isReward = false
    end
    CS_GameHelper.ItemTipsByDic(citems, isReward)
end

function GameHelper.DormItemTips(citems, isReward)
    if not isReward then
        isReward = false
    end
    CS_GameHelper.DormItemTipsByDic(citems, isReward)
end

--展示奖励，格式 {id1,count1,id2,count2,...}
function GameHelper.ShowGetItemsByIntTable(intTables)
    if intTables == nil then
        return
    end
    if #intTables % 2 ~= 0 then
        return
    end
    local dic = {}
    local num = #intTables / 2
    for i = 1, num do
        local id = intTables[(i - 1) * 2 + 1]
        local num = intTables[(i - 1) + 2]
        dic[id] = num
    end
    GameHelper.ShowGetItems(dic)
end

function GameHelper.GiftTips(dic)
    CS_GameHelper.GiftTips(dic)
end

function GameHelper.Jump(jumpId, ...)
    return JumpMgr:GetInstance():Execute(jumpId, ...)
end

function GameHelper.JumpFormGeneral(jumpId, ...)
    return JumpMgr:GetInstance():ExecuteFromGeneral(jumpId, ...)
end

function GameHelper.CheckLockByJumpId(jumpId)
    return JumpMgr:GetInstance():CheckLockByJumpId(jumpId)
end

function GameHelper.CheckLockByOpenConditionId(openConditionId, args)
    return JumpMgr:GetInstance():CheckLockByOpenConditionId(openConditionId, args)
end

function GameHelper.CheckLockByOpenConditionIds(openConditionIds, args)
    return JumpMgr:GetInstance():CheckLockByOpenConditionIds(openConditionIds, args)
end

function GameHelper.CheckAtLastOneOpenConditionUnLock(openConditionIds)
    return JumpMgr:GetInstance():CheckAtLastOneOpenConditionUnLock(openConditionIds)
end

function GameHelper.CSCheckAtLastOneOpenConditionUnLock(openConditionIds)
    return JumpMgr:GetInstance():CSCheckAtLastOneOpenConditionUnLock(openConditionIds)
end

function GameHelper.GetLockConditions(openConditionIds)
    return JumpMgr:GetInstance():GetLockConditions(openConditionIds)
end

function GameHelper.GetLockCount(openConditionIds)
    return JumpMgr:GetInstance():GetLockCount(openConditionIds)
end

function GameHelper.GetFirstLockReason(openConditionIds)
    return JumpMgr:GetInstance():GetFirstLockReason(openConditionIds)
end

---前缀为CS为专门提供给C#代码调用的
---CS 由于C#传入lua的为数组的userdata，需要遍历时采用不同的方法
function GameHelper.CSCheckLockByOpenConditionIds(openConditionIds)
    return JumpMgr:GetInstance():CSCheckLockByOpenConditionIds(openConditionIds)
end

---前缀为CS为专门提供给C#代码调用的
---CS 由于C#传入lua的为数组的userdata，需要遍历时采用不同的方法
function GameHelper.CSCheckLockByOpenConditionIdsWithArgs(openConditionIds, args)
    return JumpMgr:GetInstance():CSCheckLockByOpenConditionIdsWithArgs(openConditionIds, args)
end

---前缀为CS为专门提供给C#代码调用的
---CS 由于C#传入lua的为数组的userdata，需要遍历时采用不同的方法
function GameHelper.CSGetLockConditions(openConditionIds)
    return JumpMgr:GetInstance():CSGetLockConditions(openConditionIds)
end

---前缀为CS为专门提供给C#代码调用的
---CS 由于C#传入lua的为数组的userdata，需要遍历时采用不同的方法
function GameHelper.CSGetLockCount(openConditionIds)
    return JumpMgr:GetInstance():CSGetLockCount(openConditionIds)
end

---前缀为CS为专门提供给C#代码调用的
---CS 由于C#传入lua的为数组的userdata，需要遍历时采用不同的方法
function GameHelper.CSGetUnLockCount(openConditionIds)
    return JumpMgr:GetInstance():CSGetUnLockCount(openConditionIds)
end

---前缀为CS为专门提供给C#代码调用的
---CS 由于C#传入lua的为数组的userdata，需要遍历时采用不同的方法
function GameHelper.CSGetFirstLockReason(openConditionIds)
    return JumpMgr:GetInstance():CSGetFirstLockReason(openConditionIds)
end

function GameHelper.CheckJumpBack()
    return JumpMgr:GetInstance():CheckJumpBack()
end

function GameHelper.ExecuteSkillEffect(effectType, casterRole, targetRole, jSkill, effectValues, attackValue, targetPos)
    return BattleHelper:GetInstance():ExecuteSkillEffect(effectType, casterRole, targetRole, jSkill, effectValues,
        attackValue, targetPos)
end

--显示多个角色获得展示 --因为有些时候需要向下传递数据， 但是仅展示部分数据 所以出来了这个spHerodata
function GameHelper.ShowRolesStarSuccess(heroDatas, onShowRoleCallBack, spHeroData, canSkip)
    if canSkip == nil then
        canSkip = true
    end
    UIContextMgr:GetInstance():Show("Lottery1Result", heroDatas, onShowRoleCallBack, onShowRoleCallBack, spHeroData,
        canSkip)
end

--显示多个角色获得展示，用于Csharp调用
function GameHelper.ShowRolesStarSuccessByCS(csIlistCitems, callback, canSkip)
    if canSkip == nil then
        canSkip = true
    end
    local len = csIlistCitems.Count
    local list = {}

    for i = 0, len - 1 do
        local citem = csIlistCitems[i]
        local l = {}
        l.ObjId = citem.SrcId
        l.ObjNum = 1
        l.ChipId = citem.Id
        l.ChipNum = citem.Cnt
        table.insert(list, l)
    end

    GameHelper.ShowRolesStarSuccess(list, callback, nil, canSkip)
end

function GameHelper.CheckItem(itemId, itemCount, ...)
    if not itemId then return true end
    local num = ItemDataMgr:GetInstance():GetItemNumById(itemId)
    return num >= itemCount
end

function GameHelper.CheckItems(arr, length)
    local itemCount = length / 2

    for i = 1, itemCount do
        local idx = i
        local itemId = arr[idx]
        local itemCount = arr[idx + 1]

        if not GameHelper.CheckItem(itemId, itemCount) then
            return false
        end
    end
    return true
end

function GameHelper.CheckItemsByCS(itemArr, numsArr)
    local itemLen = itemArr and itemArr.Length or 0
    local numsLen = numsArr and numsArr.Length or 0

    if itemLen <= 0 or numsLen <= 0 then
        return false
    end

    for i = 0, itemLen - 1 do
        if not GameHelper.CheckItem(itemArr[i], numsArr[i]) then
            return false
        end
    end
    return true
end

function GameHelper.CheckItemsByLua(items, nums)
    items = items or {}
    nums = nums or {}

    for i, value in pairs(items) do
        if not GameHelper.CheckItem(value, nums[i] or 0) then
            return false
        end
    end
    return true
end

function GameHelper.CheckOneOfItems(arr, length)
    local itemCount = length / 2

    for i = 1, itemCount do
        local idx = i
        local itemId = arr[(idx - 1) * 2 + 1]
        local itemNum = arr[(idx - 1) * 2 + 2]

        if GameHelper.CheckItem(itemId, itemNum) then
            return true, itemId, itemNum
        end
    end
    return false
end

function GameHelper.ShowGetItemsByItems(items, closeCallback, canSkip)
    if canSkip == nil then
        canSkip = true
    end
    local dic = {}
    local heroList = {}

    for i, v in ipairs(items) do
        local itemCfg = ConfigHelper.GetCfg("item", v.SrcId)

        if itemCfg and itemCfg.type == BagConst.ItemType.EIT_Hero then
            if v.SrcId == v.ObjId or v.ObjType == "E_Hero" then
                table.insert(heroList,
                    { ObjId = v.SrcId, ObjNum = 1, ChipId = 0, ChipNum = 1, quality = itemCfg.quality })
            else
                table.insert(heroList,
                    { ObjId = v.SrcId, ObjNum = 1, ChipId = v.Id, ChipNum = v.Cnt, quality = itemCfg.quality })
            end
        end
        if not dic[v.Id] then
            dic[v.Id] = v.Cnt
        else
            dic[v.Id] = dic[v.Id] + v.Cnt
        end
    end

    --优先展示英雄
    if #heroList > 0 then
        GameHelper.ShowRolesStarSuccess(heroList, function()
            GameHelper.ShowGetItems(dic, closeCallback)
        end, heroList, canSkip)
        return
    end

    GameHelper.ShowGetItems(dic, closeCallback)
end

function GameHelper.ShowGetItems(luaDic, closeCallback)
    CS_GameHelper.ShowGetItemsByDic(luaDic, closeCallback)
end

function GameHelper.ShowAwards(ids, nums, stateDic, closeCallback)
    CS_GameHelper.ShowAwards(ids, nums, stateDic, closeCallback)
end

function GameHelper.ShowGetItemsById(itemsid, itemsNumber, closeCallBack)
    CS_GameHelper.ShowGetItems(itemsid, itemsNumber, closeCallBack)
end

function GameHelper.ShowCreateRoleRewards(itemsid, itemsNumber, closeCallBack)
    CS_GameHelper.ShowGetItems(itemsid, itemsNumber, closeCallBack)
end

---@param itemId number 道具ID
---@param needNum number 道具需求数量
---@param closeCallback function 关闭回调
function GameHelper.PopItem(itemId, needNum, target, closeCallback)
    UIContextMgr:GetInstance():Show(UIDefine.UIItem, itemId, needNum, target, closeCallback)
end

local ms_nameFormat = "%sx%d"
--道具名称和数量组合
function GameHelper.GetItemNameCount(itemId, itemCount)
    local itemCfg = ConfigHelper.GetCfgByLua("item", itemId)

    if type(itemCfg) == "table" then
        -- LUA实现
        local name = ConfigHelper.GetLocalString(itemCfg.name)
        return string.format(ms_nameFormat, name, itemCount)
    else
        -- C# 实现
        return itemCfg:GetNameCount(itemCount)
    end
end

--获得C#数组的道具名称组合
function GameHelper.GetItemNameCounts(arr, length)
    local itemCount = length / 2
    local strArr = {}

    for i = 1, itemCount do
        local idx = i
        local itemId = arr[idx]
        local itemCount = arr[idx + 1]
        table.insert(strArr, GameHelper.GetItemNameCount(itemId, itemCount))
    end
    return string.join(strArr, ",")
end

--播放timeline
function GameHelper.PlayTimline(assetPath, onPlayComplete)
    CS_LuaUtils.PlayTimline(assetPath, onPlayComplete)
end

--播放timeline
function GameHelper.PlayTimelineObj(go, onPlayComplete, isAutoDispose, time)
    if isAutoDispose == nil then
        isAutoDispose = false
    end

    if time == nil then
        time = 0
    end
    CS_LuaUtils.PlayTimlineObj(go, onPlayComplete, isAutoDispose, time)
end

--播放timeline带回调的
function GameHelper.PlayTimelineObjByCallBack(go, onPlayComplete, isAutoDispose, time)
    if isAutoDispose == nil then
        isAutoDispose = false
    end

    if time == nil then
        time = 0
    end
    CS_LuaUtils.PlayTimelineObjByCallBack(go, onPlayComplete, isAutoDispose, time)
end

--播放timeline
function GameHelper.PlayTimlineById(timelineId, onPlayComplete, delay)
    if delay == nil then
        delay = 0
    end
    CS_LuaUtils.PlayTimlineById(timelineId, onPlayComplete, delay)
end

--缓存timeline
function GameHelper.AddTimelinesToPool(timelineIds)
    CS_LuaUtils.AddTimelinesToPool(timelineIds)
end

function GameHelper.CreateRoleBySkinId(skinId, showWeapon, setAnimator, displayType, onComplete)
    if showWeapon == nil then showWeapon = false end
    if setAnimator == nil then setAnimator = false end
    if displayType == nil then displayType = 2 end
    return CS_RoleResMgr.LoadRoleBySkinId(skinId, showWeapon, setAnimator, displayType, onComplete)
end

function GameHelper.CreateRole(id, showWeapon, setAnimator, displayType, onComplete)
    if showWeapon == nil then showWeapon = false end
    if setAnimator == nil then setAnimator = false end
    if displayType == nil then displayType = 2 end
    return CS_RoleResMgr.LoadRole(id, showWeapon, setAnimator, displayType, onComplete)
end

function GameHelper.CreateDormRole(res)
    return CS_RoleResMgr.LoadDormRole(res)
end

--秒数转换时分秒
function GameHelper.formatTime(time)
    local hour = math.floor(time / 3600)
    local minute = math.fmod(math.floor(time / 60), 60)
    local second = math.fmod(time, 60)
    local rtTime = string.format("%02d:%02d:%02d", hour, minute, second)
    return rtTime
end

--判断两个table是否相等
function GameHelper.tableEqual(a, b)
    if #a ~= #b then
        return false
    end

    for i = 1, #a do
        if a[i] ~= b[i] then
            return false
        end
    end

    return true
end

function GameHelper.HaveHeroAwakeSkin(heroid, awakeLevel)
    local heroCfg = ConfigHelper.GetCfg("hero", heroid)
    if heroCfg == nil then
        return false
    end
    if heroCfg.rare == 3 then
        return awakeLevel >= 3
    elseif heroCfg.rare == 4 then
        return awakeLevel >= 6
    end
    return false
end

function GameHelper.SetOtakuState(state)
    CS_GameHelper.SetOtakuState(state)
end

function GameHelper.CheckBlockWord(name)
    return CS_ConfigHelper.CheckBlockWord(name)
end

function GameHelper.PlayAudioById(eventid)
    CS_AudioHelper.PlayAudioById(eventid)
end

function GameHelper.SetAudioState(stateName, value)
    CS_AudioHelper.SetAudioState(stateName, value)
end

function GameHelper.PlaySoundReturnObjId(eventName, _type, callback)
    return CS_AudioHelper.PlaySoundReturnObjId(eventName, _type, callback)
end

function GameHelper.PlaySoundReturnObjById(soundId, callback)
    return CS_AudioHelper.PlaySoundReturnObjById(soundId, 1, callback)
end

function GameHelper.UnRegisterCallBackByObjId(objId)
    CS_AudioHelper.UnRegisterCallBackByObjId(objId)
end

--计算账号某个道具数量是否充足
function GameHelper.CalItemEnough(itemId, itemNum)
    return CS_GameHelper.CalItemEnough(itemId, itemNum)
end

--获取当前时间的字符串
function GameHelper.GetCurTimeStr(format)
    return CS_GameHelper.GetCurTimeStr(format)
end

--时间戳转字符串
function GameHelper.TimeStampToString(timeStamp, format)
    return CS_GameHelper.TimeStampToString(timeStamp, format)
end

function GameHelper.DoPlayerAction(actionId)
    return CS_AudioHelper.DoPlayerAction(actionId)
end

function GameHelper.secondsToString(seconds)
    return CS_GameHelper.secondsToString(seconds)
end

function GameHelper.GetParamters(id)
    return CS_SystemHelper.GetParamters(id)
end

function GameHelper.GetParamter(id)
    return CS_SystemHelper.GetParamter(id)
end

-- check字数是否合法
-- 不到最小返回为负数，合法字数返回为0 ， 超过最大字数返回正数
function GameHelper.CheckInputLimit(minNum, maxNum, conetent)
    local inputNum = GameHelper.GetStrCharaterNum(conetent)
    if inputNum < minNum then
        return -1
    end
    if inputNum > maxNum then
        return 1
    end
    return 0
end

function GameHelper.GetStrCharaterNum(content)
    return CS_SystemHelper.GetStrCharaterNum(content)
end

function GameHelper.IsDebugBuild()
    return CS_GameHelper.IsDebugBuild()
end

function GameHelper.GetChallengeTarget(key)
    return CS_GameHelper.GetChallengeTarget(key)
end

function GameHelper.SetChallengeTarget(list, missionId)
    CS_GameHelper.SetChallengeTarget(list, missionId)
end

function GameHelper.TableToArray(table)
    return CS_GameHelper.TableToArray(table)
end

function GameHelper.SetLayer(go, layer)
    return CS_GameHelper.SetLayer(go, layer)
end

function GameHelper.GetDateTime(time)
    return CS_GameHelper.GetDateTime(time)
end

function GameHelper.ConvertByHex(value, toBase)
    return CS_GameHelper.ConvertByHex(value, toBase)
end

function GameHelper.SendCreateRoleGameOverEvent()
    return CS_GameHelper.SendCreateRoleGameOverEvent()
end

function GameHelper.SaveLuckDrawData(_type, poolid, itemsid, itemsnumber, spTag)
    return CS_GameHelper.SaveLuckDrawData(_type, poolid, itemsid, itemsnumber, spTag)
end

function GameHelper.GetLuckDrawData(type)
    return CS_GameHelper.GetLuckDrawData(type)
end

function GameHelper.CopyToClipboard(input)
    CS_GameHelper.CopyToClipboard(input)
end

function GameHelper.SetPlayerPrefsStr(key, value)
    CS_GameHelper.SetPlayerPrefsStr(key, value)
end

function GameHelper.SetPlayerPrefsInt(key, value)
    CS_GameHelper.SetPlayerPrefsInt(key, value)
end

function GameHelper.GetPlayerPrefsInt(key, defaultValue)
    return CS_GameHelper.GetPlayerPrefsInt(key, defaultValue)
end

function GameHelper.GetPlayerPrefsStr(key, defaultValue)
    return CS_GameHelper.GetPlayerPrefsStr(key, defaultValue)
end

function GameHelper.StoryAfterWarEvent()
    CS_GameHelper.StoryAfterWarEvent()
end

function GameHelper.ShowTipByRecord(content, action, recordKey)
    UIContextMgr:GetInstance():Show(UIDefine.ConfirmByRecord, content, action, recordKey)
end

function GameHelper.ShowJourneyRewards(itemDic, callback, eventId)
    CS_GameHelper.ShowJourneyRewards(itemDic, callback, eventId)
end

function GameHelper.CheckItemsEnough(checkItem, targetNum, needTip, needPop)
    if needTip == nil then needTip = false end
    if needPop == nil then needPop = false end
    return CS_GameHelper.CheckItemsEnough(checkItem, targetNum, needTip, needPop)
end

function GameHelper.Check_ItemsEnough(itemIds, itemNums)
    return CS_GameHelper.Check_ItemsEnough(itemIds, itemNums)
end

function GameHelper.UIToWorldPointPos(uiPos, uiCamera, mainCamera)
    return CS_TransformHelper.UIToWorldPointPos(uiPos, uiCamera, mainCamera)
end

--播放timeline带回调的 登记--因为现在lua不持有timeline的引用 为后续操作做准备
function GameHelper.PlayTimelineObjByCallBack_Sign(go, onPlayComplete, isAutoDispose, time)
    if isAutoDispose == nil then
        isAutoDispose = false
    end

    if time == nil then
        time = 0
    end
    return CS_LuaUtils.PlayTimelineObjByCallBack_Sign(go, onPlayComplete, isAutoDispose, time)
end

--重播TimeLine 只有上面那个方法登记过的才行
function GameHelper.ResumeTimeLineByIndex(index)
    CS_LuaUtils.ResumeTimeLineByIndex(index)
end

--暂停TimeLine 只有上面那个方法登记过的才行
function GameHelper.PauseTimeLineByIndex(index)
    CS_LuaUtils.PauseTimeLineByIndex(index)
end

--设置ProcessAction 只有上面那个方法登记过的才行
function GameHelper.SetTimeLineProcessActionByIndex(index, action)
    CS_LuaUtils.SetTimeLineProcessActionByIndex(index, action)
end

--设置TimeLine相机状态 只有上面那个方法登记过的才行
function GameHelper.SetTimeLineCameraByIndex(index, active)
    CS_LuaUtils.SetTimeLineCameraByIndex(index, active)
end

function GameHelper.PlayTimelineAssetById(timelineId, action, isAutoDispose)
    return CS_TimelineHelper.PlayTimelineAssetById(timelineId, action, isAutoDispose)
end

--获取电量
function GameHelper.GetBatteryLevel()
    return CS_GameHelper.GetBatteryLevel()
end

--获取是否充电
function GameHelper.GetBatteryStatus()
    return CS_GameHelper.GetBatteryStatus()
end

--截图保存路径
function GameHelper.GetSavePicPath()
    return CS_GameHelper.GetSavePicPath()
end

--保存截图
function GameHelper.SaveScreenshot(texture, folderPath)
    return CS_GameHelper.SaveScreenshot(texture, folderPath)
end

--获取wifi状态
function GameHelper.GetWifiStauts()
    return CS_GameHelper.GetWifiStauts()
end

function GameHelper.GetTargetPos(target, parentRect, canvas)
    return CS_GuideHelper.GetTargetPos(target, parentRect, canvas)
end

function GameHelper.CheckUnShowBattleSetElementUI(missionid)
    return CS_GameHelper.CheckUnShowBattleSetElementUI(missionid)
end

function GameHelper.CheckPostPvState(path)
    return CS_AudioHelper.CheckPostPvState(path)
end

--通过英雄ID获得皮肤ID
function GameHelper.HeroId2SkinId(heroId, sign)
    if sign == nil then
        sign = 0
    end
    if heroId == nil or heroId == 0 then
        Logger.LogError("英雄ID转skinId失败，heroId = " .. tostring(heroId))
        return 0
    end
    return CS_GameHelper.HeroId2SkinId(heroId, sign)
end

function GameHelper.TransNumClip(num)
    return CS_GameHelper.TransNumClip(num)
end

-- 是否是一周中的某一天,周日：7 (1-7)
function GameHelper.CSCheckWeekDay(dates, hour)
    local curTime = TimeUtil.GetNowTimeStamp() - 3600 * (hour or 0)
    local day = tonumber(os.date("%w", curTime))
    if day == 0 then day = 7 end

    local len = dates and dates.Length or 0
    for i = 0, len - 1 do
        if day == dates[i] then return true end
    end
    return false
end

-- 是否是一周中的某一天,周日：7 (1-7)
function GameHelper.CheckWeekDay(dates, hour)
    local curTime = TimeUtil.GetNowTimeStamp() - 3600 * (hour or 0)
    local day = tonumber(os.date("%w", curTime))
    if day == 0 then day = 7 end

    for _, value in pairs(dates or {}) do
        if day == value then return true end
    end
    return false
end

function GameHelper.JoinQQGroup()
    return CS_GameHelper.JoinQQGroup()
end

--判断邮件功能是否解锁
function GameHelper.bMailLock()
    return (JumpMgr:GetInstance():CheckLockByJumpId(16) > 0)
end

function GameHelper.PostTestRecharge(money, orderId, ext)
    return CS_GameHelper.PostTestRecharge(money, orderId, ext)
end

-- 清理道具跳转记录数据
function GameHelper.ClearItemJump()
    local eType = EnumConst.NotesWorkType.ItemJump
    local noteData = NotesWorkMgr:GetInstance():GetDataByType(eType)
    if noteData then noteData:ClearData() end
end

-- Http请求
function GameHelper.HttpPost(uri, form, callback)
    CS_GameHelper.HttpPost(uri, form, callback)
end

function GameHelper.ShowSuperStore(storeID)
    CS_GameHelper.ShowSuperStore(storeID)
end

function GameHelper.SetRoleInfo()
    CS_GameHelper.SetRoleInfo()
end
