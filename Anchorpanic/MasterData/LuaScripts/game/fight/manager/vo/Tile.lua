tile = {
    __call = function(_, col, row)
        return setmetatable({ col = col or 0, row = row or 0}, tile)
    end,
    __tostring = function(v)
        return string.format("(col = %f,row = %f)",v.col,v.row)
    end,
    __add = function(v, u) return v:add(u, tile()) end,
    __sub = function(v, u) return v:sub(u, tile()) end,
    __eq = function(v, u) return v:equals(u) end,
    __index = {
        clone = function(v)
            return tile(v.col, v.row)
        end,

        copy = function(v,u)
            return v:set(u.col, u.row)
        end,

        set = function(v, col, row)
            v.col = col
            v.row = row
            return v
        end,
    
        add = function(v, u, out)
            out = out or v
            out.col = v.col + u.col
            out.row = v.row + u.row
            return out
        end,
    
        sub = function(v, u, out)
            out = out or v
            out.col = v.col - u.col
            out.row = v.row - u.row
            return out
        end,

        equals = function(self,v)
            return self.col == v.col and self.row == v.row
        end
    }
}

setmetatable(tile, tile)
return tile
 
--[[ 替换语言包自动生成，请勿修改！
]]
