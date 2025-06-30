module('ColorUtil', Class.impl())

-- 纯白
PURE_WHITE_NUM = "ffffffff"
-- 纯黑
PURE_BLACK_NUM = "000000ff"
--白色
WHITE_NUM = "FFFFFFFF"
--绿
GREEN_NUM = "09a485ff"
--蓝
BLUE_NUM = "478afdff"
--紫
PURPLE_NUM = "e15be1ff"
--橙
ORANGE_NUM = "fb9214ff"
--红
RED_NUM = "f12b2bff"
--黄
YELLOW_NUM = "fff25fff"
--黑色
BLACK_NUM = "1c1c1cff"
--灰色
GRAY_NUM = "595959ff"

--未改造
REM_NONE = "3f576fff"

--改造_绿
REM_GREEN_NUM = "0dcf91ff"
--改造_蓝
REM_BULE_NUM = "2198fcff"
--改造_紫
REM_PURPLE_NUM = "fd70efff"
--改造_橙
REM_ORANGE_NUM = "f8aa25ff"



-------bgColor
-- BG_GREEN = "284242ff"
-- BG_BLUE = "1f3361ff"
-- BG_PURPLE = "451e57ff"
-- BG_ORANGE = "562d10ff"

BG_GREEN = "179a86ff "
BG_BLUE = "2e8ef0ff "
BG_PURPLE = "e85bdaff "
BG_ORANGE = "ff9a27ff "
-------LineColor
LINE_GREEN = "45cea2ff"
LINE_BLUE = "5caafaff"
LINE_PURPLE = "f36ee6ff"
LINE_ORANGE = "ff9e35ff"





-- 获取道具名称颜色值
function getPropColor(self, cusColor)
    if (cusColor == ColorType.GREEN) then		--绿
        return self.GREEN_NUM
    elseif (cusColor == ColorType.BLUE) then	--蓝
        return self.BLUE_NUM
    elseif (cusColor == ColorType.VIOLET) then	--紫
        return self.PURPLE_NUM
    elseif (cusColor == ColorType.ORANGE) then	--橙
        return self.ORANGE_NUM
    elseif (cusColor == ColorType.RED) then		--红
        return self.RED_NUM
    else
        return self.BLACK_NUM
    end
end

function getPropBgColor(self, cusColor)
    if (cusColor == ColorType.GREEN) then		--绿
        return self.BG_GREEN
    elseif (cusColor == ColorType.BLUE) then	--蓝
        return self.BG_BLUE
    elseif (cusColor == ColorType.VIOLET) then	--紫
        return self.BG_PURPLE
    elseif (cusColor == ColorType.ORANGE) then	--橙
        return self.BG_ORANGE
    elseif (cusColor == ColorType.RED) then		--红
        return self.RED_NUM
    else
        return self.BLACK_NUM
    end
end

function getPropLineColor(self, cusColor)
    if (cusColor == ColorType.GREEN) then		--绿
        return self.LINE_GREEN
    elseif (cusColor == ColorType.BLUE) then	--蓝
        return self.LINE_BLUE
    elseif (cusColor == ColorType.VIOLET) then	--紫
        return self.LINE_PURPLE
    elseif (cusColor == ColorType.ORANGE) then	--橙
        return self.LINE_ORANGE
    elseif (cusColor == ColorType.RED) then		--红
        return self.RED_NUM
    else
        return self.BLACK_NUM
    end
end


function setGray(self, obj, beGray)
    if beGray then
        gs.MatUtil.UIToGray(obj, true);
    else
        gs.MatUtil.UIToEmptyMaterial(obj, true);
    end
end

function getRemakeColor(self, type)
    if (type == RemakeType.GREEN) then		--绿
        return self.REM_GREEN_NUM
    elseif (type == RemakeType.BLUE) then	--蓝
        return self.REM_BULE_NUM
    elseif (type == RemakeType.VIOLET) then	--紫
        return self.REM_PURPLE_NUM
    elseif (type == RemakeType.ORANGE) then	--橙
        return self.REM_ORANGE_NUM
    else
        return self.REM_NONE
    end
end

return _M