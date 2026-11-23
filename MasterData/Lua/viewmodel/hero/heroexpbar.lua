HeroExpBar = {}

local _level
local _limitLevel
local _exp
local _maxExp
local _addExp
local _changeValue
local _changeRatio
local _targetLevel
local _addValue
local _isUpLevel
local _expCallback
local _getExpCallback
local _finishCallback

local CalcAddValue = function()
    if _level < _targetLevel then
        _addValue = math.ceil(_maxExp / _changeRatio)
    else
        _addValue = math.ceil(_maxExp / 30)
    end
end

local NextLevel = function()
    _isUpLevel = true
    if _level + 1 == _limitLevel then
        _exp = _changeValue
        _changeValue = 0
        return
    end
    _level = _level + 1
    _exp = 0
    _maxExp = _getExpCallback(_level, _exp)
    CalcAddValue()
end

HeroExpBar.OnUpdate = function()
    if _changeValue > 0 then
        if _exp < _maxExp then
            local temp = _changeValue > _addValue and _addValue or _changeValue
            local value = _exp + temp
            if value < _maxExp then
                _changeValue = _changeValue - temp
                _exp = value
            else
                _changeValue = _changeValue - (_maxExp - _exp)
                _exp = _maxExp
            end
        elseif _exp == _maxExp then
            NextLevel()
        end
        _expCallback(_level, _exp, _maxExp, _limitLevel, _isUpLevel)
    else
        if _exp == _maxExp then
            NextLevel()
            _expCallback(_level, _exp, _maxExp, _limitLevel, _isUpLevel)
        end
        LuaMgr.RemoveUpdate(HeroExpBar.OnUpdate)
        _finishCallback(_isUpLevel)
    end
end

function HeroExpBar.Init(level, limitLevel, exp, maxExp, changeRatio, expCallback, getExpCallback, finishCallback)
    HeroExpBar.Clear()
    _level = level
    _limitLevel = limitLevel
    _exp = exp
    _maxExp = maxExp
    _changeRatio = changeRatio
    _expCallback = expCallback
    _getExpCallback = getExpCallback
    _finishCallback = finishCallback
    _expCallback(level, exp, maxExp, limitLevel, _isUpLevel)
end

function HeroExpBar.SetExp(addExp, targetLevel)
    _targetLevel = targetLevel
    _changeValue = addExp - _addExp
    if _changeValue == 0 then
        return
    end

    _addExp = addExp
    CalcAddValue()
    LuaMgr.RemoveUpdate(HeroExpBar.OnUpdate);
    LuaMgr.AddUpdate(HeroExpBar.OnUpdate);
end

function HeroExpBar.Clear()
    _isUpLevel = false
    _addExp = 0;
    _changeValue = 0;
    _expCallback = nil;
    _getExpCallback = nil;
    LuaMgr.RemoveUpdate(HeroExpBar.OnUpdate);
end