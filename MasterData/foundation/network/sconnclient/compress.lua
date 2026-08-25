local function new_decompressor(compress_type)
  if "lz4" == compress_type then
    local lz4 = require("lz4")
    
    do return end
    return lz4.new_decompress_ctx
  else
    return nil
  end
end

local function new_compressor(compress_type)
  if "lz4" == compress_type then
    local lz4 = require("lz4")
    do return end
    return lz4.new_compress_ctx
  else
    return nil
  end
end

return {new_decompressor = new_decompressor, new_compressor = new_compressor}
