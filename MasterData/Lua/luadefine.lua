json = require("rapidjson");

Vector2 = CS.UnityEngine.Vector2;
Vector3 = CS.UnityEngine.Vector3;
Quaternion=CS.UnityEngine.Quaternion;
UnityEngine  = CS.UnityEngine;
GameObject = CS.UnityEngine.GameObject;
DOTWeen=CS.DG.Tweening.DOTween;
Ease=CS.DG.Tweening.Ease;
RotateMode=CS.DG.Tweening.RotateMode;
LoopType=CS.DG.Tweening.LoopType;
PathType=CS.DG.Tweening.PathType
LuaMgr = CS.Laigu.Manager.LuaManager;
AudioMgr=CS.Laigu.Manager.AudioManager;
SDKMgr=CS.Laigu.Manager.SDKManager;
RedMgr=CS.Laigu.Manager.RedManager;
RectTool = CS.Laigu.Tools.RectTransformTool;
FoundationTool = CS.Laigu.Tools.FoundationTool;
RaycastTool = CS.Laigu.Tools.RaycastTool;
FileTool = CS.Laigu.Tools.FileTool;
RectTransformTool = CS.Laigu.Tools.RectTransformTool;
PlayerPrefs = CS.UnityEngine.PlayerPrefs
HeroManager = CS.Laigu.ViewModel.Hero.HeroManager;
RhythmGameManager =CS.Laigu.Manager.RhythmGameManager
LongyuanSDKManager = CS.Laigu.Tools.SDK.LongYuanSDK
ActivityCameraMgr = CS.Laigu.ViewModel.ActivityCamera.ActivityCameraMgr
Rect = CS.UnityEngine.Rect;
DateTool = CS.Laigu.Tools.DateTool

DefaultTexture = LuaMgr.GetDefaultTexture();
DefaultSprite = LuaMgr.GetDefaultSprite();
function IsLua(modelName)
    local i,l = string.find(modelName,"Laigu.ViewModel")
    return i ~= 1 or l ~= 15;
end

myMetatable = {}
myMetatable.__add = function(_tab1,_tab2)
    for _,v in pairs(_tab2) do
        table.insert(_tab1,v)
    end
end

function table.Merge(tab1,tab2)
    setmetatable(tab1,myMetatable)
    return tab1 + tab2
end

function table.Copy(obj)
    local inTable = {}
    local function Func(obj)
        if type(obj) ~= "table" then
            return obj
        end
        local newTable = {}
        inTable[obj] = newTable
        for k,v in pairs(obj) do
            newTable[Func(k)] = Func(v)
        end
        return setmetatable(newTable,getmetatable(obj))
    end
    return Func(obj)
end


function table.CopyNoMeta(obj)
    local inTable = {}
    local function Func(obj)
        if type(obj) ~= "table" then
            return obj
        end
        if inTable[obj] then
            return inTable[obj]
        end
        local newTable = {}
        inTable[obj] = newTable
        for k, v in pairs(obj) do
            newTable[Func(k)] = Func(v)
        end
return newTable
    end
    return Func(obj)
end


function split(str,reps)
    local resultStrList = {}
    string.gsub(str,'[^'..reps..']+',function (w)
        table.insert(resultStrList,w)
    end)
    
    return resultStrList
end


function GetChineseBigNumber(value)
    if value>=100 or value<=0 then
        return "";
    end
    if value<10 then
        return GetChineseBigNumberHelper(value);
elseif value<20 and value>=10 then
        return GetChineseBigNumberHelper(10)..GetChineseBigNumberHelper(value%10);
else
        return GetChineseBigNumberHelper(value//10)..GetChineseBigNumberHelper(10)..GetChineseBigNumberHelper(value%10);
    end
end

function GetChineseBigNumberHelper(value)
    if value<=0 or value>10 then
        return "";
    end
    return ConfigMgr.LangGlobal(tostring(7216+value));
end


function StringToTable(s)
    local tb={}
    for utfChar in string.gmatch(s,"[%z\1-\127\194-\244][\128-\191]*") do
        table.insert(tb,utfChar)
    end
    return tb
end


function GetUTFLen(s)
    local sTable=StringToTable(s);
    local len=0;
    local charLen=0;
    for i = 1, #sTable, 1 do
        local utfCharLen=string.len(sTable[i]);
        if utfCharLen>1 then
            charLen=2;
        else
            charLen=1;
        end
        len=len+charLen;
    end
    return len;
end


function GetUTFLenWithCount(s,count)
    local sTable=StringToTable(s);
    local len=0;
    local charLen=0;
    local isLimited=(count>=0);
    for i = 1, #sTable, 1 do
        local utfCharLen=string.len(sTable[i]);
        if utfCharLen>1 then
            charLen=2;
        else
            charLen=1;
        end
        len=len+charLen;
        if isLimited then
            count=count-charLen;
            if count<=0 then
                break;
            end
        end
    end
    return len;
end




function CNSub(s,startIndex,finishIndex)
    local sTable=StringToTable(s);
    local nowIndex=0;
    local charLen=0;
    local finishString="";
    for i = 1, #sTable, 1 do
        local utfCharLen=string.len(sTable[i]);
        if utfCharLen>1 then
            charLen=2;
        else
            charLen=1;
        end
        nowIndex=nowIndex+charLen;
        if nowIndex>=finishIndex then
            break;
        end
        if nowIndex>=startIndex then
            finishString=finishString..tostring(sTable[i]);
        end
    end
    return finishString;
end


function TableIsNull(table)
    return table==nil or next(table)==nil;
end


function IsNull(obj)
    return obj == nil or obj == json.null
end

function TryArray(array)
    if NumTool.GetLen(array)~=0 then
        return;
    end
    arraymeta = {
        __jsontype = 'array';
    }
    setmetatable(array, arraymeta )
end


function IsNullOrEmpty(str)
    if str == nil then
        return true;
    end
    return str == "";
end


function IsObjectNull(obj)
    return obj == nil or obj:Equals(nil);
end


function GetRareSprite(rare)
    return LuaMgr.GetSprite("ItemRare", "itemRare" .. rare)
end


function GetItemTexture(id)
    return LuaMgr.GetTexture(string.format("Images/ItemIcons/itemicon_%s.png", id));
end


function GetItemHomeIcon(id)
    return LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/ItemIcons/itemicon_home_%s.png", id));
end


function GetCharacterTexture(characterId, skinId)
    return LuaMgr.GetTexture(string.format("Assets/_BundleResources/Character/%s/Avatar/%s.png", characterId, skinId));
end


function GetRhythmEquipTexture(id)
    return LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/MusicEquipIcon/%s.png", id));
end

function SetActive(gameObject, value)
    if (IsObjectNull(gameObject)) then return end
    if (gameObject.activeSelf ~= value) then
        gameObject:SetActive(value);
    end
end




function Split(szFullString, szSeparator)
  local nFindStartIndex = 1
  local nSplitIndex = 1
  local nSplitArray = {}
  while true do
    local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex,true)
    if not nFindLastIndex then
      nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
      break
    end
    nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
    nFindStartIndex = nFindLastIndex + string.len(szSeparator)
    nSplitIndex = nSplitIndex + 1
  end
  return nSplitArray
end



function GetTimeHMS(time)
    local seconds = time % 60;
    local minute = math.floor((time % 3600) / 60);
    local hour = math.floor(time / 3600);
    hour = hour < 10 and "0" .. hour or tostring(hour);
    minute = minute < 10 and "0" .. minute or tostring(minute);
    seconds = seconds < 10 and "0" .. seconds or tostring(seconds);
    return hour, minute, seconds;
end


function GetTimeDHM(time)
    local seconds = time % 60;
    time = seconds > 0 and time + 60 or time;
    local minute = math.floor((time % 3600) / 60);
    local hour = math.floor((time % 86400) / 3600);
    local day = math.floor(time / 86400);
    day = day <= 0 and "" or tostring(day);
    hour = hour < 10 and "0" .. hour or tostring(hour);
    minute = minute < 10 and "0" .. minute or tostring(minute);
    return day, hour, minute;
end


function GetTimeDHMS(time)
    local seconds = time % 60;
    time = seconds > 0 and time + 60 or time;
    local minute = math.floor((time % 3600) / 60);
    local hour = math.floor((time % 86400) / 3600);
    local day = math.floor(time / 86400);
    day = day <= 0 and "" or tostring(day);
    hour = hour < 10 and "0" .. hour or tostring(hour);
    minute = minute < 10 and "0" .. minute or tostring(minute);
    return day, hour, minute, seconds
end


function GetTimeDay(time)
    local seconds = time % 60;
    time = seconds > 0 and time + 60 or time;
    local minute = math.floor((time % 3600) / 60);
    local hour = math.floor((time % 86400) / 3600);
    local day = math.floor(time / 86400);
    if (minute > 0 or hour > 0) then
        day = day + 1;
    end
    return day;
end


function GetTimeDHM2(time)
    local seconds = time % 60;
    time = seconds > 0 and time + 60 or time;
    local minute = math.floor((time % 3600) / 60);
    local hour = math.floor((time % 86400) / 3600);
    local day = math.floor(time / 86400);
    return day, hour, minute;
end


function GetTimeHMS2(time)
    local seconds = time % 60;
    local minute = math.floor((time % 3600) / 60);
    local hour = math.floor(time / 3600);  
    return hour, minute, seconds;
end


function GetTimeDHMS2(time)
    local seconds = time % 60;   
    local minute = math.floor((time % 3600) / 60);
    local hour = math.floor((time % 86400) / 3600);
    local day = math.floor(time / 86400);   
    return day, hour, minute, seconds
end



function TimeString(time)
    local seconds = time % 60;
    time = seconds > 0 and time + 60 or time;
    local minute = math.floor((time % 3600) / 60);
    local hour = math.floor((time % 86400) / 3600);
    local day = math.floor(time / 86400);
    day = day <= 0 and "" or tostring(day);
    hour = hour < 10 and "0" .. hour or tostring(hour);
    minute = minute < 10 and "0" .. minute or tostring(minute);
    
    local str=""
    if day~="" then
        str=string.format(ConfigMgr.LangGlobal("10205"),day,hour);
    else
        str=string.format(ConfigMgr.LangGlobal("10206"),hour,minute);
    end
    return str;
end



function string.starts(String,Start)
    return string.sub(String,1,string.len(Start))==Start
 end
 
function string.ends(String,End)
    return End=='' or string.sub(String,-string.len(End))==End
 end

function string.UpperFirst(str)
   return string.upper(string.sub(str,1,1))..string.sub(str,2);
end


function Shuffle(maxIndex)
    math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 7)));
    local result={};
    for i = 1, maxIndex, 1 do
        table.insert(result,i);
    end
    local index=0;
    local temp=nil;
    for i = maxIndex, 1, -1 do
        index = math.random(i)
        temp = result[i];
        result[i] = result[index];
        result[index] = temp;
    end
    return result;
 end


function ShuffleTable(t)
    math.randomseed(os.time())
    local len = #t
    for i = len, 2, -1 do
        local j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
    return t
end


 function RamdomOnWeight(stringToWeight)
    math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 7)));
    local list={};
    local allWeight=0;
    for key, value in pairs(stringToWeight) do
        table.insert(list,key);
        allWeight=allWeight+value;
    end
    local randomIndex=math.random(allWeight)-1;
    local nowWeight=0;
    for i = 1, #list, 1 do
        nowWeight=nowWeight+stringToWeight[list[i]];
        if nowWeight>randomIndex then
            return list[i];
        end
    end
    return nil;
 end

 function Clamp(num,minValue,maxValue)
    if num<minValue then
        return minValue;
    elseif num>maxValue then
        return maxValue;
    else
        return num;
    end
 end


StartsWith = function(str, fstr)
    local i,l = string.find(str, fstr);
    local len = string.len(fstr);
    return i == 1 and l == len;
end


function FileExists(path)
    local file = io.open(path,"r")
    if file then
        io.close(file)
        return true
    else
        return false
    end
end


function hexToRGB(hex)

    if hex:sub(1, 1) == "#" then
        hex = hex:sub(2)
    end

    local r = tonumber("0x" .. hex:sub(1, 2))
    local g = tonumber("0x" .. hex:sub(3, 4))
    local b = tonumber("0x" .. hex:sub(5, 6))

    return r, g, b
end


function GetDaysByMonth(year,month)
    local norYear={31,28,31,30,31,30,31,31,30,31,30,31}
    local ruiYear={31,29,31,30,31,30,31,31,30,31,30,31}
    if CheckRuiYear(year) then
        return ruiYear[month];
    else
        return norYear[month];
    end
end

function CheckRuiYear(year)
    return year%400==0 or (year%4==0 and year%100~=0)
end

function VectorToTable(v)
    return {x = v.x, y = v.y, z = v.z}
end

function Get_TimeZone_OffSet()
    local local_time=os.time();
    local utc_time=os.time(os.date("!*t",now));
    local offset=os.difftime(local_time,utc_time);
    return offset;
end

function Get_Beijing_Time(timestamp)
    local newTimestamp = os.time(os.date("!*t", timestamp)) +3600*8 + (os.date("*t", time).isdst and -1 or 0) * 3600
    local beijing_date = os.date("*t", newTimestamp)
    return beijing_date;
end


function BeijingTimeToTimeStamp(year,month,day,hour,min,sec)
    local now = os.time()
    local utcNow = os.time(os.date("!*t", now))
    local sysOffsetHour = (now - utcNow) / 3600

    local compensation = (8 - sysOffsetHour) * 3600

    local targetTime = os.time({
        year = year, month = month, day = day,
        hour = hour, min = min, sec = sec
    }) - compensation
    
    return targetTime
end

function GetInterval(inTargetHour)
    local curTime = LuaMgr.Timestamp()
    local now = os.date("*t", curTime)
    local targetHour = inTargetHour
    local isTargetInFuture = now.hour < targetHour
    local targetDay = now.day
    local targetMonth = now.month
    local targetYear = now.year
    if not isTargetInFuture then
        targetDay = targetDay + 1
        local daysInMonth = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
        if targetMonth == 2 and (targetYear % 4 == 0 and (targetYear % 100 ~= 0 or targetYear % 400 == 0)) then
            daysInMonth[2] = 29
        end
        if targetDay > daysInMonth[targetMonth] then
            targetDay = 1
            targetMonth = targetMonth + 1
            if targetMonth > 12 then
                targetMonth = 1
                targetYear = targetYear + 1
            end
        end
    end
    local target = {
        year = targetYear,
        month = targetMonth,
        day = targetDay,
        hour = targetHour,
        min = 0,
        sec = 0
    }
    local nowTimestamp = curTime
    local targetTimestamp = os.time(target)
    return targetTimestamp - nowTimestamp
end


function TimeToNext4AM()
    return GetInterval(4)
end

function RandomNum(startNum,endNum)
    math.randomseed(LuaMgr.Timestamp())
    return math.random(startNum,endNum)
end

function MatchPlayer(textStr)
    if string.match(textStr, "player") then
        textStr = string.gsub(textStr, "player", DataMgr.Player.name);
    end
    return textStr;
end

function HexToRGBA(hexColor)
    local cleanHex = string.gsub(hexColor, "#", "")
    local len = string.len(cleanHex)
    if len ~= 6 and len ~= 8 then
        LuaDebug.error("错误：无效的16进制颜色格式，需为6位(RGB)或8位(RGBA)")
        return UnityEngine.Color.white
    end
    local r = tonumber(string.sub(cleanHex, 1, 2), 16)
    local g = tonumber(string.sub(cleanHex, 3, 4), 16)
    local b = tonumber(string.sub(cleanHex, 5, 6), 16)
    local a = len == 8 and tonumber(string.sub(cleanHex, 7, 8), 16) or 255
    if not (r and g and b and a) then
        return UnityEngine.Color.white
    end
    return UnityEngine.Color(r / 255, g / 255, b / 255, a / 255)
end



local function utf8_sub(s, f, e)
    local idx = 1
    local ret = ""
    for p, c in utf8.codes(s) do
        if idx >= f and idx <= e then
            ret = ret .. utf8.char(c)
        end
        idx = idx + 1
    end
    return ret
end


function AutoLineBreak(text, maxPerLine)
    local total = 0
    for _ in utf8.codes(text) do
        total = total + 1
    end
    if total == 0 or maxPerLine <= 0 then
        return text
    end

    local lines = math.ceil(total / maxPerLine)
    local arr = {}
    if lines == 1 then
        table.insert(arr, total)
    else
        table.insert(arr, total - (lines - 1) * maxPerLine)
        for i = 2, lines do
            table.insert(arr, maxPerLine)
        end
    end

    local result = ""
    local pos = 1
    for i, n in ipairs(arr) do
        result = result .. utf8_sub(text, pos, pos + n - 1)
        if i < #arr then
            result = result .. "\n"
        end
        pos = pos + n
    end

    return result
end