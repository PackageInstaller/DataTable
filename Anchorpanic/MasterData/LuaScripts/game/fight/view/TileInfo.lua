module('fight.TileInfo', Class.impl('lib.component.BaseContainer'))
UIRes = ''

function ctor(self)
    super.ctor(self)
end

-- 初始化
function configUI(self)
    -- self.m_btn = {}
    -- for i=1,fight.SceneUtil.COL_COUNT do
    --     self.m_btn[i] = {}
    --     for j=1,fight.SceneUtil.ROW_COUNT do
    --         local btn = AssetLoader.GetGO("Button.prefab")
    --         local trans = btn.transform;
    --         trans:SetParent(self:getParentTrans(), false)
    --         -- print(30 + 35 * i ,-80 + -35 * (j - 1))
    --         gs.TransQuick:LPosXY(trans,-100 - 35 * i ,300 + -35 * (j - 1),0)
    --         -- local gs
    --         -- local ts
    --         -- gs,ts = GoUtil.GetChildHash(btn)
    --         -- print(ts["Text"] ~= nil and "has text" or "text nil")
    --         -- ts["Text"].Text = "aaa"
    --         -- self.m_btn[i][j] = ts["Text"]
    --         self.m_btn[i][j] = btn
    --         local function onBtnClick()

    --             local inner
    --             if fight.SceneManager.gTileArr[i-1] ~= nil then
    --                 inner = fight.SceneManager.gTileArr[i-1][j-1]
    --             end

    --             local booker 
                
    --             if fight.SceneManager.gBookArr[i-1] ~= nil then
    --                 booker = fight.SceneManager.gBookArr[i-1][j-1]
    --             end

    --             print(inner,booker)
    --         end
    --         self:addOnClick(btn, onBtnClick)
    --     end
    -- end

    -- LoopManager:addFrame(1,0,self,self.step)

    local btn = AssetLoader.GetGO("Button.prefab")
    local trans = btn.transform;
    trans:SetParent(self:getParentTrans(), false)
    gs.TransQuick:LPosXY(trans,100,100)

    local function onBtnClick()

        for k,v in pairs(fight.SceneManager:getAllThing()) do
            print(k,v:tile())
        end

    end
    self:addOnClick(btn, onBtnClick)
end

function step( self )
    for i=1,fight.SceneUtil.COL_COUNT do
        for j=1,fight.SceneUtil.ROW_COUNT do
            local btn = self.m_btn[i][j]
            btn:SetActive(fight.SceneManager:isEmptyTile({col=i-1,row=j-1}));
        end
    end
end

-- 设置父容器
function getParentTrans(self)
    return GameView.mainUI
end
return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
