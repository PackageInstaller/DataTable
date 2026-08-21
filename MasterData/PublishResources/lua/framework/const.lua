_G.SECOND = 1000
_G.MINUTE = 60 * SECOND
_G.HOUR = 60 * MINUTE
_G.DAY = 24 * HOUR

function _G.FUNCTION()
end

_G.FUNCTIONTABLE = setmetatable({}, {
  __index = function(t, k)
    return FUNCTION
  end,
  __newindex = function(t, k, v)
    error("readonly!")
  end
})
