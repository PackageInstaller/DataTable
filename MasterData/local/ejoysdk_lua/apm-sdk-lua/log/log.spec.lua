local Log = require("ejoysdk_lua.apm-sdk-lua.log.init")
local Bucket = require("ejoysdk_lua.apm-sdk-lua.log.bucket.init")
local Time = require("ejoysdk_lua.apm-sdk-lua.common.time.init")
local Logger = require("ejoysdk_lua.apm-sdk-lua.log.logger")
local Vconfig = require("ejoysdk_lua.apm-sdk-lua.log.vconfig")
local Formatter = require("ejoysdk_lua.apm-sdk-lua.log.formatter")
describe("log", function()
  local buffer, saved_bucket
  before_each(function()
    local b = Bucket.new("buffer")
    buffer = b.buffer
    saved_bucket = Log.set_bucket(b)
  end)
  after_each(function()
    Log.set_bucket(saved_bucket)
  end)
  describe("logn", function()
    it("should log verbose info", function()
      Log.config({verbose = 3})
      log("{foobar}", "lol")
      assert.is.truthy(buffer:get_item(1).msg:find("foobar:lol"))
      log1("foobar1")
      assert.is.truthy(buffer:get_item(2).msg:find("foobar1"))
      log2("foobar2")
      assert.is.truthy(buffer:get_item(3).msg:find("foobar2"))
      log3("foobar3")
      assert.is.truthy(buffer:get_item(4).msg:find("foobar3"))
    end)
    it("should not log verose info", function()
      Log.config({verbose = 3})
      log4("foobar3")
      assert.is.equal(buffer:qsize(), 0)
      log3("foobar3")
      assert.is.equal(buffer:qsize(), 1)
    end)
    it("should return function", function()
      for cv = 1, Vconfig.max_level do
        for tv = 1, Vconfig.max_level do
          Log.config({verbose = cv})
          Log.V[tv].InfoS("{config_verbose} {test_verbose}", cv, tv)
          if Log.V(tv) then
            assert.is_truthy(tv <= cv)
          else
            assert.is_truthy(cv < tv)
          end
          if _G["log" .. tv] == Log.InfoS then
            assert.is_truthy(tv <= cv)
          else
            assert.is_truthy(cv < tv)
          end
        end
      end
    end)
  end)
  describe("log_bucket", function()
    it("should record every log", function()
      Log.config({verbose = 3})
      log("foo")
      log("bar")
      assert.is.equal(buffer:qsize(), 2)
    end)
  end)
  describe("log", function()
    it("should successful level log", function()
      local log = Logger.new()
      log:config({product = true})
      log:Info("Info")
      log:Error("Error")
      log:Critical("Critical")
      log:Alert("Alert")
      log:Emerg("Emerg")
      log:Tag("tag", 1)
      log:Tag("dyn_tag", function()
        return "dyn"
      end)
      log:Info("with tag")
      log:Untag("tag")
      log:Untag("dyn_tag")
      log:Info("without tag")
      log:Debugf("%s %s", {a = 1}, {b = 2})
      log:Debug({a = 3})
      log:Infof("%s", {a = 3})
      log:Info({a = 3})
      log:Error("this is a error")
      log:ErrorS("this is a {error}", "what")
      log:Debugf("arg1 %s", {a = "a table"})
      log:DebugS("{arg1}", {a = "a table"})
      log:config({product = false})
      log:Debugf("arg1 %s", {a = "a table"})
      log:DebugS("{arg1}", {a = "a table"})
    end)
    it("should successful log table", function()
      local mt = {
        __tostring = function()
          return "TEST TABLE"
        end
      }
      local t = {
        "one",
        "two",
        "three"
      }
      t.key = "val"
      t.table = {
        mt,
        {mt},
        t
      }
      Log.Info(t)
      Log.Info(setmetatable(t, mt))
    end)
  end)
  describe("slog", function()
    local test_bucket = {
      formatter = Formatter.get_formatter("text", false)
    }
    setup(function()
      local function check_suffix(main_str, sub_str)
        local suff = string.sub(main_str, #main_str - #sub_str + 1)
        
        do return assert.is_truthy end
        return assert.is_truthy, suff == sub_str, #sub_str
      end
      
      function test_bucket:expect(expect)
        test_bucket.expect_msg = expect
      end
      
      function test_bucket:put(catalog, record)
        local msg = self.formatter(catalog, record)
        if test_bucket.expect_msg then
          assert.is_truthy(check_suffix(msg, test_bucket.expect_msg))
          test_bucket.expect_msg = nil
        end
        return true
      end
    end)
    it("should work", function()
      local log = Logger.new()
      Logger.set_bucket(test_bucket)
      local ts = Time.now()
      local test_case = {
        {
          "username:Efve test logging at time:" .. tostring(ts) .. ": arg1:nil arg2:false arg3:true arg4:2.333 arg5:2333",
          "{username} test logging at {time}: {arg1} {arg2} {arg3} {arg4} {arg5}",
          "Efve",
          ts,
          nil,
          false,
          true,
          2.333,
          2333
        },
        {
          "",
          "",
          "ohh"
        },
        {
          "arg1:1 arg2:2",
          "{arg1} {arg2}",
          1,
          2
        },
        {
          "arg1:a arg2:b",
          "{arg1} {arg2}",
          "a",
          "b"
        },
        {
          "arg1:a arg2:b",
          "{arg1} {arg2}",
          "a",
          "b",
          "c"
        },
        {
          "{arg1:a arg2:b}",
          "{{{arg1} {arg2}}}",
          "a",
          "b"
        },
        {
          "arg1:a {arg2:b} {not_arg}",
          "{arg1} {{{arg2}}} {{not_arg}}",
          "a",
          "b",
          "c"
        },
        {
          "{arg1:a arg2:b not_arg}",
          "{{{arg1} {arg2} not_arg}",
          "a",
          "b",
          "c"
        },
        {
          "{arg1:a arg2:b not_arg}",
          "{{{arg1} {arg2} not_arg}",
          "a",
          "b",
          "c"
        },
        {
          "{ arg1:a arg2:b} not_arg",
          "{ {arg1} {arg2}}} not_arg",
          "a",
          "b",
          "c"
        }
      }
      for _, case in ipairs(test_case) do
        test_bucket:expect(case[1])
        log:InfoS(table.unpack(case, 2))
      end
    end)
  end)
  describe("error", function()
    local function get_error(f, ...)
      local _, err = pcall(function(...)
        f(...)
      end, ...)
      return err
    end
    
    local function check_error_equal(f_a, f_b, ...)
      local err_a = get_error(f_a, ...)
      local err_b = get_error(f_b, ...)
      assert.is_equal(err_a, err_b)
    end
    
    it("should work", function()
      local error = raw_error or _ENV.error
      local assert = raw_assert or _ENV.assert
      check_error_equal(error, Log.SError)
      check_error_equal(error, Log.SError, "ERROR TEST")
      check_error_equal(error, Log.SError, "ERROR TEST -1", -1)
      check_error_equal(error, Log.SError, "ERROR TEST 0", 0)
      check_error_equal(error, Log.SError, "ERROR TEST 1", 1)
      check_error_equal(error, Log.SError, "ERROR TEST 2", 2)
      if raw_assert then
        check_error_equal(assert, Log.Assert, nil)
        check_error_equal(assert, Log.Assert, nil, "ASSERT TEST")
        check_error_equal(assert, Log.Assert, true)
        local pa, pb = {
          assert(1, 2, 3)
        }, {
          Log.Assert(1, 2, 3)
        }
        assert(table.concat(pa) == table.concat(pb))
      end
    end)
  end)
  describe("log_pcall", function()
    it("should work", function()
      local log = Logger.new()
      
      local function test(log_lv)
        log:add_pcall(pcall, log_lv)
        pcall(function()
          log:SError(log_lv)
        end)
      end
      
      test(log.ERROR)
      test(log.WARNING)
      test(log.DEBUG)
    end)
  end)
end)
