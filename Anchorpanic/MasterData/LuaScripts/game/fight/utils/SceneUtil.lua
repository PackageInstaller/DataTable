module("fight.SceneUtil", package.seeall)
--格子宽高
TILE_SIZE = 0.2;
COL_COUNT = 180;
ROW_COUNT = 80;
HALF_COL_COUNT = COL_COUNT*0.5
HALF_ROW_COUNT = ROW_COUNT*0.5
-- 固定高度
FIX_HEIGH = 0
-- 起始中心点
CENTER_POS = {0,0}
-- local offsetY = 0
-- ATT_POS = {
-- 	fight.Tile(80,25+offsetY),
-- 	fight.Tile(80,15+offsetY),
-- 	fight.Tile(60,30+offsetY),
-- 	fight.Tile(60,20+offsetY),
-- 	fight.Tile(60,10+offsetY),
-- };
-- DEF_POS = {
-- 	fight.Tile(COL_COUNT-80,25+offsetY),
-- 	fight.Tile(COL_COUNT-80,15+offsetY),
-- 	fight.Tile(COL_COUNT-60,30+offsetY),
-- 	fight.Tile(COL_COUNT-60,20+offsetY),
-- 	fight.Tile(COL_COUNT-60,10+offsetY),
-- };

local offsetRow = 0
local COL_START1 = HALF_COL_COUNT-10
local COL_START2 = HALF_COL_COUNT-20

local ROW_START1 = HALF_ROW_COUNT-10+offsetRow
local ROW_START2 = HALF_ROW_COUNT-5+offsetRow
local ROW_START3 = HALF_ROW_COUNT+offsetRow
local ROW_START4 = HALF_ROW_COUNT+5+offsetRow
local ROW_START5 = HALF_ROW_COUNT+10+offsetRow

ATT_POS = {
	fight.Tile(COL_START1,ROW_START4),
	fight.Tile(COL_START1,ROW_START2),
	fight.Tile(COL_START2,ROW_START5),
	fight.Tile(COL_START2,ROW_START3),
	fight.Tile(COL_START2,ROW_START1),
};
DEF_POS = {
	fight.Tile(COL_COUNT-COL_START1-1,ROW_START4),
	fight.Tile(COL_COUNT-COL_START1-1,ROW_START2),
	fight.Tile(COL_COUNT-COL_START2-1,ROW_START5),
	fight.Tile(COL_COUNT-COL_START2-1,ROW_START3),
	fight.Tile(COL_COUNT-COL_START2-1,ROW_START1),
};

ROUND_DIR = {
	UP = {0,-1},
	DOWN = {0,1},
	LEFT = {-1,0},
	RIGHT = {1,0},
}

VERTEX = {
	xy1 = {0,0},
	xy2 = {0,0},
	xy3 = {0,0},
	xy4 = {0,0}
}
-- centerX,centerY 起始中心点
-- height 场景物放置高度
-- col row 格的行列数
-- tileSize 每格的大小
function setData( centerX, centerY, height, col, row, tileSize )
	CENTER_POS[1] = centerX
	CENTER_POS[2] = centerY
	FIX_HEIGH = height
	COL_COUNT = col
	ROW_COUNT = row
	HALF_COL_COUNT = COL_COUNT*0.5
	HALF_ROW_COUNT = ROW_COUNT*0.5
	TILE_SIZE = tileSize

	setVertex(centerX-HALF_COL_COUNT*tileSize,centerY-HALF_ROW_COUNT*tileSize,
				centerX-HALF_COL_COUNT*tileSize,centerY+HALF_ROW_COUNT*tileSize,
				centerX+HALF_COL_COUNT*tileSize,centerY+HALF_ROW_COUNT*tileSize,
				centerX+HALF_COL_COUNT*tileSize,centerY-HALF_ROW_COUNT*tileSize)
	setupTile()
end

function setupTile( )
	local COL_START1 = HALF_COL_COUNT-10
	local COL_START2 = HALF_COL_COUNT-20

	local ROW_START1 = HALF_ROW_COUNT-10+offsetRow
	local ROW_START2 = HALF_ROW_COUNT-5+offsetRow
	local ROW_START3 = HALF_ROW_COUNT+offsetRow
	local ROW_START4 = HALF_ROW_COUNT+5+offsetRow
	local ROW_START5 = HALF_ROW_COUNT+10+offsetRow
	ATT_POS = {
		fight.Tile(COL_START1,ROW_START4),
		fight.Tile(COL_START1,ROW_START2),
		fight.Tile(COL_START2,ROW_START5),
		fight.Tile(COL_START2,ROW_START3),
		fight.Tile(COL_START2,ROW_START1),
	};
	DEF_POS = {
		fight.Tile(COL_COUNT-COL_START1-1,ROW_START4),
		fight.Tile(COL_COUNT-COL_START1-1,ROW_START2),
		fight.Tile(COL_COUNT-COL_START2-1,ROW_START5),
		fight.Tile(COL_COUNT-COL_START2-1,ROW_START3),
		fight.Tile(COL_COUNT-COL_START2-1,ROW_START1),
	};
end
-- 获取高度
function getFixHeight()
	return FIX_HEIGH
end

-- 设置界限的四个顶点坐标
function setVertex(x1,y1, x2,y2, x3,y3, x4,y4)
	VERTEX.xy1 = {x1, y1}
	VERTEX.xy2 = {x2, y2}
	VERTEX.xy3 = {x3, y3}
	VERTEX.xy4 = {x4, y4}
end

function tileToPosition(cusTile)
	local x = CENTER_POS[1]+TILE_SIZE * (cusTile.col+0.5 - HALF_COL_COUNT);
	local z = CENTER_POS[2]+TILE_SIZE * (cusTile.row+0.5 - HALF_ROW_COUNT);
	-- print("tileToPosition", FIX_HEIGH, cusTile, x, z)
	return math.Vector3(x,FIX_HEIGH,z) ;
end

function positionToTile(cusPos)
	local x = cusPos.x-CENTER_POS[1]
	local z = cusPos.z-CENTER_POS[2]
	-- local col = math.floor(x / TILE_SIZE)
	-- local row = math.floor(z / TILE_SIZE)
	local col = math.floor(x / TILE_SIZE + HALF_COL_COUNT);
	local row = math.floor(z / TILE_SIZE + HALF_ROW_COUNT);
	return fight.Tile(col,row)
end


-- 判断格是否在合法范围
function isFeasibleTitle(col, row)
	return math.isInRect(col, row, VERTEX.xy1[1],VERTEX.xy1[2], VERTEX.xy2[1],VERTEX.xy2[2], VERTEX.xy3[1],VERTEX.xy3[2], VERTEX.xy4[1],VERTEX.xy4[2])
end
-- 判断点是否在合法范围
function isFeasiblePosition(cusPos)
	local title = positionToTile(cusPos)
	return isFeasibleTitle(title.col, title.row)
end

-- 如果endTitle超出范围 则获取边界点
function boundaryTitle(startTitle, endTitle)
	local x, y = math.pointLineRectangular(startTitle.col, startTitle.row, endTitle.col, endTitle.row, VERTEX.xy1[1],VERTEX.xy1[2], VERTEX.xy2[1],VERTEX.xy2[2], VERTEX.xy3[1],VERTEX.xy3[2])
	if x then
		endTitle.col = x
		endTitle.row = y
	end
	return endTitle
end

-- 固定位置和livethingvo做判断
function inRangeByPos2Vo(cusStartPos,cusTargetVo,cusTileDis)
	return inRangeByTile(positionToTile(cusStartPos),cusTargetVo:tile(),cusTileDis+cusTargetVo:volume())
end

function inRangeByVo(cusChecker,cusTarget,cusTileDis)
	return inRangeByTile(positionToTile(cusChecker.position),positionToTile(cusTarget.position),cusTileDis+cusChecker:volume() + cusTarget:volume())
end

function inRangeByPos(cusStartPos,cusTargetPos,cusTileDis)
	return inRangeByTile(positionToTile(cusStartPos),positionToTile(cusTargetPos),cusTileDis)
end

--只以格子为基准做判断
function inRangeByTile(cusStartTile,cusTargetTile,cusTileDis)
	-- print("inRangeByTile", cusStartTile,cusTargetTile,cusTileDis)
	return math.abs(cusStartTile.col - cusTargetTile.col) <= cusTileDis and math.abs(cusStartTile.row - cusTargetTile.row) <= cusTileDis
end
--使用livethingVo做判断
function inRange(cusVo,cusVo2,cusTileDis)
	return inRangeByTile(cusVo:tile(),cusVo2:tile(),cusTileDis+cusVo:volume()+cusVo2:volume())
end

function removeRangeTargetTile(cusChecker, cusTarget, cusTileDis,cusTryMoreDis)
	cusTryMoreDis = cusTryMoreDis or 2;
	for i=0,cusTryMoreDis do
		local tile = __tryToFindTile(cusChecker,cusTarget,cusTileDis + i);
		if tile ~= nil then
			return tile;
		end
	end
	return nil;
end

function __tryToFindTile(cusChecker, cusTarget, cusTileDis)

	local cusStartTile = cusChecker:tile()
	if inRange(cusChecker, cusTarget, cusTileDis) then
		return cusStartTile;
	end
	local cusCheckerId = cusChecker.id
	local cusTargetTile = cusTarget:tile();

	cusTileDis = cusTileDis + cusChecker:volume() + cusTarget:volume()
	local dirCol = cusStartTile.col - cusTargetTile.col;
	local dirRow = cusStartTile.row - cusTargetTile.row;

	local startCol;
	local startRow;
	if math.abs( dirCol ) > cusTileDis and math.abs( dirRow ) > cusTileDis then
		startCol = cusTargetTile.col + cusTileDis * (dirCol > 0 and 1 or -1);
		startRow = cusTargetTile.row + cusTileDis * (dirRow > 0 and 1 or -1);
	elseif math.abs( dirCol ) > cusTileDis then
		startCol = cusTargetTile.col + cusTileDis * (dirCol > 0 and 1 or -1);
		startRow = cusStartTile.row ;
	else
		startCol = cusStartTile.col;
		startRow = cusTargetTile.row + cusTileDis * (dirRow > 0 and 1 or -1);
	end
	if fight.SceneManager:isEmptyTile(fight.Tile(startCol,startRow),cusCheckerId) then
		return fight.Tile(startCol,startRow);
	end

	local round;
	local checkArr = {};
	if startCol == cusTargetTile.col - cusTileDis then
		round = {ROUND_DIR.UP,ROUND_DIR.RIGHT,ROUND_DIR.DOWN,ROUND_DIR.LEFT,ROUND_DIR.UP};
	elseif startRow == cusTargetTile.row - cusTileDis then
		round = {ROUND_DIR.RIGHT,ROUND_DIR.DOWN,ROUND_DIR.LEFT,ROUND_DIR.UP,ROUND_DIR.RIGHT};
	elseif startCol == cusTargetTile.col + cusTileDis then
		round = {ROUND_DIR.DOWN,ROUND_DIR.LEFT,ROUND_DIR.UP,ROUND_DIR.RIGHT,ROUND_DIR.DOWN};
	else
		round = {ROUND_DIR.LEFT,ROUND_DIR.UP,ROUND_DIR.RIGHT,ROUND_DIR.DOWN,ROUND_DIR.LEFT};
	end
	
	local rCol = startCol;
	local rRow = startRow;
	while (true) do
	
		local tCol = rCol + round[1][1];
		local tRow = rRow + round[1][2];
		if math.abs( tCol - cusTargetTile.col ) <= cusTileDis and math.abs( tRow - cusTargetTile.row ) <= cusTileDis then 
			if tCol == startCol and tRow == startRow then
				break;
			else
				table.insert( checkArr, fight.Tile(tCol,tRow));
				rCol = tCol;
				rRow = tRow;
			end
		else
			table.remove( round, 1 )
		end
	end

	local len = #checkArr
	local max = math.ceil( len / 2 );
	for i=1,max do
		local tile = checkArr[i];
		if fight.SceneManager:isEmptyTile(tile,cusCheckerId) then
			return tile;
		end
		if (len - i + 1) ~= i then
			tile = checkArr[len - i + 1];
			if fight.SceneManager:isEmptyTile(tile,cusCheckerId) then
				return tile;
			end
		end
	end

	return nil;
end

function inTileCenter(cusPos)
	return (cusPos.x - TILE_SIZE * 0.5) % TILE_SIZE == 0 and (cusPos.z - TILE_SIZE * 0.5) % TILE_SIZE == 0
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
