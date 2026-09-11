return {
	Play104021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 104021001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play104021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_2 = "B08c"

			if arg_1_1.bgs_.B08c == nil then
				local var_4_3 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_2)
				var_4_3.name = var_4_2
				var_4_3.transform.parent = arg_1_1.stage_.transform
				var_4_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_2] = var_4_3
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.B08c:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueB08c = var_4_4.color.a
					arg_1_1.var_.alphaMatValueB08c = var_4_4
				end

				arg_1_1.var_.alphaOldValueB08c = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueB08c then
					arg_1_1.var_.alphaMatValueB08c.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueB08c, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueB08c.color = arg_1_1.var_.alphaMatValueB08c.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueB08c then
				arg_1_1.var_.alphaMatValueB08c.color.a = 1
				arg_1_1.var_.alphaMatValueB08c.color = arg_1_1.var_.alphaMatValueB08c.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_6 = arg_1_1.bgs_.B08c

				arg_1_1.bgs_.B08c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_7 = var_4_6:GetComponent("SpriteRenderer")

				if var_4_7 and var_4_7.sprite then
					local var_4_8 = 2 * (var_4_6.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_6.transform.localScale = Vector3.New(var_4_8 / var_4_7.sprite.bounds.size.y < var_4_8 * manager.ui.mainCameraCom_.aspect / var_4_7.sprite.bounds.size.x and var_4_8 * manager.ui.mainCameraCom_.aspect / var_4_7.sprite.bounds.size.x or var_4_8 / var_4_7.sprite.bounds.size.y, var_4_8 / var_4_7.sprite.bounds.size.y < var_4_8 * manager.ui.mainCameraCom_.aspect / var_4_7.sprite.bounds.size.x and var_4_8 * manager.ui.mainCameraCom_.aspect / var_4_7.sprite.bounds.size.x or var_4_8 / var_4_7.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B08c" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_9 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_9 + 2 and arg_1_1.time_ < var_4_9 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_10 = 2
			local var_4_11 = 0.45

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_12 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_12:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_13 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(104021001).content)

				arg_1_1.text_.text = var_4_13

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_15 = 18 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_13) / 18)

				if (18 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_13) / 18)) > 0 and var_4_11 < var_4_15 then
					arg_1_1.talkMaxDuration = var_4_15
					var_4_10 = var_4_10 + 0.3

					if var_4_15 + var_4_10 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_15 + var_4_10
					end
				end

				arg_1_1.text_.text = var_4_13
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_16 = var_4_10 + 0.3
			local var_4_17 = math.max(var_4_11, arg_1_1.talkMaxDuration)

			if var_4_10 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_16) / var_4_17

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play104021002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 104021002
		arg_7_1.duration_ = 12.6

		local var_7_0 = {
			ja = 8.8,
			ko = 9.5,
			zh = 12.6,
			en = 8.2
		}
		local var_7_1 = manager.audio:GetLocalizationFlag()

		if var_7_0[var_7_1] ~= nil then
			arg_7_1.duration_ = var_7_0[var_7_1]
		end

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play104021003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0.65

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, true)
				arg_7_1.iconController_:SetSelectedState("hero")

				arg_7_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1013")

				arg_7_1.callingController_:SetSelectedState("normal")

				arg_7_1.keyicon_.color = Color.New(1, 1, 1)
				arg_7_1.icon_.color = Color.New(1, 1, 1)

				local var_10_1 = arg_7_1:GetWordFromCfg(104021002)
				local var_10_2 = arg_7_1:FormatText(var_10_1.content)

				arg_7_1.text_.text = var_10_2

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_4 = 25 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_2) / 25)

				if (25 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_2) / 25)) > 0 and var_10_0 < var_10_4 then
					arg_7_1.talkMaxDuration = var_10_4

					if var_10_4 + 0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_4 + 0
					end
				end

				arg_7_1.text_.text = var_10_2
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021002", "story_v_out_104021.awb") ~= 0 then
					local var_10_5 = manager.audio:GetVoiceLength("story_v_out_104021", "104021002", "story_v_out_104021.awb") / 1000

					if var_10_5 + 0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_5 + 0
					end

					if var_10_1.prefab_name ~= "" and arg_7_1.actors_[var_10_1.prefab_name] ~= nil then
						local var_10_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_1.prefab_name].transform, "story_v_out_104021", "104021002", "story_v_out_104021.awb")

						arg_7_1:RecordAudio("104021002", var_10_6)
						arg_7_1:RecordAudio("104021002", var_10_6)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_104021", "104021002", "story_v_out_104021.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_104021", "104021002", "story_v_out_104021.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_7 = math.max(var_10_0, arg_7_1.talkMaxDuration)

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_7 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - 0) / var_10_7

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= 0 + var_10_7 and arg_7_1.time_ < 0 + var_10_7 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play104021003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 104021003
		arg_11_1.duration_ = 9.23

		local var_11_0 = {
			ja = 9.233,
			ko = 3.833,
			zh = 9.033,
			en = 4.233
		}
		local var_11_1 = manager.audio:GetLocalizationFlag()

		if var_11_0[var_11_1] ~= nil then
			arg_11_1.duration_ = var_11_0[var_11_1]
		end

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play104021005(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0.625

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, true)
				arg_11_1.iconController_:SetSelectedState("hero")

				arg_11_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1013")

				arg_11_1.callingController_:SetSelectedState("normal")

				arg_11_1.keyicon_.color = Color.New(1, 1, 1)
				arg_11_1.icon_.color = Color.New(1, 1, 1)

				local var_14_1 = arg_11_1:GetWordFromCfg(104021003)
				local var_14_2 = arg_11_1:FormatText(var_14_1.content)

				arg_11_1.text_.text = var_14_2

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_4 = 25 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_2) / 25)

				if (25 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_2) / 25)) > 0 and var_14_0 < var_14_4 then
					arg_11_1.talkMaxDuration = var_14_4

					if var_14_4 + 0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_4 + 0
					end
				end

				arg_11_1.text_.text = var_14_2
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021003", "story_v_out_104021.awb") ~= 0 then
					local var_14_5 = manager.audio:GetVoiceLength("story_v_out_104021", "104021003", "story_v_out_104021.awb") / 1000

					if var_14_5 + 0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_5 + 0
					end

					if var_14_1.prefab_name ~= "" and arg_11_1.actors_[var_14_1.prefab_name] ~= nil then
						local var_14_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_1.prefab_name].transform, "story_v_out_104021", "104021003", "story_v_out_104021.awb")

						arg_11_1:RecordAudio("104021003", var_14_6)
						arg_11_1:RecordAudio("104021003", var_14_6)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_104021", "104021003", "story_v_out_104021.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_104021", "104021003", "story_v_out_104021.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_7 = math.max(var_14_0, arg_11_1.talkMaxDuration)

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_7 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - 0) / var_14_7

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= 0 + var_14_7 and arg_11_1.time_ < 0 + var_14_7 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play104021005 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 104021005
		arg_15_1.duration_ = 4.9

		local var_15_0 = {
			ja = 2.233,
			ko = 2.333,
			zh = 4.9,
			en = 3.833
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play104021006(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0.175

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1013")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_1 = arg_15_1:GetWordFromCfg(104021005)
				local var_18_2 = arg_15_1:FormatText(var_18_1.content)

				arg_15_1.text_.text = var_18_2

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_4 = 7 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_2) / 7)

				if (7 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_2) / 7)) > 0 and var_18_0 < var_18_4 then
					arg_15_1.talkMaxDuration = var_18_4

					if var_18_4 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_4 + 0
					end
				end

				arg_15_1.text_.text = var_18_2
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021005", "story_v_out_104021.awb") ~= 0 then
					local var_18_5 = manager.audio:GetVoiceLength("story_v_out_104021", "104021005", "story_v_out_104021.awb") / 1000

					if var_18_5 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_5 + 0
					end

					if var_18_1.prefab_name ~= "" and arg_15_1.actors_[var_18_1.prefab_name] ~= nil then
						local var_18_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_1.prefab_name].transform, "story_v_out_104021", "104021005", "story_v_out_104021.awb")

						arg_15_1:RecordAudio("104021005", var_18_6)
						arg_15_1:RecordAudio("104021005", var_18_6)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_104021", "104021005", "story_v_out_104021.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_104021", "104021005", "story_v_out_104021.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_7 = math.max(var_18_0, arg_15_1.talkMaxDuration)

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_7 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - 0) / var_18_7

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= 0 + var_18_7 and arg_15_1.time_ < 0 + var_18_7 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play104021006 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 104021006
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play104021007(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0.85

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_1 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(104021006).content)

				arg_19_1.text_.text = var_22_1

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_3 = 33 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 33)

				if (33 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 33)) > 0 and var_22_0 < var_22_3 then
					arg_19_1.talkMaxDuration = var_22_3

					if var_22_3 + 0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_3 + 0
					end
				end

				arg_19_1.text_.text = var_22_1
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_4 = math.max(var_22_0, arg_19_1.talkMaxDuration)

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - 0) / var_22_4

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play104021007 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 104021007
		arg_23_1.duration_ = 4.77

		local var_23_0 = {
			ja = 4.766,
			ko = 4.033,
			zh = 3.4,
			en = 4.3
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play104021008(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if arg_23_1.actors_["10002ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10002ui_story"))) then
				local var_26_0 = Object.Instantiate(Asset.Load("Char/" .. "10002ui_story"), arg_23_1.stage_.transform)

				var_26_0.name = "10002ui_story"
				var_26_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.actors_["10002ui_story"] = var_26_0

				local var_26_1 = var_26_0:GetComponentInChildren(typeof(CharacterEffect))

				var_26_1.enabled = true

				local var_26_2 = GameObjectTools.GetOrAddComponent(var_26_0, typeof(DynamicBoneHelper))

				if var_26_2 then
					var_26_2:EnableDynamicBone(false)
				end

				arg_23_1:ShowWeapon(var_26_1.transform, false)

				arg_23_1.var_["10002ui_story" .. "Animator"] = var_26_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_23_1.var_["10002ui_story" .. "Animator"].applyRootMotion = true
				arg_23_1.var_["10002ui_story" .. "LipSync"] = var_26_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_26_3 = arg_23_1.actors_["10002ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_3) and arg_23_1.var_.characterEffect10002ui_story == nil then
				arg_23_1.var_.characterEffect10002ui_story = var_26_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_4 = 0.1

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 and not isNil(var_26_3) then
				if arg_23_1.var_.characterEffect10002ui_story and not isNil(var_26_3) then
					arg_23_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 and not isNil(var_26_3) and arg_23_1.var_.characterEffect10002ui_story then
				arg_23_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_26_6 = arg_23_1.actors_["10002ui_story"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos10002ui_story = var_26_6.localPosition
			end

			local var_26_7 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_7 then
				var_26_6.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos10002ui_story, Vector3.New(0, -1.2, -5.8), (arg_23_1.time_ - 0) / var_26_7)
				var_26_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_6.position).x, (manager.ui.mainCamera.transform.position - var_26_6.position).y, (manager.ui.mainCamera.transform.position - var_26_6.position).z)
				var_26_6.localEulerAngles.z = 0
				var_26_6.localEulerAngles.x = 0
				var_26_6.localEulerAngles = var_26_6.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_7 and arg_23_1.time_ < 0 + var_26_7 + arg_26_0 then
				var_26_6.localPosition = Vector3.New(0, -1.2, -5.8)
				var_26_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_6.position).x, (manager.ui.mainCamera.transform.position - var_26_6.position).y, (manager.ui.mainCamera.transform.position - var_26_6.position).z)
				var_26_6.localEulerAngles.z = 0
				var_26_6.localEulerAngles.x = 0
				var_26_6.localEulerAngles = var_26_6.localEulerAngles
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_1")
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_26_8 = 0
			local var_26_9 = 0.375

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_8 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_10 = arg_23_1:GetWordFromCfg(104021007)
				local var_26_11 = arg_23_1:FormatText(var_26_10.content)

				arg_23_1.text_.text = var_26_11

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_13 = 15 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_11) / 15)

				if (15 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_11) / 15)) > 0 and var_26_9 < var_26_13 then
					arg_23_1.talkMaxDuration = var_26_13

					if var_26_13 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_13 + var_26_8
					end
				end

				arg_23_1.text_.text = var_26_11
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021007", "story_v_out_104021.awb") ~= 0 then
					local var_26_14 = manager.audio:GetVoiceLength("story_v_out_104021", "104021007", "story_v_out_104021.awb") / 1000

					if var_26_14 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_14 + var_26_8
					end

					if var_26_10.prefab_name ~= "" and arg_23_1.actors_[var_26_10.prefab_name] ~= nil then
						local var_26_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_10.prefab_name].transform, "story_v_out_104021", "104021007", "story_v_out_104021.awb")

						arg_23_1:RecordAudio("104021007", var_26_15)
						arg_23_1:RecordAudio("104021007", var_26_15)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_104021", "104021007", "story_v_out_104021.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_104021", "104021007", "story_v_out_104021.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_16 = math.max(var_26_9, arg_23_1.talkMaxDuration)

			if var_26_8 <= arg_23_1.time_ and arg_23_1.time_ < var_26_8 + var_26_16 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_8) / var_26_16

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_8 + var_26_16 and arg_23_1.time_ < var_26_8 + var_26_16 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play104021008 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 104021008
		arg_27_1.duration_ = 5.33

		local var_27_0 = {
			ja = 4.133,
			ko = 2.866,
			zh = 5.333,
			en = 4.3
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play104021009(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["10002ui_story"]) and arg_27_1.var_.characterEffect10002ui_story == nil then
				arg_27_1.var_.characterEffect10002ui_story = arg_27_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_0 = 0.1

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 and not isNil(arg_27_1.actors_["10002ui_story"]) then
				if arg_27_1.var_.characterEffect10002ui_story and not isNil(arg_27_1.actors_["10002ui_story"]) then
					arg_27_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_27_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_27_1.time_ - 0) / var_30_0)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 and not isNil(arg_27_1.actors_["10002ui_story"]) and arg_27_1.var_.characterEffect10002ui_story then
				arg_27_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_27_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_30_1 = arg_27_1.actors_["10002ui_story"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos10002ui_story = var_30_1.localPosition
			end

			local var_30_2 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_2 then
				var_30_1.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos10002ui_story, Vector3.New(0, 100, 0), (arg_27_1.time_ - 0) / var_30_2)
				var_30_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_1.position).x, (manager.ui.mainCamera.transform.position - var_30_1.position).y, (manager.ui.mainCamera.transform.position - var_30_1.position).z)
				var_30_1.localEulerAngles.z = 0
				var_30_1.localEulerAngles.x = 0
				var_30_1.localEulerAngles = var_30_1.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_2 and arg_27_1.time_ < 0 + var_30_2 + arg_30_0 then
				var_30_1.localPosition = Vector3.New(0, 100, 0)
				var_30_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_1.position).x, (manager.ui.mainCamera.transform.position - var_30_1.position).y, (manager.ui.mainCamera.transform.position - var_30_1.position).z)
				var_30_1.localEulerAngles.z = 0
				var_30_1.localEulerAngles.x = 0
				var_30_1.localEulerAngles = var_30_1.localEulerAngles
			end

			local var_30_3 = 0
			local var_30_4 = 0.25

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_3 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1013")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_5 = arg_27_1:GetWordFromCfg(104021008)
				local var_30_6 = arg_27_1:FormatText(var_30_5.content)

				arg_27_1.text_.text = var_30_6

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_8 = 10 <= 0 and var_30_4 or var_30_4 * (utf8.len(var_30_6) / 10)

				if (10 <= 0 and var_30_4 or var_30_4 * (utf8.len(var_30_6) / 10)) > 0 and var_30_4 < var_30_8 then
					arg_27_1.talkMaxDuration = var_30_8

					if var_30_8 + var_30_3 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_8 + var_30_3
					end
				end

				arg_27_1.text_.text = var_30_6
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021008", "story_v_out_104021.awb") ~= 0 then
					local var_30_9 = manager.audio:GetVoiceLength("story_v_out_104021", "104021008", "story_v_out_104021.awb") / 1000

					if var_30_9 + var_30_3 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_9 + var_30_3
					end

					if var_30_5.prefab_name ~= "" and arg_27_1.actors_[var_30_5.prefab_name] ~= nil then
						local var_30_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_5.prefab_name].transform, "story_v_out_104021", "104021008", "story_v_out_104021.awb")

						arg_27_1:RecordAudio("104021008", var_30_10)
						arg_27_1:RecordAudio("104021008", var_30_10)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_104021", "104021008", "story_v_out_104021.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_104021", "104021008", "story_v_out_104021.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_11 = math.max(var_30_4, arg_27_1.talkMaxDuration)

			if var_30_3 <= arg_27_1.time_ and arg_27_1.time_ < var_30_3 + var_30_11 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_3) / var_30_11

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_3 + var_30_11 and arg_27_1.time_ < var_30_3 + var_30_11 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play104021009 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 104021009
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play104021010(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:AudioAction("play", "music", "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin")

				local var_34_2 = manager.audio:GetAudioName("bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin")

				if "" ~= "" then
					if arg_31_1.bgmTxt_.text ~= var_34_2 and arg_31_1.bgmTxt_.text ~= "" then
						if arg_31_1.bgmTxt2_.text ~= "" then
							arg_31_1.bgmTxt_.text = arg_31_1.bgmTxt2_.text
						end

						arg_31_1.bgmTxt2_.text = var_34_2

						arg_31_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_31_1.bgmTxt_.text = var_34_2
						arg_31_1.bgmTxt2_.text = var_34_2
					end

					if arg_31_1.bgmTimer then
						arg_31_1.bgmTimer:Stop()

						arg_31_1.bgmTimer = nil
					end

					if arg_31_1.settingData.show_music_name == 1 then
						arg_31_1.musicController:SetSelectedState("show")
						arg_31_1.musicAnimator_:Play("open", 0, 0)

						if arg_31_1.settingData.music_time ~= 0 then
							arg_31_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_31_1.settingData.music_time), function()
								if arg_31_1 == nil or isNil(arg_31_1.bgmTxt_) then
									return
								end

								arg_31_1.musicController:SetSelectedState("hide")
								arg_31_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_34_3 = 0
			local var_34_4 = 0.55

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_3 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_5 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(104021009).content)

				arg_31_1.text_.text = var_34_5

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_7 = 22 <= 0 and var_34_4 or var_34_4 * (utf8.len(var_34_5) / 22)

				if (22 <= 0 and var_34_4 or var_34_4 * (utf8.len(var_34_5) / 22)) > 0 and var_34_4 < var_34_7 then
					arg_31_1.talkMaxDuration = var_34_7

					if var_34_7 + var_34_3 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_7 + var_34_3
					end
				end

				arg_31_1.text_.text = var_34_5
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_8 = math.max(var_34_4, arg_31_1.talkMaxDuration)

			if var_34_3 <= arg_31_1.time_ and arg_31_1.time_ < var_34_3 + var_34_8 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_3) / var_34_8

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_3 + var_34_8 and arg_31_1.time_ < var_34_3 + var_34_8 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play104021010 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 104021010
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play104021011(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.775

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_1 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(104021010).content)

				arg_36_1.text_.text = var_39_1

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_3 = 31 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_1) / 31)

				if (31 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_1) / 31)) > 0 and var_39_0 < var_39_3 then
					arg_36_1.talkMaxDuration = var_39_3

					if var_39_3 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_3 + 0
					end
				end

				arg_36_1.text_.text = var_39_1
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_4 = math.max(var_39_0, arg_36_1.talkMaxDuration)

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_4 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - 0) / var_39_4

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= 0 + var_39_4 and arg_36_1.time_ < 0 + var_39_4 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play104021011 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 104021011
		arg_40_1.duration_ = 9

		local var_40_0 = {
			ja = 5.566,
			ko = 5.566,
			zh = 6.3,
			en = 9
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play104021012(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["10002ui_story"]) and arg_40_1.var_.characterEffect10002ui_story == nil then
				arg_40_1.var_.characterEffect10002ui_story = arg_40_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.1

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["10002ui_story"]) then
				if arg_40_1.var_.characterEffect10002ui_story and not isNil(arg_40_1.actors_["10002ui_story"]) then
					arg_40_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["10002ui_story"]) and arg_40_1.var_.characterEffect10002ui_story then
				arg_40_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_43_2 = arg_40_1.actors_["10002ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos10002ui_story = var_43_2.localPosition
			end

			local var_43_3 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 then
				var_43_2.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10002ui_story, Vector3.New(-0.7, -1.2, -5.8), (arg_40_1.time_ - 0) / var_43_3)
				var_43_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_2.position).x, (manager.ui.mainCamera.transform.position - var_43_2.position).y, (manager.ui.mainCamera.transform.position - var_43_2.position).z)
				var_43_2.localEulerAngles.z = 0
				var_43_2.localEulerAngles.x = 0
				var_43_2.localEulerAngles = var_43_2.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 then
				var_43_2.localPosition = Vector3.New(-0.7, -1.2, -5.8)
				var_43_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_2.position).x, (manager.ui.mainCamera.transform.position - var_43_2.position).y, (manager.ui.mainCamera.transform.position - var_43_2.position).z)
				var_43_2.localEulerAngles.z = 0
				var_43_2.localEulerAngles.x = 0
				var_43_2.localEulerAngles = var_43_2.localEulerAngles
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action4_1")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_43_4 = 0
			local var_43_5 = 0.875

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_6 = arg_40_1:GetWordFromCfg(104021011)
				local var_43_7 = arg_40_1:FormatText(var_43_6.content)

				arg_40_1.text_.text = var_43_7

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 31 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 31)

				if (31 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 31)) > 0 and var_43_5 < var_43_9 then
					arg_40_1.talkMaxDuration = var_43_9

					if var_43_9 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_7
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021011", "story_v_out_104021.awb") ~= 0 then
					local var_43_10 = manager.audio:GetVoiceLength("story_v_out_104021", "104021011", "story_v_out_104021.awb") / 1000

					if var_43_10 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_4
					end

					if var_43_6.prefab_name ~= "" and arg_40_1.actors_[var_43_6.prefab_name] ~= nil then
						local var_43_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_6.prefab_name].transform, "story_v_out_104021", "104021011", "story_v_out_104021.awb")

						arg_40_1:RecordAudio("104021011", var_43_11)
						arg_40_1:RecordAudio("104021011", var_43_11)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_104021", "104021011", "story_v_out_104021.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_104021", "104021011", "story_v_out_104021.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_12 = math.max(var_43_5, arg_40_1.talkMaxDuration)

			if var_43_4 <= arg_40_1.time_ and arg_40_1.time_ < var_43_4 + var_43_12 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_4) / var_43_12

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_4 + var_43_12 and arg_40_1.time_ < var_43_4 + var_43_12 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play104021012 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 104021012
		arg_44_1.duration_ = 3.63

		local var_44_0 = {
			ja = 3.633,
			ko = 1.999999999999,
			zh = 2.533,
			en = 1.999999999999
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play104021013(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if arg_44_1.actors_["1013ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1013ui_story"))) then
				local var_47_0 = Object.Instantiate(Asset.Load("Char/" .. "1013ui_story"), arg_44_1.stage_.transform)

				var_47_0.name = "1013ui_story"
				var_47_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.actors_["1013ui_story"] = var_47_0

				local var_47_1 = var_47_0:GetComponentInChildren(typeof(CharacterEffect))

				var_47_1.enabled = true

				local var_47_2 = GameObjectTools.GetOrAddComponent(var_47_0, typeof(DynamicBoneHelper))

				if var_47_2 then
					var_47_2:EnableDynamicBone(false)
				end

				arg_44_1:ShowWeapon(var_47_1.transform, false)

				arg_44_1.var_["1013ui_story" .. "Animator"] = var_47_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_44_1.var_["1013ui_story" .. "Animator"].applyRootMotion = true
				arg_44_1.var_["1013ui_story" .. "LipSync"] = var_47_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_47_3 = arg_44_1.actors_["1013ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_3) and arg_44_1.var_.characterEffect1013ui_story == nil then
				arg_44_1.var_.characterEffect1013ui_story = var_47_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_4 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 and not isNil(var_47_3) then
				if arg_44_1.var_.characterEffect1013ui_story and not isNil(var_47_3) then
					arg_44_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 and not isNil(var_47_3) and arg_44_1.var_.characterEffect1013ui_story then
				arg_44_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_47_6 = arg_44_1.actors_["10002ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_6) and arg_44_1.var_.characterEffect10002ui_story == nil then
				arg_44_1.var_.characterEffect10002ui_story = var_47_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_7 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_7 and not isNil(var_47_6) then
				if arg_44_1.var_.characterEffect10002ui_story and not isNil(var_47_6) then
					arg_44_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_44_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_7)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_7 and arg_44_1.time_ < 0 + var_47_7 + arg_47_0 and not isNil(var_47_6) and arg_44_1.var_.characterEffect10002ui_story then
				arg_44_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_44_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_47_8 = arg_44_1.actors_["1013ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1013ui_story = var_47_8.localPosition
			end

			local var_47_9 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_9 then
				var_47_8.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1013ui_story, Vector3.New(0.7, -0.66, -6.15), (arg_44_1.time_ - 0) / var_47_9)
				var_47_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_8.position).x, (manager.ui.mainCamera.transform.position - var_47_8.position).y, (manager.ui.mainCamera.transform.position - var_47_8.position).z)
				var_47_8.localEulerAngles.z = 0
				var_47_8.localEulerAngles.x = 0
				var_47_8.localEulerAngles = var_47_8.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_9 and arg_44_1.time_ < 0 + var_47_9 + arg_47_0 then
				var_47_8.localPosition = Vector3.New(0.7, -0.66, -6.15)
				var_47_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_8.position).x, (manager.ui.mainCamera.transform.position - var_47_8.position).y, (manager.ui.mainCamera.transform.position - var_47_8.position).z)
				var_47_8.localEulerAngles.z = 0
				var_47_8.localEulerAngles.x = 0
				var_47_8.localEulerAngles = var_47_8.localEulerAngles
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action1_1")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_47_10 = 0
			local var_47_11 = 0.175

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_12 = arg_44_1:GetWordFromCfg(104021012)
				local var_47_13 = arg_44_1:FormatText(var_47_12.content)

				arg_44_1.text_.text = var_47_13

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_15 = 7 <= 0 and var_47_11 or var_47_11 * (utf8.len(var_47_13) / 7)

				if (7 <= 0 and var_47_11 or var_47_11 * (utf8.len(var_47_13) / 7)) > 0 and var_47_11 < var_47_15 then
					arg_44_1.talkMaxDuration = var_47_15

					if var_47_15 + var_47_10 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_15 + var_47_10
					end
				end

				arg_44_1.text_.text = var_47_13
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021012", "story_v_out_104021.awb") ~= 0 then
					local var_47_16 = manager.audio:GetVoiceLength("story_v_out_104021", "104021012", "story_v_out_104021.awb") / 1000

					if var_47_16 + var_47_10 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_16 + var_47_10
					end

					if var_47_12.prefab_name ~= "" and arg_44_1.actors_[var_47_12.prefab_name] ~= nil then
						local var_47_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_12.prefab_name].transform, "story_v_out_104021", "104021012", "story_v_out_104021.awb")

						arg_44_1:RecordAudio("104021012", var_47_17)
						arg_44_1:RecordAudio("104021012", var_47_17)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_104021", "104021012", "story_v_out_104021.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_104021", "104021012", "story_v_out_104021.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_18 = math.max(var_47_11, arg_44_1.talkMaxDuration)

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_18 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_10) / var_47_18

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_10 + var_47_18 and arg_44_1.time_ < var_47_10 + var_47_18 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play104021013 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 104021013
		arg_48_1.duration_ = 3.87

		local var_48_0 = {
			ja = 3.866,
			ko = 2.233,
			zh = 2.1,
			en = 3.066
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play104021014(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["10002ui_story"]) and arg_48_1.var_.characterEffect10002ui_story == nil then
				arg_48_1.var_.characterEffect10002ui_story = arg_48_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["10002ui_story"]) then
				if arg_48_1.var_.characterEffect10002ui_story and not isNil(arg_48_1.actors_["10002ui_story"]) then
					arg_48_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["10002ui_story"]) and arg_48_1.var_.characterEffect10002ui_story then
				arg_48_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_51_2 = arg_48_1.actors_["1013ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1013ui_story == nil then
				arg_48_1.var_.characterEffect1013ui_story = var_51_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_3 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 and not isNil(var_51_2) then
				if arg_48_1.var_.characterEffect1013ui_story and not isNil(var_51_2) then
					arg_48_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_3)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1013ui_story then
				arg_48_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1013ui_story.fillRatio = 0.5
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action4_2")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_51_4 = 0
			local var_51_5 = 0.225

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_6 = arg_48_1:GetWordFromCfg(104021013)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 9 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 9)

				if (9 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 9)) > 0 and var_51_5 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021013", "story_v_out_104021.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_104021", "104021013", "story_v_out_104021.awb") / 1000

					if var_51_10 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_4
					end

					if var_51_6.prefab_name ~= "" and arg_48_1.actors_[var_51_6.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_6.prefab_name].transform, "story_v_out_104021", "104021013", "story_v_out_104021.awb")

						arg_48_1:RecordAudio("104021013", var_51_11)
						arg_48_1:RecordAudio("104021013", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_104021", "104021013", "story_v_out_104021.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_104021", "104021013", "story_v_out_104021.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_12 = math.max(var_51_5, arg_48_1.talkMaxDuration)

			if var_51_4 <= arg_48_1.time_ and arg_48_1.time_ < var_51_4 + var_51_12 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_4) / var_51_12

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_4 + var_51_12 and arg_48_1.time_ < var_51_4 + var_51_12 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play104021014 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 104021014
		arg_52_1.duration_ = 2

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play104021015(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1013ui_story"]) and arg_52_1.var_.characterEffect1013ui_story == nil then
				arg_52_1.var_.characterEffect1013ui_story = arg_52_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.1

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1013ui_story"]) then
				if arg_52_1.var_.characterEffect1013ui_story and not isNil(arg_52_1.actors_["1013ui_story"]) then
					arg_52_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1013ui_story"]) and arg_52_1.var_.characterEffect1013ui_story then
				arg_52_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_55_2 = arg_52_1.actors_["10002ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect10002ui_story == nil then
				arg_52_1.var_.characterEffect10002ui_story = var_55_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_3 = 0.1

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 and not isNil(var_55_2) then
				if arg_52_1.var_.characterEffect10002ui_story and not isNil(var_55_2) then
					arg_52_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_52_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_3)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect10002ui_story then
				arg_52_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_52_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action2_1")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_55_4 = 0
			local var_55_5 = 0.075

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_6 = arg_52_1:GetWordFromCfg(104021014)
				local var_55_7 = arg_52_1:FormatText(var_55_6.content)

				arg_52_1.text_.text = var_55_7

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_9 = 3 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 3)

				if (3 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 3)) > 0 and var_55_5 < var_55_9 then
					arg_52_1.talkMaxDuration = var_55_9

					if var_55_9 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_7
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021014", "story_v_out_104021.awb") ~= 0 then
					local var_55_10 = manager.audio:GetVoiceLength("story_v_out_104021", "104021014", "story_v_out_104021.awb") / 1000

					if var_55_10 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_4
					end

					if var_55_6.prefab_name ~= "" and arg_52_1.actors_[var_55_6.prefab_name] ~= nil then
						local var_55_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_6.prefab_name].transform, "story_v_out_104021", "104021014", "story_v_out_104021.awb")

						arg_52_1:RecordAudio("104021014", var_55_11)
						arg_52_1:RecordAudio("104021014", var_55_11)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_104021", "104021014", "story_v_out_104021.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_104021", "104021014", "story_v_out_104021.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_12 = math.max(var_55_5, arg_52_1.talkMaxDuration)

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_12 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_4) / var_55_12

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_4 + var_55_12 and arg_52_1.time_ < var_55_4 + var_55_12 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play104021015 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 104021015
		arg_56_1.duration_ = 4.2

		local var_56_0 = {
			ja = 4.2,
			ko = 3.133,
			zh = 3.8,
			en = 4.2
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play104021016(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action425")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_59_0 = 0
			local var_59_1 = 0.375

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_2 = arg_56_1:GetWordFromCfg(104021015)
				local var_59_3 = arg_56_1:FormatText(var_59_2.content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 15 <= 0 and var_59_1 or var_59_1 * (utf8.len(var_59_3) / 15)

				if (15 <= 0 and var_59_1 or var_59_1 * (utf8.len(var_59_3) / 15)) > 0 and var_59_1 < var_59_5 then
					arg_56_1.talkMaxDuration = var_59_5

					if var_59_5 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_3
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021015", "story_v_out_104021.awb") ~= 0 then
					local var_59_6 = manager.audio:GetVoiceLength("story_v_out_104021", "104021015", "story_v_out_104021.awb") / 1000

					if var_59_6 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_0
					end

					if var_59_2.prefab_name ~= "" and arg_56_1.actors_[var_59_2.prefab_name] ~= nil then
						local var_59_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_2.prefab_name].transform, "story_v_out_104021", "104021015", "story_v_out_104021.awb")

						arg_56_1:RecordAudio("104021015", var_59_7)
						arg_56_1:RecordAudio("104021015", var_59_7)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_104021", "104021015", "story_v_out_104021.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_104021", "104021015", "story_v_out_104021.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_8 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_8 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_8

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_8 and arg_56_1.time_ < var_59_0 + var_59_8 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play104021016 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 104021016
		arg_60_1.duration_ = 7.37

		local var_60_0 = {
			ja = 3.5,
			ko = 7.1,
			zh = 7.366,
			en = 5.166
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play104021017(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action4510")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_63_0 = 0
			local var_63_1 = 0.975

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_2 = arg_60_1:GetWordFromCfg(104021016)
				local var_63_3 = arg_60_1:FormatText(var_63_2.content)

				arg_60_1.text_.text = var_63_3

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 38 <= 0 and var_63_1 or var_63_1 * (utf8.len(var_63_3) / 38)

				if (38 <= 0 and var_63_1 or var_63_1 * (utf8.len(var_63_3) / 38)) > 0 and var_63_1 < var_63_5 then
					arg_60_1.talkMaxDuration = var_63_5

					if var_63_5 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_3
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021016", "story_v_out_104021.awb") ~= 0 then
					local var_63_6 = manager.audio:GetVoiceLength("story_v_out_104021", "104021016", "story_v_out_104021.awb") / 1000

					if var_63_6 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_6 + var_63_0
					end

					if var_63_2.prefab_name ~= "" and arg_60_1.actors_[var_63_2.prefab_name] ~= nil then
						local var_63_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_2.prefab_name].transform, "story_v_out_104021", "104021016", "story_v_out_104021.awb")

						arg_60_1:RecordAudio("104021016", var_63_7)
						arg_60_1:RecordAudio("104021016", var_63_7)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_104021", "104021016", "story_v_out_104021.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_104021", "104021016", "story_v_out_104021.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_8 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_8 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_8

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_8 and arg_60_1.time_ < var_63_0 + var_63_8 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play104021017 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 104021017
		arg_64_1.duration_ = 2.27

		local var_64_0 = {
			ja = 2.266,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play104021018(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["10002ui_story"]) and arg_64_1.var_.characterEffect10002ui_story == nil then
				arg_64_1.var_.characterEffect10002ui_story = arg_64_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.1

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["10002ui_story"]) then
				if arg_64_1.var_.characterEffect10002ui_story and not isNil(arg_64_1.actors_["10002ui_story"]) then
					arg_64_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["10002ui_story"]) and arg_64_1.var_.characterEffect10002ui_story then
				arg_64_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_67_2 = arg_64_1.actors_["1013ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.characterEffect1013ui_story == nil then
				arg_64_1.var_.characterEffect1013ui_story = var_67_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_3 = 0.1

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_3 and not isNil(var_67_2) then
				if arg_64_1.var_.characterEffect1013ui_story and not isNil(var_67_2) then
					arg_64_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_3)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_3 and arg_64_1.time_ < 0 + var_67_3 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.characterEffect1013ui_story then
				arg_64_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1013ui_story.fillRatio = 0.5
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action2_1")
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_67_4 = 0
			local var_67_5 = 0.05

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_6 = arg_64_1:GetWordFromCfg(104021017)
				local var_67_7 = arg_64_1:FormatText(var_67_6.content)

				arg_64_1.text_.text = var_67_7

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_9 = 2 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 2)

				if (2 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 2)) > 0 and var_67_5 < var_67_9 then
					arg_64_1.talkMaxDuration = var_67_9

					if var_67_9 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_4
					end
				end

				arg_64_1.text_.text = var_67_7
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021017", "story_v_out_104021.awb") ~= 0 then
					local var_67_10 = manager.audio:GetVoiceLength("story_v_out_104021", "104021017", "story_v_out_104021.awb") / 1000

					if var_67_10 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_4
					end

					if var_67_6.prefab_name ~= "" and arg_64_1.actors_[var_67_6.prefab_name] ~= nil then
						local var_67_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_6.prefab_name].transform, "story_v_out_104021", "104021017", "story_v_out_104021.awb")

						arg_64_1:RecordAudio("104021017", var_67_11)
						arg_64_1:RecordAudio("104021017", var_67_11)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_104021", "104021017", "story_v_out_104021.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_104021", "104021017", "story_v_out_104021.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_12 = math.max(var_67_5, arg_64_1.talkMaxDuration)

			if var_67_4 <= arg_64_1.time_ and arg_64_1.time_ < var_67_4 + var_67_12 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_4) / var_67_12

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_4 + var_67_12 and arg_64_1.time_ < var_67_4 + var_67_12 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play104021018 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 104021018
		arg_68_1.duration_ = 9.37

		local var_68_0 = {
			ja = 9.366,
			ko = 8.6,
			zh = 6.433,
			en = 7.333
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play104021019(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002actionlink/10002action423")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_71_0 = 0
			local var_71_1 = 0.8

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_2 = arg_68_1:GetWordFromCfg(104021018)
				local var_71_3 = arg_68_1:FormatText(var_71_2.content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 32 <= 0 and var_71_1 or var_71_1 * (utf8.len(var_71_3) / 32)

				if (32 <= 0 and var_71_1 or var_71_1 * (utf8.len(var_71_3) / 32)) > 0 and var_71_1 < var_71_5 then
					arg_68_1.talkMaxDuration = var_71_5

					if var_71_5 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_3
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021018", "story_v_out_104021.awb") ~= 0 then
					local var_71_6 = manager.audio:GetVoiceLength("story_v_out_104021", "104021018", "story_v_out_104021.awb") / 1000

					if var_71_6 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_6 + var_71_0
					end

					if var_71_2.prefab_name ~= "" and arg_68_1.actors_[var_71_2.prefab_name] ~= nil then
						local var_71_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_2.prefab_name].transform, "story_v_out_104021", "104021018", "story_v_out_104021.awb")

						arg_68_1:RecordAudio("104021018", var_71_7)
						arg_68_1:RecordAudio("104021018", var_71_7)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_104021", "104021018", "story_v_out_104021.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_104021", "104021018", "story_v_out_104021.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_8 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_8 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_8

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_8 and arg_68_1.time_ < var_71_0 + var_71_8 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play104021019 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 104021019
		arg_72_1.duration_ = 9.1

		local var_72_0 = {
			ja = 9.1,
			ko = 7.7,
			zh = 5.9,
			en = 6.4
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play104021020(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1013ui_story"]) and arg_72_1.var_.characterEffect1013ui_story == nil then
				arg_72_1.var_.characterEffect1013ui_story = arg_72_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.1

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1013ui_story"]) then
				if arg_72_1.var_.characterEffect1013ui_story and not isNil(arg_72_1.actors_["1013ui_story"]) then
					arg_72_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1013ui_story"]) and arg_72_1.var_.characterEffect1013ui_story then
				arg_72_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_75_2 = arg_72_1.actors_["10002ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.characterEffect10002ui_story == nil then
				arg_72_1.var_.characterEffect10002ui_story = var_75_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_3 = 0.1

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_3 and not isNil(var_75_2) then
				if arg_72_1.var_.characterEffect10002ui_story and not isNil(var_75_2) then
					arg_72_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_72_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_3)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_3 and arg_72_1.time_ < 0 + var_75_3 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.characterEffect10002ui_story then
				arg_72_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_72_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action4104")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_75_4 = 0
			local var_75_5 = 0.675

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_4 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_6 = arg_72_1:GetWordFromCfg(104021019)
				local var_75_7 = arg_72_1:FormatText(var_75_6.content)

				arg_72_1.text_.text = var_75_7

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_9 = 27 <= 0 and var_75_5 or var_75_5 * (utf8.len(var_75_7) / 27)

				if (27 <= 0 and var_75_5 or var_75_5 * (utf8.len(var_75_7) / 27)) > 0 and var_75_5 < var_75_9 then
					arg_72_1.talkMaxDuration = var_75_9

					if var_75_9 + var_75_4 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_9 + var_75_4
					end
				end

				arg_72_1.text_.text = var_75_7
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021019", "story_v_out_104021.awb") ~= 0 then
					local var_75_10 = manager.audio:GetVoiceLength("story_v_out_104021", "104021019", "story_v_out_104021.awb") / 1000

					if var_75_10 + var_75_4 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_10 + var_75_4
					end

					if var_75_6.prefab_name ~= "" and arg_72_1.actors_[var_75_6.prefab_name] ~= nil then
						local var_75_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_6.prefab_name].transform, "story_v_out_104021", "104021019", "story_v_out_104021.awb")

						arg_72_1:RecordAudio("104021019", var_75_11)
						arg_72_1:RecordAudio("104021019", var_75_11)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_104021", "104021019", "story_v_out_104021.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_104021", "104021019", "story_v_out_104021.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_12 = math.max(var_75_5, arg_72_1.talkMaxDuration)

			if var_75_4 <= arg_72_1.time_ and arg_72_1.time_ < var_75_4 + var_75_12 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_4) / var_75_12

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_4 + var_75_12 and arg_72_1.time_ < var_75_4 + var_75_12 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play104021020 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 104021020
		arg_76_1.duration_ = 2.57

		local var_76_0 = {
			ja = 2.566,
			ko = 2.133,
			zh = 2.266,
			en = 1.999999999999
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play104021021(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["10002ui_story"]) and arg_76_1.var_.characterEffect10002ui_story == nil then
				arg_76_1.var_.characterEffect10002ui_story = arg_76_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.1

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["10002ui_story"]) then
				if arg_76_1.var_.characterEffect10002ui_story and not isNil(arg_76_1.actors_["10002ui_story"]) then
					arg_76_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["10002ui_story"]) and arg_76_1.var_.characterEffect10002ui_story then
				arg_76_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_79_2 = arg_76_1.actors_["1013ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.characterEffect1013ui_story == nil then
				arg_76_1.var_.characterEffect1013ui_story = var_79_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_3 = 0.1

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_3 and not isNil(var_79_2) then
				if arg_76_1.var_.characterEffect1013ui_story and not isNil(var_79_2) then
					arg_76_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_3)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_3 and arg_76_1.time_ < 0 + var_79_3 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.characterEffect1013ui_story then
				arg_76_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1013ui_story.fillRatio = 0.5
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_2")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_79_4 = 0
			local var_79_5 = 0.15

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_6 = arg_76_1:GetWordFromCfg(104021020)
				local var_79_7 = arg_76_1:FormatText(var_79_6.content)

				arg_76_1.text_.text = var_79_7

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_9 = 6 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 6)

				if (6 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 6)) > 0 and var_79_5 < var_79_9 then
					arg_76_1.talkMaxDuration = var_79_9

					if var_79_9 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_9 + var_79_4
					end
				end

				arg_76_1.text_.text = var_79_7
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021020", "story_v_out_104021.awb") ~= 0 then
					local var_79_10 = manager.audio:GetVoiceLength("story_v_out_104021", "104021020", "story_v_out_104021.awb") / 1000

					if var_79_10 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_10 + var_79_4
					end

					if var_79_6.prefab_name ~= "" and arg_76_1.actors_[var_79_6.prefab_name] ~= nil then
						local var_79_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_6.prefab_name].transform, "story_v_out_104021", "104021020", "story_v_out_104021.awb")

						arg_76_1:RecordAudio("104021020", var_79_11)
						arg_76_1:RecordAudio("104021020", var_79_11)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_104021", "104021020", "story_v_out_104021.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_104021", "104021020", "story_v_out_104021.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_12 = math.max(var_79_5, arg_76_1.talkMaxDuration)

			if var_79_4 <= arg_76_1.time_ and arg_76_1.time_ < var_79_4 + var_79_12 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_4) / var_79_12

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_4 + var_79_12 and arg_76_1.time_ < var_79_4 + var_79_12 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play104021021 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 104021021
		arg_80_1.duration_ = 9.03

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play104021022(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["10002ui_story"]) and arg_80_1.var_.characterEffect10002ui_story == nil then
				arg_80_1.var_.characterEffect10002ui_story = arg_80_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.1

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["10002ui_story"]) then
				if arg_80_1.var_.characterEffect10002ui_story and not isNil(arg_80_1.actors_["10002ui_story"]) then
					arg_80_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_80_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_0)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["10002ui_story"]) and arg_80_1.var_.characterEffect10002ui_story then
				arg_80_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_80_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_83_1 = arg_80_1.actors_["10002ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos10002ui_story = var_83_1.localPosition
			end

			local var_83_2 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_2 then
				var_83_1.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10002ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_2)
				var_83_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_1.position).x, (manager.ui.mainCamera.transform.position - var_83_1.position).y, (manager.ui.mainCamera.transform.position - var_83_1.position).z)
				var_83_1.localEulerAngles.z = 0
				var_83_1.localEulerAngles.x = 0
				var_83_1.localEulerAngles = var_83_1.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_2 and arg_80_1.time_ < 0 + var_83_2 + arg_83_0 then
				var_83_1.localPosition = Vector3.New(0, 100, 0)
				var_83_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_1.position).x, (manager.ui.mainCamera.transform.position - var_83_1.position).y, (manager.ui.mainCamera.transform.position - var_83_1.position).z)
				var_83_1.localEulerAngles.z = 0
				var_83_1.localEulerAngles.x = 0
				var_83_1.localEulerAngles = var_83_1.localEulerAngles
			end

			local var_83_3 = arg_80_1.actors_["1013ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1013ui_story = var_83_3.localPosition
			end

			local var_83_4 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 then
				var_83_3.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1013ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_4)
				var_83_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_3.position).x, (manager.ui.mainCamera.transform.position - var_83_3.position).y, (manager.ui.mainCamera.transform.position - var_83_3.position).z)
				var_83_3.localEulerAngles.z = 0
				var_83_3.localEulerAngles.x = 0
				var_83_3.localEulerAngles = var_83_3.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 then
				var_83_3.localPosition = Vector3.New(0, 100, 0)
				var_83_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_3.position).x, (manager.ui.mainCamera.transform.position - var_83_3.position).y, (manager.ui.mainCamera.transform.position - var_83_3.position).z)
				var_83_3.localEulerAngles.z = 0
				var_83_3.localEulerAngles.x = 0
				var_83_3.localEulerAngles = var_83_3.localEulerAngles
			end

			local var_83_5 = 0
			local var_83_6 = 0.7

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_7 = arg_80_1:GetWordFromCfg(104021021)
				local var_83_8 = arg_80_1:FormatText(var_83_7.content)

				arg_80_1.text_.text = var_83_8

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_10 = 28 <= 0 and var_83_6 or var_83_6 * (utf8.len(var_83_8) / 28)

				if (28 <= 0 and var_83_6 or var_83_6 * (utf8.len(var_83_8) / 28)) > 0 and var_83_6 < var_83_10 then
					arg_80_1.talkMaxDuration = var_83_10

					if var_83_10 + var_83_5 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_5
					end
				end

				arg_80_1.text_.text = var_83_8
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021021", "story_v_out_104021.awb") ~= 0 then
					local var_83_11 = manager.audio:GetVoiceLength("story_v_out_104021", "104021021", "story_v_out_104021.awb") / 1000

					if var_83_11 + var_83_5 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_11 + var_83_5
					end

					if var_83_7.prefab_name ~= "" and arg_80_1.actors_[var_83_7.prefab_name] ~= nil then
						local var_83_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_7.prefab_name].transform, "story_v_out_104021", "104021021", "story_v_out_104021.awb")

						arg_80_1:RecordAudio("104021021", var_83_12)
						arg_80_1:RecordAudio("104021021", var_83_12)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_104021", "104021021", "story_v_out_104021.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_104021", "104021021", "story_v_out_104021.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_13 = math.max(var_83_6, arg_80_1.talkMaxDuration)

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_13 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_5) / var_83_13

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_5 + var_83_13 and arg_80_1.time_ < var_83_5 + var_83_13 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play104021022 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 104021022
		arg_84_1.duration_ = 7.07

		local var_84_0 = {
			ja = 7.066,
			ko = 3.9,
			zh = 4.466,
			en = 4.533
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play104021023(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:AudioAction("play", "effect", "se_story", "se_story_robot_long", "")
			end

			local var_87_1 = "2018_tpose"

			if arg_84_1.actors_["2018_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2018_tpose"))) then
				local var_87_2 = Object.Instantiate(Asset.Load("Char/" .. "2018_tpose"), arg_84_1.stage_.transform)

				var_87_2.name = var_87_1
				var_87_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_84_1.actors_[var_87_1] = var_87_2

				local var_87_3 = var_87_2:GetComponentInChildren(typeof(CharacterEffect))

				var_87_3.enabled = true

				local var_87_4 = GameObjectTools.GetOrAddComponent(var_87_2, typeof(DynamicBoneHelper))

				if var_87_4 then
					var_87_4:EnableDynamicBone(false)
				end

				arg_84_1:ShowWeapon(var_87_3.transform, false)

				arg_84_1.var_[var_87_1 .. "Animator"] = var_87_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_84_1.var_[var_87_1 .. "Animator"].applyRootMotion = true
				arg_84_1.var_[var_87_1 .. "LipSync"] = var_87_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_87_5 = arg_84_1.actors_["2018_tpose"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_5) and arg_84_1.var_.characterEffect2018_tpose == nil then
				arg_84_1.var_.characterEffect2018_tpose = var_87_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_6 = 0.1

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_6 and not isNil(var_87_5) then
				if arg_84_1.var_.characterEffect2018_tpose and not isNil(var_87_5) then
					arg_84_1.var_.characterEffect2018_tpose.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_6 and arg_84_1.time_ < 0 + var_87_6 + arg_87_0 and not isNil(var_87_5) and arg_84_1.var_.characterEffect2018_tpose then
				arg_84_1.var_.characterEffect2018_tpose.fillFlat = false
			end

			local var_87_8 = arg_84_1.actors_["2018_tpose"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos2018_tpose = var_87_8.localPosition

				local var_87_9 = GameObjectTools.GetOrAddComponent(var_87_8.gameObject, typeof(DynamicBoneHelper))

				if var_87_9 then
					var_87_9:EnableDynamicBone(false)
				end
			end

			local var_87_10 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_10 then
				var_87_8.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos2018_tpose, Vector3.New(0, -0.5, -0.7), (arg_84_1.time_ - 0) / var_87_10)
				var_87_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_8.position).x, (manager.ui.mainCamera.transform.position - var_87_8.position).y, (manager.ui.mainCamera.transform.position - var_87_8.position).z)
				var_87_8.localEulerAngles.z = 0
				var_87_8.localEulerAngles.x = 0
				var_87_8.localEulerAngles = var_87_8.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_10 and arg_84_1.time_ < 0 + var_87_10 + arg_87_0 then
				var_87_8.localPosition = Vector3.New(0, -0.5, -0.7)
				var_87_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_8.position).x, (manager.ui.mainCamera.transform.position - var_87_8.position).y, (manager.ui.mainCamera.transform.position - var_87_8.position).z)
				var_87_8.localEulerAngles.z = 0
				var_87_8.localEulerAngles.x = 0
				var_87_8.localEulerAngles = var_87_8.localEulerAngles

				local var_87_11 = GameObjectTools.GetOrAddComponent(var_87_8.gameObject, typeof(DynamicBoneHelper))

				if var_87_11 then
					var_87_11:EnableDynamicBone(true)
				end
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("2018_tpose", "StoryTimeline/CharAction/story2018/story2018action/2018action1_1")
			end

			local var_87_12 = 0
			local var_87_13 = 0.375

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_12 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_14 = arg_84_1:GetWordFromCfg(104021022)
				local var_87_15 = arg_84_1:FormatText(var_87_14.content)

				arg_84_1.text_.text = var_87_15

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_17 = 15 <= 0 and var_87_13 or var_87_13 * (utf8.len(var_87_15) / 15)

				if (15 <= 0 and var_87_13 or var_87_13 * (utf8.len(var_87_15) / 15)) > 0 and var_87_13 < var_87_17 then
					arg_84_1.talkMaxDuration = var_87_17

					if var_87_17 + var_87_12 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_17 + var_87_12
					end
				end

				arg_84_1.text_.text = var_87_15
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021022", "story_v_out_104021.awb") ~= 0 then
					local var_87_18 = manager.audio:GetVoiceLength("story_v_out_104021", "104021022", "story_v_out_104021.awb") / 1000

					if var_87_18 + var_87_12 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_18 + var_87_12
					end

					if var_87_14.prefab_name ~= "" and arg_84_1.actors_[var_87_14.prefab_name] ~= nil then
						local var_87_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_14.prefab_name].transform, "story_v_out_104021", "104021022", "story_v_out_104021.awb")

						arg_84_1:RecordAudio("104021022", var_87_19)
						arg_84_1:RecordAudio("104021022", var_87_19)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_104021", "104021022", "story_v_out_104021.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_104021", "104021022", "story_v_out_104021.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_20 = math.max(var_87_13, arg_84_1.talkMaxDuration)

			if var_87_12 <= arg_84_1.time_ and arg_84_1.time_ < var_87_12 + var_87_20 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_12) / var_87_20

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_12 + var_87_20 and arg_84_1.time_ < var_87_12 + var_87_20 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2018_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play104021023 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 104021023
		arg_88_1.duration_ = 4

		local var_88_0 = {
			ja = 4,
			ko = 2.533,
			zh = 4,
			en = 3.433
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play104021024(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:AudioAction("play", "effect", "se_story", "se_story_robot_short", "")
			end

			local var_91_1 = "2022_tpose"

			if arg_88_1.actors_["2022_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2022_tpose"))) then
				local var_91_2 = Object.Instantiate(Asset.Load("Char/" .. "2022_tpose"), arg_88_1.stage_.transform)

				var_91_2.name = var_91_1
				var_91_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.actors_[var_91_1] = var_91_2

				local var_91_3 = var_91_2:GetComponentInChildren(typeof(CharacterEffect))

				var_91_3.enabled = true

				local var_91_4 = GameObjectTools.GetOrAddComponent(var_91_2, typeof(DynamicBoneHelper))

				if var_91_4 then
					var_91_4:EnableDynamicBone(false)
				end

				arg_88_1:ShowWeapon(var_91_3.transform, false)

				arg_88_1.var_[var_91_1 .. "Animator"] = var_91_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_88_1.var_[var_91_1 .. "Animator"].applyRootMotion = true
				arg_88_1.var_[var_91_1 .. "LipSync"] = var_91_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_91_5 = arg_88_1.actors_["2022_tpose"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_5) and arg_88_1.var_.characterEffect2022_tpose == nil then
				arg_88_1.var_.characterEffect2022_tpose = var_91_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_6 = 0.1

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_6 and not isNil(var_91_5) then
				if arg_88_1.var_.characterEffect2022_tpose and not isNil(var_91_5) then
					arg_88_1.var_.characterEffect2022_tpose.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_6 and arg_88_1.time_ < 0 + var_91_6 + arg_91_0 and not isNil(var_91_5) and arg_88_1.var_.characterEffect2022_tpose then
				arg_88_1.var_.characterEffect2022_tpose.fillFlat = false
			end

			local var_91_8 = arg_88_1.actors_["2018_tpose"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_8) and arg_88_1.var_.characterEffect2018_tpose == nil then
				arg_88_1.var_.characterEffect2018_tpose = var_91_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_9 = 0.1

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_9 and not isNil(var_91_8) then
				if arg_88_1.var_.characterEffect2018_tpose and not isNil(var_91_8) then
					arg_88_1.var_.characterEffect2018_tpose.fillFlat = true
					arg_88_1.var_.characterEffect2018_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_9)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_9 and arg_88_1.time_ < 0 + var_91_9 + arg_91_0 and not isNil(var_91_8) and arg_88_1.var_.characterEffect2018_tpose then
				arg_88_1.var_.characterEffect2018_tpose.fillFlat = true
				arg_88_1.var_.characterEffect2018_tpose.fillRatio = 0.5
			end

			local var_91_10 = arg_88_1.actors_["2018_tpose"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos2018_tpose = var_91_10.localPosition

				local var_91_11 = GameObjectTools.GetOrAddComponent(var_91_10.gameObject, typeof(DynamicBoneHelper))

				if var_91_11 then
					var_91_11:EnableDynamicBone(false)
				end
			end

			local var_91_12 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_12 then
				var_91_10.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos2018_tpose, Vector3.New(0, 100, 0), (arg_88_1.time_ - 0) / var_91_12)
				var_91_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_10.position).x, (manager.ui.mainCamera.transform.position - var_91_10.position).y, (manager.ui.mainCamera.transform.position - var_91_10.position).z)
				var_91_10.localEulerAngles.z = 0
				var_91_10.localEulerAngles.x = 0
				var_91_10.localEulerAngles = var_91_10.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_12 and arg_88_1.time_ < 0 + var_91_12 + arg_91_0 then
				var_91_10.localPosition = Vector3.New(0, 100, 0)
				var_91_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_10.position).x, (manager.ui.mainCamera.transform.position - var_91_10.position).y, (manager.ui.mainCamera.transform.position - var_91_10.position).z)
				var_91_10.localEulerAngles.z = 0
				var_91_10.localEulerAngles.x = 0
				var_91_10.localEulerAngles = var_91_10.localEulerAngles

				local var_91_13 = GameObjectTools.GetOrAddComponent(var_91_10.gameObject, typeof(DynamicBoneHelper))

				if var_91_13 then
					var_91_13:EnableDynamicBone(true)
				end
			end

			local var_91_14 = arg_88_1.actors_["2022_tpose"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos2022_tpose = var_91_14.localPosition

				local var_91_15 = GameObjectTools.GetOrAddComponent(var_91_14.gameObject, typeof(DynamicBoneHelper))

				if var_91_15 then
					var_91_15:EnableDynamicBone(false)
				end
			end

			local var_91_16 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_16 then
				var_91_14.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos2022_tpose, Vector3.New(-0.7, -0.55, -0.3), (arg_88_1.time_ - 0) / var_91_16)
				var_91_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_14.position).x, (manager.ui.mainCamera.transform.position - var_91_14.position).y, (manager.ui.mainCamera.transform.position - var_91_14.position).z)
				var_91_14.localEulerAngles.z = 0
				var_91_14.localEulerAngles.x = 0
				var_91_14.localEulerAngles = var_91_14.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_16 and arg_88_1.time_ < 0 + var_91_16 + arg_91_0 then
				var_91_14.localPosition = Vector3.New(-0.7, -0.55, -0.3)
				var_91_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_14.position).x, (manager.ui.mainCamera.transform.position - var_91_14.position).y, (manager.ui.mainCamera.transform.position - var_91_14.position).z)
				var_91_14.localEulerAngles.z = 0
				var_91_14.localEulerAngles.x = 0
				var_91_14.localEulerAngles = var_91_14.localEulerAngles

				local var_91_17 = GameObjectTools.GetOrAddComponent(var_91_14.gameObject, typeof(DynamicBoneHelper))

				if var_91_17 then
					var_91_17:EnableDynamicBone(true)
				end
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("2022_tpose", "StoryTimeline/CharAction/story2022/story2022action/2022action1_1")
			end

			local var_91_18 = 0
			local var_91_19 = 0.225

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_18 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_20 = arg_88_1:GetWordFromCfg(104021023)
				local var_91_21 = arg_88_1:FormatText(var_91_20.content)

				arg_88_1.text_.text = var_91_21

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_23 = 9 <= 0 and var_91_19 or var_91_19 * (utf8.len(var_91_21) / 9)

				if (9 <= 0 and var_91_19 or var_91_19 * (utf8.len(var_91_21) / 9)) > 0 and var_91_19 < var_91_23 then
					arg_88_1.talkMaxDuration = var_91_23

					if var_91_23 + var_91_18 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_23 + var_91_18
					end
				end

				arg_88_1.text_.text = var_91_21
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021023", "story_v_out_104021.awb") ~= 0 then
					local var_91_24 = manager.audio:GetVoiceLength("story_v_out_104021", "104021023", "story_v_out_104021.awb") / 1000

					if var_91_24 + var_91_18 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_24 + var_91_18
					end

					if var_91_20.prefab_name ~= "" and arg_88_1.actors_[var_91_20.prefab_name] ~= nil then
						local var_91_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_20.prefab_name].transform, "story_v_out_104021", "104021023", "story_v_out_104021.awb")

						arg_88_1:RecordAudio("104021023", var_91_25)
						arg_88_1:RecordAudio("104021023", var_91_25)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_104021", "104021023", "story_v_out_104021.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_104021", "104021023", "story_v_out_104021.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_26 = math.max(var_91_19, arg_88_1.talkMaxDuration)

			if var_91_18 <= arg_88_1.time_ and arg_88_1.time_ < var_91_18 + var_91_26 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_18) / var_91_26

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_18 + var_91_26 and arg_88_1.time_ < var_91_18 + var_91_26 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2018_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2022_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play104021024 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 104021024
		arg_92_1.duration_ = 4.17

		local var_92_0 = {
			ja = 3.266,
			ko = 2.466,
			zh = 4.166,
			en = 3.433
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play104021025(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:AudioAction("play", "effect", "se_story", "se_story_robot_short", "")
			end

			local var_95_1 = "2021_tpose"

			if arg_92_1.actors_["2021_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2021_tpose"))) then
				local var_95_2 = Object.Instantiate(Asset.Load("Char/" .. "2021_tpose"), arg_92_1.stage_.transform)

				var_95_2.name = var_95_1
				var_95_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.actors_[var_95_1] = var_95_2

				local var_95_3 = var_95_2:GetComponentInChildren(typeof(CharacterEffect))

				var_95_3.enabled = true

				local var_95_4 = GameObjectTools.GetOrAddComponent(var_95_2, typeof(DynamicBoneHelper))

				if var_95_4 then
					var_95_4:EnableDynamicBone(false)
				end

				arg_92_1:ShowWeapon(var_95_3.transform, false)

				arg_92_1.var_[var_95_1 .. "Animator"] = var_95_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_92_1.var_[var_95_1 .. "Animator"].applyRootMotion = true
				arg_92_1.var_[var_95_1 .. "LipSync"] = var_95_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_95_5 = arg_92_1.actors_["2021_tpose"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_5) and arg_92_1.var_.characterEffect2021_tpose == nil then
				arg_92_1.var_.characterEffect2021_tpose = var_95_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_6 = 0.1

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_6 and not isNil(var_95_5) then
				if arg_92_1.var_.characterEffect2021_tpose and not isNil(var_95_5) then
					arg_92_1.var_.characterEffect2021_tpose.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_6 and arg_92_1.time_ < 0 + var_95_6 + arg_95_0 and not isNil(var_95_5) and arg_92_1.var_.characterEffect2021_tpose then
				arg_92_1.var_.characterEffect2021_tpose.fillFlat = false
			end

			local var_95_8 = arg_92_1.actors_["2022_tpose"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_8) and arg_92_1.var_.characterEffect2022_tpose == nil then
				arg_92_1.var_.characterEffect2022_tpose = var_95_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_9 = 0.1

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_9 and not isNil(var_95_8) then
				if arg_92_1.var_.characterEffect2022_tpose and not isNil(var_95_8) then
					arg_92_1.var_.characterEffect2022_tpose.fillFlat = true
					arg_92_1.var_.characterEffect2022_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_9)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_9 and arg_92_1.time_ < 0 + var_95_9 + arg_95_0 and not isNil(var_95_8) and arg_92_1.var_.characterEffect2022_tpose then
				arg_92_1.var_.characterEffect2022_tpose.fillFlat = true
				arg_92_1.var_.characterEffect2022_tpose.fillRatio = 0.5
			end

			local var_95_10 = arg_92_1.actors_["2021_tpose"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos2021_tpose = var_95_10.localPosition

				local var_95_11 = GameObjectTools.GetOrAddComponent(var_95_10.gameObject, typeof(DynamicBoneHelper))

				if var_95_11 then
					var_95_11:EnableDynamicBone(false)
				end
			end

			local var_95_12 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_12 then
				var_95_10.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos2021_tpose, Vector3.New(1.92, -0.6, 0.2), (arg_92_1.time_ - 0) / var_95_12)
				var_95_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_10.position).x, (manager.ui.mainCamera.transform.position - var_95_10.position).y, (manager.ui.mainCamera.transform.position - var_95_10.position).z)
				var_95_10.localEulerAngles.z = 0
				var_95_10.localEulerAngles.x = 0
				var_95_10.localEulerAngles = var_95_10.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_12 and arg_92_1.time_ < 0 + var_95_12 + arg_95_0 then
				var_95_10.localPosition = Vector3.New(1.92, -0.6, 0.2)
				var_95_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_10.position).x, (manager.ui.mainCamera.transform.position - var_95_10.position).y, (manager.ui.mainCamera.transform.position - var_95_10.position).z)
				var_95_10.localEulerAngles.z = 0
				var_95_10.localEulerAngles.x = 0
				var_95_10.localEulerAngles = var_95_10.localEulerAngles

				local var_95_13 = GameObjectTools.GetOrAddComponent(var_95_10.gameObject, typeof(DynamicBoneHelper))

				if var_95_13 then
					var_95_13:EnableDynamicBone(true)
				end
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("2021_tpose", "StoryTimeline/CharAction/story2021/story2021action/2021action1_1")
			end

			local var_95_14 = 0
			local var_95_15 = 0.225

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_14 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_16 = arg_92_1:GetWordFromCfg(104021024)
				local var_95_17 = arg_92_1:FormatText(var_95_16.content)

				arg_92_1.text_.text = var_95_17

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_19 = 9 <= 0 and var_95_15 or var_95_15 * (utf8.len(var_95_17) / 9)

				if (9 <= 0 and var_95_15 or var_95_15 * (utf8.len(var_95_17) / 9)) > 0 and var_95_15 < var_95_19 then
					arg_92_1.talkMaxDuration = var_95_19

					if var_95_19 + var_95_14 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_19 + var_95_14
					end
				end

				arg_92_1.text_.text = var_95_17
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021024", "story_v_out_104021.awb") ~= 0 then
					local var_95_20 = manager.audio:GetVoiceLength("story_v_out_104021", "104021024", "story_v_out_104021.awb") / 1000

					if var_95_20 + var_95_14 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_20 + var_95_14
					end

					if var_95_16.prefab_name ~= "" and arg_92_1.actors_[var_95_16.prefab_name] ~= nil then
						local var_95_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_16.prefab_name].transform, "story_v_out_104021", "104021024", "story_v_out_104021.awb")

						arg_92_1:RecordAudio("104021024", var_95_21)
						arg_92_1:RecordAudio("104021024", var_95_21)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_104021", "104021024", "story_v_out_104021.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_104021", "104021024", "story_v_out_104021.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_22 = math.max(var_95_15, arg_92_1.talkMaxDuration)

			if var_95_14 <= arg_92_1.time_ and arg_92_1.time_ < var_95_14 + var_95_22 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_14) / var_95_22

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_14 + var_95_22 and arg_92_1.time_ < var_95_14 + var_95_22 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2021_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play104021025 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 104021025
		arg_96_1.duration_ = 3.47

		local var_96_0 = {
			ja = 2.766,
			ko = 2.5,
			zh = 1.966,
			en = 3.466
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
			arg_96_1.auto_ = false
		end

		function arg_96_1.playNext_(arg_98_0)
			arg_96_1.onStoryFinished_()
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["2021_tpose"]) and arg_96_1.var_.characterEffect2021_tpose == nil then
				arg_96_1.var_.characterEffect2021_tpose = arg_96_1.actors_["2021_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.1

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["2021_tpose"]) then
				if arg_96_1.var_.characterEffect2021_tpose and not isNil(arg_96_1.actors_["2021_tpose"]) then
					arg_96_1.var_.characterEffect2021_tpose.fillFlat = true
					arg_96_1.var_.characterEffect2021_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_0)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["2021_tpose"]) and arg_96_1.var_.characterEffect2021_tpose then
				arg_96_1.var_.characterEffect2021_tpose.fillFlat = true
				arg_96_1.var_.characterEffect2021_tpose.fillRatio = 0.5
			end

			local var_99_1 = 0
			local var_99_2 = 0.225

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jolin")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_3 = arg_96_1:GetWordFromCfg(104021025)
				local var_99_4 = arg_96_1:FormatText(var_99_3.content)

				arg_96_1.text_.text = var_99_4

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_6 = 9 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_4) / 9)

				if (9 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_4) / 9)) > 0 and var_99_2 < var_99_6 then
					arg_96_1.talkMaxDuration = var_99_6

					if var_99_6 + var_99_1 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_6 + var_99_1
					end
				end

				arg_96_1.text_.text = var_99_4
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104021", "104021025", "story_v_out_104021.awb") ~= 0 then
					local var_99_7 = manager.audio:GetVoiceLength("story_v_out_104021", "104021025", "story_v_out_104021.awb") / 1000

					if var_99_7 + var_99_1 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_1
					end

					if var_99_3.prefab_name ~= "" and arg_96_1.actors_[var_99_3.prefab_name] ~= nil then
						local var_99_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_3.prefab_name].transform, "story_v_out_104021", "104021025", "story_v_out_104021.awb")

						arg_96_1:RecordAudio("104021025", var_99_8)
						arg_96_1:RecordAudio("104021025", var_99_8)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_104021", "104021025", "story_v_out_104021.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_104021", "104021025", "story_v_out_104021.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_9 = math.max(var_99_2, arg_96_1.talkMaxDuration)

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_9 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_1) / var_99_9

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_1 + var_99_9 and arg_96_1.time_ < var_99_1 + var_99_9 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B08c"
	},
	voices = {
		"story_v_out_104021.awb"
	}
}
