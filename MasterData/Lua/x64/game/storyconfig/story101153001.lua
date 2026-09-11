return {
	Play115301001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 115301001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play115301002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F01 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F01")
				var_4_0.name = "F01"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F01 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F01

				arg_1_1.bgs_.F01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F01" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_4_14 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_14 + 3 and arg_1_1.time_ < var_4_14 + 3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_15 = 2
			local var_4_16 = 1.3

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(115301001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 52 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_17) / 52)

				if (52 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_17) / 52)) > 0 and var_4_16 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19

					if var_4_19 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 <= arg_1_1.time_ and arg_1_1.time_ < var_4_15 + var_4_20 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_15) / var_4_20

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_15 + var_4_20 and arg_1_1.time_ < var_4_15 + var_4_20 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play115301002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 115301002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play115301003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 1.325

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_1 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(115301002).content)

				arg_7_1.text_.text = var_10_1

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_3 = 53 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_1) / 53)

				if (53 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_1) / 53)) > 0 and var_10_0 < var_10_3 then
					arg_7_1.talkMaxDuration = var_10_3

					if var_10_3 + 0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_3 + 0
					end
				end

				arg_7_1.text_.text = var_10_1
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_4 = math.max(var_10_0, arg_7_1.talkMaxDuration)

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_4 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - 0) / var_10_4

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= 0 + var_10_4 and arg_7_1.time_ < 0 + var_10_4 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play115301003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 115301003
		arg_11_1.duration_ = 5.6

		local var_11_0 = {
			ja = 2.1,
			ko = 3.933,
			zh = 5.6,
			en = 3.833
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
				arg_11_0:Play115301004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if arg_11_1.actors_["1038"] == nil then
				local var_14_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1038")

				if not isNil(var_14_0) then
					local var_14_1 = Object.Instantiate(var_14_0, arg_11_1.canvasGo_.transform)

					var_14_1.transform:SetSiblingIndex(1)

					var_14_1.name = "1038"
					var_14_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_11_1.actors_["1038"] = var_14_1

					if arg_11_1.isInRecall_ then
						for iter_14_0, iter_14_1 in ipairs((var_14_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_14_1.color = arg_11_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_14_2 = arg_11_1.actors_["1038"].transform

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1038 = var_14_2.localPosition
				var_14_2.localScale = Vector3.New(1, 1, 1)

				arg_11_1:CheckSpriteTmpPos("1038", 2)

				for iter_14_2 = 0, var_14_2.childCount - 1 do
					local var_14_3 = var_14_2:GetChild(iter_14_2)

					if var_14_3.name == "split_1" or not string.find(var_14_3.name, "split") then
						var_14_3.gameObject:SetActive(true)
					else
						var_14_3.gameObject:SetActive(false)
					end
				end
			end

			local var_14_4 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_4 then
				var_14_2.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_11_1.time_ - 0) / var_14_4)
			end

			if arg_11_1.time_ >= 0 + var_14_4 and arg_11_1.time_ < 0 + var_14_4 + arg_14_0 then
				var_14_2.localPosition = Vector3.New(-390, -400, 0)
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				local var_14_5 = arg_11_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_14_5 then
					arg_11_1.var_.alphaOldValue1038 = var_14_5.alpha
					arg_11_1.var_.characterEffect1038 = var_14_5
				end

				arg_11_1.var_.alphaOldValue1038 = 0
			end

			local var_14_6 = 0.333333333333333

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_6 then
				if arg_11_1.var_.characterEffect1038 then
					arg_11_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_11_1.var_.alphaOldValue1038, 1, (arg_11_1.time_ - 0) / var_14_6)
				end
			end

			if arg_11_1.time_ >= 0 + var_14_6 and arg_11_1.time_ < 0 + var_14_6 + arg_14_0 and arg_11_1.var_.characterEffect1038 then
				arg_11_1.var_.characterEffect1038.alpha = 1
			end

			local var_14_7 = 0
			local var_14_8 = 0.4

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_7 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_9 = arg_11_1:GetWordFromCfg(115301003)
				local var_14_10 = arg_11_1:FormatText(var_14_9.content)

				arg_11_1.text_.text = var_14_10

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_12 = 16 <= 0 and var_14_8 or var_14_8 * (utf8.len(var_14_10) / 16)

				if (16 <= 0 and var_14_8 or var_14_8 * (utf8.len(var_14_10) / 16)) > 0 and var_14_8 < var_14_12 then
					arg_11_1.talkMaxDuration = var_14_12

					if var_14_12 + var_14_7 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_12 + var_14_7
					end
				end

				arg_11_1.text_.text = var_14_10
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301003", "story_v_out_115301.awb") ~= 0 then
					local var_14_13 = manager.audio:GetVoiceLength("story_v_out_115301", "115301003", "story_v_out_115301.awb") / 1000

					if var_14_13 + var_14_7 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_13 + var_14_7
					end

					if var_14_9.prefab_name ~= "" and arg_11_1.actors_[var_14_9.prefab_name] ~= nil then
						local var_14_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_9.prefab_name].transform, "story_v_out_115301", "115301003", "story_v_out_115301.awb")

						arg_11_1:RecordAudio("115301003", var_14_14)
						arg_11_1:RecordAudio("115301003", var_14_14)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_115301", "115301003", "story_v_out_115301.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_115301", "115301003", "story_v_out_115301.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_15 = math.max(var_14_8, arg_11_1.talkMaxDuration)

			if var_14_7 <= arg_11_1.time_ and arg_11_1.time_ < var_14_7 + var_14_15 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_7) / var_14_15

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_7 + var_14_15 and arg_11_1.time_ < var_14_7 + var_14_15 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_11_1:InitPlayNodeList()
	end,
	Play115301004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 115301004
		arg_15_1.duration_ = 3.43

		local var_15_0 = {
			ja = 3.433,
			ko = 1.966,
			zh = 2.233,
			en = 2.266
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
				arg_15_0:Play115301005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if arg_15_1.actors_["10030"] == nil then
				local var_18_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10030")

				if not isNil(var_18_0) then
					local var_18_1 = Object.Instantiate(var_18_0, arg_15_1.canvasGo_.transform)

					var_18_1.transform:SetSiblingIndex(1)

					var_18_1.name = "10030"
					var_18_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_15_1.actors_["10030"] = var_18_1

					if arg_15_1.isInRecall_ then
						for iter_18_0, iter_18_1 in ipairs((var_18_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_18_1.color = arg_15_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_18_2 = arg_15_1.actors_["10030"].transform

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos10030 = var_18_2.localPosition
				var_18_2.localScale = Vector3.New(1, 1, 1)

				arg_15_1:CheckSpriteTmpPos("10030", 4)

				for iter_18_2 = 0, var_18_2.childCount - 1 do
					local var_18_3 = var_18_2:GetChild(iter_18_2)

					if var_18_3.name == "split_1" or not string.find(var_18_3.name, "split") then
						var_18_3.gameObject:SetActive(true)
					else
						var_18_3.gameObject:SetActive(false)
					end
				end
			end

			local var_18_4 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_4 then
				var_18_2.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_15_1.time_ - 0) / var_18_4)
			end

			if arg_15_1.time_ >= 0 + var_18_4 and arg_15_1.time_ < 0 + var_18_4 + arg_18_0 then
				var_18_2.localPosition = Vector3.New(390, -390, 150)
			end

			local var_18_5 = arg_15_1.actors_["1038"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_5) and arg_15_1.var_.actorSpriteComps1038 == nil then
				arg_15_1.var_.actorSpriteComps1038 = var_18_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_18_6 = 0.2

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_6 and not isNil(var_18_5) then
				if arg_15_1.var_.actorSpriteComps1038 then
					for iter_18_3, iter_18_4 in pairs(arg_15_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_18_4 then
							if arg_15_1.isInRecall_ then
								iter_18_4.color = Color.New(Mathf.Lerp(iter_18_4.color.r, arg_15_1.hightColor2.r, (arg_15_1.time_ - 0) / var_18_6), Mathf.Lerp(iter_18_4.color.g, arg_15_1.hightColor2.g, (arg_15_1.time_ - 0) / var_18_6), (Mathf.Lerp(iter_18_4.color.b, arg_15_1.hightColor2.b, (arg_15_1.time_ - 0) / var_18_6)))
							else
								local var_18_7 = Mathf.Lerp(iter_18_4.color.r, 0.5, (arg_15_1.time_ - 0) / var_18_6)

								iter_18_4.color = Color.New(var_18_7, var_18_7, var_18_7)
							end
						end
					end
				end
			end

			if arg_15_1.time_ >= 0 + var_18_6 and arg_15_1.time_ < 0 + var_18_6 + arg_18_0 and not isNil(var_18_5) and arg_15_1.var_.actorSpriteComps1038 then
				for iter_18_5, iter_18_6 in pairs(arg_15_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_18_6 then
						iter_18_6.color = arg_15_1.isInRecall_ and (arg_15_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_15_1.var_.actorSpriteComps1038 = nil
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				local var_18_8 = arg_15_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_18_8 then
					arg_15_1.var_.alphaOldValue10030 = var_18_8.alpha
					arg_15_1.var_.characterEffect10030 = var_18_8
				end

				arg_15_1.var_.alphaOldValue10030 = 0
			end

			local var_18_9 = 0.333333333333333

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_9 then
				if arg_15_1.var_.characterEffect10030 then
					arg_15_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_15_1.var_.alphaOldValue10030, 1, (arg_15_1.time_ - 0) / var_18_9)
				end
			end

			if arg_15_1.time_ >= 0 + var_18_9 and arg_15_1.time_ < 0 + var_18_9 + arg_18_0 and arg_15_1.var_.characterEffect10030 then
				arg_15_1.var_.characterEffect10030.alpha = 1
			end

			local var_18_10 = 0
			local var_18_11 = 0.15

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_10 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_12 = arg_15_1:GetWordFromCfg(115301004)
				local var_18_13 = arg_15_1:FormatText(var_18_12.content)

				arg_15_1.text_.text = var_18_13

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_15 = 6 <= 0 and var_18_11 or var_18_11 * (utf8.len(var_18_13) / 6)

				if (6 <= 0 and var_18_11 or var_18_11 * (utf8.len(var_18_13) / 6)) > 0 and var_18_11 < var_18_15 then
					arg_15_1.talkMaxDuration = var_18_15

					if var_18_15 + var_18_10 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_15 + var_18_10
					end
				end

				arg_15_1.text_.text = var_18_13
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301004", "story_v_out_115301.awb") ~= 0 then
					local var_18_16 = manager.audio:GetVoiceLength("story_v_out_115301", "115301004", "story_v_out_115301.awb") / 1000

					if var_18_16 + var_18_10 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_16 + var_18_10
					end

					if var_18_12.prefab_name ~= "" and arg_15_1.actors_[var_18_12.prefab_name] ~= nil then
						local var_18_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_12.prefab_name].transform, "story_v_out_115301", "115301004", "story_v_out_115301.awb")

						arg_15_1:RecordAudio("115301004", var_18_17)
						arg_15_1:RecordAudio("115301004", var_18_17)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_115301", "115301004", "story_v_out_115301.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_115301", "115301004", "story_v_out_115301.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_18 = math.max(var_18_11, arg_15_1.talkMaxDuration)

			if var_18_10 <= arg_15_1.time_ and arg_15_1.time_ < var_18_10 + var_18_18 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_10) / var_18_18

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_10 + var_18_18 and arg_15_1.time_ < var_18_10 + var_18_18 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_15_1:InitPlayNodeList()
	end,
	Play115301005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 115301005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play115301006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				local var_22_0 = arg_19_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_22_0 then
					arg_19_1.var_.alphaOldValue10030 = var_22_0.alpha
					arg_19_1.var_.characterEffect10030 = var_22_0
				end

				arg_19_1.var_.alphaOldValue10030 = 1
			end

			local var_22_1 = 0.333333333333333

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_1 then
				if arg_19_1.var_.characterEffect10030 then
					arg_19_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_19_1.var_.alphaOldValue10030, 0, (arg_19_1.time_ - 0) / var_22_1)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_1 and arg_19_1.time_ < 0 + var_22_1 + arg_22_0 and arg_19_1.var_.characterEffect10030 then
				arg_19_1.var_.characterEffect10030.alpha = 0
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				local var_22_2 = arg_19_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_22_2 then
					arg_19_1.var_.alphaOldValue1038 = var_22_2.alpha
					arg_19_1.var_.characterEffect1038 = var_22_2
				end

				arg_19_1.var_.alphaOldValue1038 = 1
			end

			local var_22_3 = 0.333333333333333

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_3 then
				if arg_19_1.var_.characterEffect1038 then
					arg_19_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_19_1.var_.alphaOldValue1038, 0, (arg_19_1.time_ - 0) / var_22_3)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_3 and arg_19_1.time_ < 0 + var_22_3 + arg_22_0 and arg_19_1.var_.characterEffect1038 then
				arg_19_1.var_.characterEffect1038.alpha = 0
			end

			local var_22_4 = 0
			local var_22_5 = 0.5

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_4 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_6 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(115301005).content)

				arg_19_1.text_.text = var_22_6

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_8 = 20 <= 0 and var_22_5 or var_22_5 * (utf8.len(var_22_6) / 20)

				if (20 <= 0 and var_22_5 or var_22_5 * (utf8.len(var_22_6) / 20)) > 0 and var_22_5 < var_22_8 then
					arg_19_1.talkMaxDuration = var_22_8

					if var_22_8 + var_22_4 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_8 + var_22_4
					end
				end

				arg_19_1.text_.text = var_22_6
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_9 = math.max(var_22_5, arg_19_1.talkMaxDuration)

			if var_22_4 <= arg_19_1.time_ and arg_19_1.time_ < var_22_4 + var_22_9 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_4) / var_22_9

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_4 + var_22_9 and arg_19_1.time_ < var_22_4 + var_22_9 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play115301006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 115301006
		arg_23_1.duration_ = 5.77

		local var_23_0 = {
			ja = 3.233,
			ko = 4.566,
			zh = 4.366,
			en = 5.766
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
				arg_23_0:Play115301007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos10030 = arg_23_1.actors_["10030"].transform.localPosition
				arg_23_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_23_1:CheckSpriteTmpPos("10030", 3)

				for iter_26_0 = 0, arg_23_1.actors_["10030"].transform.childCount - 1 do
					local var_26_0 = arg_23_1.actors_["10030"].transform:GetChild(iter_26_0)

					if var_26_0.name == "split_2" or not string.find(var_26_0.name, "split") then
						var_26_0.gameObject:SetActive(true)
					else
						var_26_0.gameObject:SetActive(false)
					end
				end
			end

			local var_26_1 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_1 then
				arg_23_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_23_1.time_ - 0) / var_26_1)
			end

			if arg_23_1.time_ >= 0 + var_26_1 and arg_23_1.time_ < 0 + var_26_1 + arg_26_0 then
				arg_23_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				local var_26_2 = arg_23_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_26_2 then
					arg_23_1.var_.alphaOldValue10030 = var_26_2.alpha
					arg_23_1.var_.characterEffect10030 = var_26_2
				end

				arg_23_1.var_.alphaOldValue10030 = 0
			end

			local var_26_3 = 0.333333333333333

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_3 then
				if arg_23_1.var_.characterEffect10030 then
					arg_23_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_23_1.var_.alphaOldValue10030, 1, (arg_23_1.time_ - 0) / var_26_3)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_3 and arg_23_1.time_ < 0 + var_26_3 + arg_26_0 and arg_23_1.var_.characterEffect10030 then
				arg_23_1.var_.characterEffect10030.alpha = 1
			end

			local var_26_4 = 0
			local var_26_5 = 0.25

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_4 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_6 = arg_23_1:GetWordFromCfg(115301006)
				local var_26_7 = arg_23_1:FormatText(var_26_6.content)

				arg_23_1.text_.text = var_26_7

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_9 = 10 <= 0 and var_26_5 or var_26_5 * (utf8.len(var_26_7) / 10)

				if (10 <= 0 and var_26_5 or var_26_5 * (utf8.len(var_26_7) / 10)) > 0 and var_26_5 < var_26_9 then
					arg_23_1.talkMaxDuration = var_26_9

					if var_26_9 + var_26_4 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_9 + var_26_4
					end
				end

				arg_23_1.text_.text = var_26_7
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301006", "story_v_out_115301.awb") ~= 0 then
					local var_26_10 = manager.audio:GetVoiceLength("story_v_out_115301", "115301006", "story_v_out_115301.awb") / 1000

					if var_26_10 + var_26_4 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_10 + var_26_4
					end

					if var_26_6.prefab_name ~= "" and arg_23_1.actors_[var_26_6.prefab_name] ~= nil then
						local var_26_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_6.prefab_name].transform, "story_v_out_115301", "115301006", "story_v_out_115301.awb")

						arg_23_1:RecordAudio("115301006", var_26_11)
						arg_23_1:RecordAudio("115301006", var_26_11)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_115301", "115301006", "story_v_out_115301.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_115301", "115301006", "story_v_out_115301.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_12 = math.max(var_26_5, arg_23_1.talkMaxDuration)

			if var_26_4 <= arg_23_1.time_ and arg_23_1.time_ < var_26_4 + var_26_12 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_4) / var_26_12

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_4 + var_26_12 and arg_23_1.time_ < var_26_4 + var_26_12 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play115301007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 115301007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play115301008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				local var_30_0 = arg_27_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_30_0 then
					arg_27_1.var_.alphaOldValue10030 = var_30_0.alpha
					arg_27_1.var_.characterEffect10030 = var_30_0
				end

				arg_27_1.var_.alphaOldValue10030 = 1
			end

			local var_30_1 = 0.333333333333333

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_1 then
				if arg_27_1.var_.characterEffect10030 then
					arg_27_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_27_1.var_.alphaOldValue10030, 0, (arg_27_1.time_ - 0) / var_30_1)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_1 and arg_27_1.time_ < 0 + var_30_1 + arg_30_0 and arg_27_1.var_.characterEffect10030 then
				arg_27_1.var_.characterEffect10030.alpha = 0
			end

			local var_30_2 = 0
			local var_30_3 = 0.975

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_2 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, false)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_4 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(115301007).content)

				arg_27_1.text_.text = var_30_4

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_6 = 39 <= 0 and var_30_3 or var_30_3 * (utf8.len(var_30_4) / 39)

				if (39 <= 0 and var_30_3 or var_30_3 * (utf8.len(var_30_4) / 39)) > 0 and var_30_3 < var_30_6 then
					arg_27_1.talkMaxDuration = var_30_6

					if var_30_6 + var_30_2 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_6 + var_30_2
					end
				end

				arg_27_1.text_.text = var_30_4
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_7 = math.max(var_30_3, arg_27_1.talkMaxDuration)

			if var_30_2 <= arg_27_1.time_ and arg_27_1.time_ < var_30_2 + var_30_7 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_2) / var_30_7

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_2 + var_30_7 and arg_27_1.time_ < var_30_2 + var_30_7 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play115301008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 115301008
		arg_31_1.duration_ = 5.93

		local var_31_0 = {
			ja = 5.933,
			ko = 3.166,
			zh = 4.3,
			en = 5.6
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play115301009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos10030 = arg_31_1.actors_["10030"].transform.localPosition
				arg_31_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_31_1:CheckSpriteTmpPos("10030", 3)

				for iter_34_0 = 0, arg_31_1.actors_["10030"].transform.childCount - 1 do
					local var_34_0 = arg_31_1.actors_["10030"].transform:GetChild(iter_34_0)

					if var_34_0.name == "split_1" or not string.find(var_34_0.name, "split") then
						var_34_0.gameObject:SetActive(true)
					else
						var_34_0.gameObject:SetActive(false)
					end
				end
			end

			local var_34_1 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_1 then
				arg_31_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_31_1.time_ - 0) / var_34_1)
			end

			if arg_31_1.time_ >= 0 + var_34_1 and arg_31_1.time_ < 0 + var_34_1 + arg_34_0 then
				arg_31_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				local var_34_2 = arg_31_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_34_2 then
					arg_31_1.var_.alphaOldValue10030 = var_34_2.alpha
					arg_31_1.var_.characterEffect10030 = var_34_2
				end

				arg_31_1.var_.alphaOldValue10030 = 0
			end

			local var_34_3 = 0.333333333333333

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_3 then
				if arg_31_1.var_.characterEffect10030 then
					arg_31_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_31_1.var_.alphaOldValue10030, 1, (arg_31_1.time_ - 0) / var_34_3)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_3 and arg_31_1.time_ < 0 + var_34_3 + arg_34_0 and arg_31_1.var_.characterEffect10030 then
				arg_31_1.var_.characterEffect10030.alpha = 1
			end

			local var_34_4 = 0
			local var_34_5 = 0.35

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_4 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_6 = arg_31_1:GetWordFromCfg(115301008)
				local var_34_7 = arg_31_1:FormatText(var_34_6.content)

				arg_31_1.text_.text = var_34_7

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_9 = 14 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_7) / 14)

				if (14 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_7) / 14)) > 0 and var_34_5 < var_34_9 then
					arg_31_1.talkMaxDuration = var_34_9

					if var_34_9 + var_34_4 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_9 + var_34_4
					end
				end

				arg_31_1.text_.text = var_34_7
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301008", "story_v_out_115301.awb") ~= 0 then
					local var_34_10 = manager.audio:GetVoiceLength("story_v_out_115301", "115301008", "story_v_out_115301.awb") / 1000

					if var_34_10 + var_34_4 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_10 + var_34_4
					end

					if var_34_6.prefab_name ~= "" and arg_31_1.actors_[var_34_6.prefab_name] ~= nil then
						local var_34_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_6.prefab_name].transform, "story_v_out_115301", "115301008", "story_v_out_115301.awb")

						arg_31_1:RecordAudio("115301008", var_34_11)
						arg_31_1:RecordAudio("115301008", var_34_11)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_115301", "115301008", "story_v_out_115301.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_115301", "115301008", "story_v_out_115301.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_12 = math.max(var_34_5, arg_31_1.talkMaxDuration)

			if var_34_4 <= arg_31_1.time_ and arg_31_1.time_ < var_34_4 + var_34_12 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_4) / var_34_12

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_4 + var_34_12 and arg_31_1.time_ < var_34_4 + var_34_12 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play115301009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 115301009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play115301010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				local var_38_0 = arg_35_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_38_0 then
					arg_35_1.var_.alphaOldValue10030 = var_38_0.alpha
					arg_35_1.var_.characterEffect10030 = var_38_0
				end

				arg_35_1.var_.alphaOldValue10030 = 1
			end

			local var_38_1 = 0.333333333333333

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_1 then
				if arg_35_1.var_.characterEffect10030 then
					arg_35_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_35_1.var_.alphaOldValue10030, 0, (arg_35_1.time_ - 0) / var_38_1)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_1 and arg_35_1.time_ < 0 + var_38_1 + arg_38_0 and arg_35_1.var_.characterEffect10030 then
				arg_35_1.var_.characterEffect10030.alpha = 0
			end

			local var_38_2 = 0
			local var_38_3 = 1.375

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_2 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_4 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(115301009).content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_6 = 55 <= 0 and var_38_3 or var_38_3 * (utf8.len(var_38_4) / 55)

				if (55 <= 0 and var_38_3 or var_38_3 * (utf8.len(var_38_4) / 55)) > 0 and var_38_3 < var_38_6 then
					arg_35_1.talkMaxDuration = var_38_6

					if var_38_6 + var_38_2 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_6 + var_38_2
					end
				end

				arg_35_1.text_.text = var_38_4
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_7 = math.max(var_38_3, arg_35_1.talkMaxDuration)

			if var_38_2 <= arg_35_1.time_ and arg_35_1.time_ < var_38_2 + var_38_7 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_2) / var_38_7

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_2 + var_38_7 and arg_35_1.time_ < var_38_2 + var_38_7 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play115301010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 115301010
		arg_39_1.duration_ = 5.57

		local var_39_0 = {
			ja = 5.566,
			ko = 2.433,
			zh = 3.166,
			en = 1.766
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play115301011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1038 = arg_39_1.actors_["1038"].transform.localPosition
				arg_39_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_39_1:CheckSpriteTmpPos("1038", 3)

				for iter_42_0 = 0, arg_39_1.actors_["1038"].transform.childCount - 1 do
					local var_42_0 = arg_39_1.actors_["1038"].transform:GetChild(iter_42_0)

					if var_42_0.name == "split_1" or not string.find(var_42_0.name, "split") then
						var_42_0.gameObject:SetActive(true)
					else
						var_42_0.gameObject:SetActive(false)
					end
				end
			end

			local var_42_1 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_1 then
				arg_39_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1038, Vector3.New(0, -400, 0), (arg_39_1.time_ - 0) / var_42_1)
			end

			if arg_39_1.time_ >= 0 + var_42_1 and arg_39_1.time_ < 0 + var_42_1 + arg_42_0 then
				arg_39_1.actors_["1038"].transform.localPosition = Vector3.New(0, -400, 0)
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				local var_42_2 = arg_39_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_42_2 then
					arg_39_1.var_.alphaOldValue1038 = var_42_2.alpha
					arg_39_1.var_.characterEffect1038 = var_42_2
				end

				arg_39_1.var_.alphaOldValue1038 = 0
			end

			local var_42_3 = 0.333333333333333

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_3 then
				if arg_39_1.var_.characterEffect1038 then
					arg_39_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_39_1.var_.alphaOldValue1038, 1, (arg_39_1.time_ - 0) / var_42_3)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_3 and arg_39_1.time_ < 0 + var_42_3 + arg_42_0 and arg_39_1.var_.characterEffect1038 then
				arg_39_1.var_.characterEffect1038.alpha = 1
			end

			local var_42_4 = arg_39_1.actors_["1038"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_4) and arg_39_1.var_.actorSpriteComps1038 == nil then
				arg_39_1.var_.actorSpriteComps1038 = var_42_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_5 = 0.2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_5 and not isNil(var_42_4) then
				if arg_39_1.var_.actorSpriteComps1038 then
					for iter_42_1, iter_42_2 in pairs(arg_39_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_42_2 then
							if arg_39_1.isInRecall_ then
								iter_42_2.color = Color.New(Mathf.Lerp(iter_42_2.color.r, arg_39_1.hightColor1.r, (arg_39_1.time_ - 0) / var_42_5), Mathf.Lerp(iter_42_2.color.g, arg_39_1.hightColor1.g, (arg_39_1.time_ - 0) / var_42_5), (Mathf.Lerp(iter_42_2.color.b, arg_39_1.hightColor1.b, (arg_39_1.time_ - 0) / var_42_5)))
							else
								local var_42_6 = Mathf.Lerp(iter_42_2.color.r, 1, (arg_39_1.time_ - 0) / var_42_5)

								iter_42_2.color = Color.New(var_42_6, var_42_6, var_42_6)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= 0 + var_42_5 and arg_39_1.time_ < 0 + var_42_5 + arg_42_0 and not isNil(var_42_4) and arg_39_1.var_.actorSpriteComps1038 then
				for iter_42_3, iter_42_4 in pairs(arg_39_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_42_4 then
						iter_42_4.color = arg_39_1.isInRecall_ and (arg_39_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_39_1.var_.actorSpriteComps1038 = nil
			end

			local var_42_7 = 0
			local var_42_8 = 0.2

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_7 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_9 = arg_39_1:GetWordFromCfg(115301010)
				local var_42_10 = arg_39_1:FormatText(var_42_9.content)

				arg_39_1.text_.text = var_42_10

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_12 = 8 <= 0 and var_42_8 or var_42_8 * (utf8.len(var_42_10) / 8)

				if (8 <= 0 and var_42_8 or var_42_8 * (utf8.len(var_42_10) / 8)) > 0 and var_42_8 < var_42_12 then
					arg_39_1.talkMaxDuration = var_42_12

					if var_42_12 + var_42_7 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_12 + var_42_7
					end
				end

				arg_39_1.text_.text = var_42_10
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301010", "story_v_out_115301.awb") ~= 0 then
					local var_42_13 = manager.audio:GetVoiceLength("story_v_out_115301", "115301010", "story_v_out_115301.awb") / 1000

					if var_42_13 + var_42_7 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_13 + var_42_7
					end

					if var_42_9.prefab_name ~= "" and arg_39_1.actors_[var_42_9.prefab_name] ~= nil then
						local var_42_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_9.prefab_name].transform, "story_v_out_115301", "115301010", "story_v_out_115301.awb")

						arg_39_1:RecordAudio("115301010", var_42_14)
						arg_39_1:RecordAudio("115301010", var_42_14)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_115301", "115301010", "story_v_out_115301.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_115301", "115301010", "story_v_out_115301.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_15 = math.max(var_42_8, arg_39_1.talkMaxDuration)

			if var_42_7 <= arg_39_1.time_ and arg_39_1.time_ < var_42_7 + var_42_15 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_7) / var_42_15

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_7 + var_42_15 and arg_39_1.time_ < var_42_7 + var_42_15 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play115301011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 115301011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play115301012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				local var_46_0 = arg_43_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_46_0 then
					arg_43_1.var_.alphaOldValue1038 = var_46_0.alpha
					arg_43_1.var_.characterEffect1038 = var_46_0
				end

				arg_43_1.var_.alphaOldValue1038 = 1
			end

			local var_46_1 = 0.333333333333333

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_1 then
				if arg_43_1.var_.characterEffect1038 then
					arg_43_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_43_1.var_.alphaOldValue1038, 0, (arg_43_1.time_ - 0) / var_46_1)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_1 and arg_43_1.time_ < 0 + var_46_1 + arg_46_0 and arg_43_1.var_.characterEffect1038 then
				arg_43_1.var_.characterEffect1038.alpha = 0
			end

			local var_46_2 = 0
			local var_46_3 = 1.35

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_2 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_4 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(115301011).content)

				arg_43_1.text_.text = var_46_4

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_6 = 53 <= 0 and var_46_3 or var_46_3 * (utf8.len(var_46_4) / 53)

				if (53 <= 0 and var_46_3 or var_46_3 * (utf8.len(var_46_4) / 53)) > 0 and var_46_3 < var_46_6 then
					arg_43_1.talkMaxDuration = var_46_6

					if var_46_6 + var_46_2 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_6 + var_46_2
					end
				end

				arg_43_1.text_.text = var_46_4
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_7 = math.max(var_46_3, arg_43_1.talkMaxDuration)

			if var_46_2 <= arg_43_1.time_ and arg_43_1.time_ < var_46_2 + var_46_7 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_2) / var_46_7

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_2 + var_46_7 and arg_43_1.time_ < var_46_2 + var_46_7 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play115301012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 115301012
		arg_47_1.duration_ = 4.47

		local var_47_0 = {
			ja = 4.4,
			ko = 3.1,
			zh = 4.466,
			en = 2.7
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play115301013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos10030 = arg_47_1.actors_["10030"].transform.localPosition
				arg_47_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("10030", 4)

				for iter_50_0 = 0, arg_47_1.actors_["10030"].transform.childCount - 1 do
					local var_50_0 = arg_47_1.actors_["10030"].transform:GetChild(iter_50_0)

					if var_50_0.name == "split_3" or not string.find(var_50_0.name, "split") then
						var_50_0.gameObject:SetActive(true)
					else
						var_50_0.gameObject:SetActive(false)
					end
				end
			end

			local var_50_1 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_1 then
				arg_47_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_47_1.time_ - 0) / var_50_1)
			end

			if arg_47_1.time_ >= 0 + var_50_1 and arg_47_1.time_ < 0 + var_50_1 + arg_50_0 then
				arg_47_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				local var_50_2 = arg_47_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_50_2 then
					arg_47_1.var_.alphaOldValue10030 = var_50_2.alpha
					arg_47_1.var_.characterEffect10030 = var_50_2
				end

				arg_47_1.var_.alphaOldValue10030 = 0
			end

			local var_50_3 = 0.333333333333333

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_3 then
				if arg_47_1.var_.characterEffect10030 then
					arg_47_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_47_1.var_.alphaOldValue10030, 1, (arg_47_1.time_ - 0) / var_50_3)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_3 and arg_47_1.time_ < 0 + var_50_3 + arg_50_0 and arg_47_1.var_.characterEffect10030 then
				arg_47_1.var_.characterEffect10030.alpha = 1
			end

			local var_50_4 = arg_47_1.actors_["10030"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.actorSpriteComps10030 == nil then
				arg_47_1.var_.actorSpriteComps10030 = var_50_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_5 = 0.2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_5 and not isNil(var_50_4) then
				if arg_47_1.var_.actorSpriteComps10030 then
					for iter_50_1, iter_50_2 in pairs(arg_47_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_50_2 then
							if arg_47_1.isInRecall_ then
								iter_50_2.color = Color.New(Mathf.Lerp(iter_50_2.color.r, arg_47_1.hightColor1.r, (arg_47_1.time_ - 0) / var_50_5), Mathf.Lerp(iter_50_2.color.g, arg_47_1.hightColor1.g, (arg_47_1.time_ - 0) / var_50_5), (Mathf.Lerp(iter_50_2.color.b, arg_47_1.hightColor1.b, (arg_47_1.time_ - 0) / var_50_5)))
							else
								local var_50_6 = Mathf.Lerp(iter_50_2.color.r, 1, (arg_47_1.time_ - 0) / var_50_5)

								iter_50_2.color = Color.New(var_50_6, var_50_6, var_50_6)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= 0 + var_50_5 and arg_47_1.time_ < 0 + var_50_5 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.actorSpriteComps10030 then
				for iter_50_3, iter_50_4 in pairs(arg_47_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_50_4 then
						iter_50_4.color = arg_47_1.isInRecall_ and (arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_47_1.var_.actorSpriteComps10030 = nil
			end

			local var_50_7 = 0
			local var_50_8 = 1

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_7 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_9 = arg_47_1:GetWordFromCfg(115301012)
				local var_50_10 = arg_47_1:FormatText(var_50_9.content)

				arg_47_1.text_.text = var_50_10

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_12 = 11 <= 0 and var_50_8 or var_50_8 * (utf8.len(var_50_10) / 11)

				if (11 <= 0 and var_50_8 or var_50_8 * (utf8.len(var_50_10) / 11)) > 0 and var_50_8 < var_50_12 then
					arg_47_1.talkMaxDuration = var_50_12

					if var_50_12 + var_50_7 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_12 + var_50_7
					end
				end

				arg_47_1.text_.text = var_50_10
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301012", "story_v_out_115301.awb") ~= 0 then
					local var_50_13 = manager.audio:GetVoiceLength("story_v_out_115301", "115301012", "story_v_out_115301.awb") / 1000

					if var_50_13 + var_50_7 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_13 + var_50_7
					end

					if var_50_9.prefab_name ~= "" and arg_47_1.actors_[var_50_9.prefab_name] ~= nil then
						local var_50_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_9.prefab_name].transform, "story_v_out_115301", "115301012", "story_v_out_115301.awb")

						arg_47_1:RecordAudio("115301012", var_50_14)
						arg_47_1:RecordAudio("115301012", var_50_14)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_115301", "115301012", "story_v_out_115301.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_115301", "115301012", "story_v_out_115301.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_15 = math.max(var_50_8, arg_47_1.talkMaxDuration)

			if var_50_7 <= arg_47_1.time_ and arg_47_1.time_ < var_50_7 + var_50_15 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_7) / var_50_15

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_7 + var_50_15 and arg_47_1.time_ < var_50_7 + var_50_15 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play115301013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 115301013
		arg_51_1.duration_ = 3.27

		local var_51_0 = {
			ja = 1.733,
			ko = 1.466,
			zh = 2.533,
			en = 3.266
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play115301014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1038 = arg_51_1.actors_["1038"].transform.localPosition
				arg_51_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("1038", 2)

				for iter_54_0 = 0, arg_51_1.actors_["1038"].transform.childCount - 1 do
					local var_54_0 = arg_51_1.actors_["1038"].transform:GetChild(iter_54_0)

					if var_54_0.name == "split_1" or not string.find(var_54_0.name, "split") then
						var_54_0.gameObject:SetActive(true)
					else
						var_54_0.gameObject:SetActive(false)
					end
				end
			end

			local var_54_1 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_1 then
				arg_51_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_51_1.time_ - 0) / var_54_1)
			end

			if arg_51_1.time_ >= 0 + var_54_1 and arg_51_1.time_ < 0 + var_54_1 + arg_54_0 then
				arg_51_1.actors_["1038"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_54_2 = arg_51_1.actors_["10030"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.actorSpriteComps10030 == nil then
				arg_51_1.var_.actorSpriteComps10030 = var_54_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_3 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_3 and not isNil(var_54_2) then
				if arg_51_1.var_.actorSpriteComps10030 then
					for iter_54_1, iter_54_2 in pairs(arg_51_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_54_2 then
							if arg_51_1.isInRecall_ then
								iter_54_2.color = Color.New(Mathf.Lerp(iter_54_2.color.r, arg_51_1.hightColor2.r, (arg_51_1.time_ - 0) / var_54_3), Mathf.Lerp(iter_54_2.color.g, arg_51_1.hightColor2.g, (arg_51_1.time_ - 0) / var_54_3), (Mathf.Lerp(iter_54_2.color.b, arg_51_1.hightColor2.b, (arg_51_1.time_ - 0) / var_54_3)))
							else
								local var_54_4 = Mathf.Lerp(iter_54_2.color.r, 0.5, (arg_51_1.time_ - 0) / var_54_3)

								iter_54_2.color = Color.New(var_54_4, var_54_4, var_54_4)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= 0 + var_54_3 and arg_51_1.time_ < 0 + var_54_3 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.actorSpriteComps10030 then
				for iter_54_3, iter_54_4 in pairs(arg_51_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_54_4 then
						iter_54_4.color = arg_51_1.isInRecall_ and (arg_51_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_51_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				local var_54_5 = arg_51_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_54_5 then
					arg_51_1.var_.alphaOldValue1038 = var_54_5.alpha
					arg_51_1.var_.characterEffect1038 = var_54_5
				end

				arg_51_1.var_.alphaOldValue1038 = 0
			end

			local var_54_6 = 0.333333333333333

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_6 then
				if arg_51_1.var_.characterEffect1038 then
					arg_51_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_51_1.var_.alphaOldValue1038, 1, (arg_51_1.time_ - 0) / var_54_6)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_6 and arg_51_1.time_ < 0 + var_54_6 + arg_54_0 and arg_51_1.var_.characterEffect1038 then
				arg_51_1.var_.characterEffect1038.alpha = 1
			end

			local var_54_7 = arg_51_1.actors_["1038"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_7) and arg_51_1.var_.actorSpriteComps1038 == nil then
				arg_51_1.var_.actorSpriteComps1038 = var_54_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_8 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_8 and not isNil(var_54_7) then
				if arg_51_1.var_.actorSpriteComps1038 then
					for iter_54_5, iter_54_6 in pairs(arg_51_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_54_6 then
							if arg_51_1.isInRecall_ then
								iter_54_6.color = Color.New(Mathf.Lerp(iter_54_6.color.r, arg_51_1.hightColor1.r, (arg_51_1.time_ - 0) / var_54_8), Mathf.Lerp(iter_54_6.color.g, arg_51_1.hightColor1.g, (arg_51_1.time_ - 0) / var_54_8), (Mathf.Lerp(iter_54_6.color.b, arg_51_1.hightColor1.b, (arg_51_1.time_ - 0) / var_54_8)))
							else
								local var_54_9 = Mathf.Lerp(iter_54_6.color.r, 1, (arg_51_1.time_ - 0) / var_54_8)

								iter_54_6.color = Color.New(var_54_9, var_54_9, var_54_9)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= 0 + var_54_8 and arg_51_1.time_ < 0 + var_54_8 + arg_54_0 and not isNil(var_54_7) and arg_51_1.var_.actorSpriteComps1038 then
				for iter_54_7, iter_54_8 in pairs(arg_51_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_54_8 then
						iter_54_8.color = arg_51_1.isInRecall_ and (arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_51_1.var_.actorSpriteComps1038 = nil
			end

			local var_54_10 = 0
			local var_54_11 = 0.15

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_10 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_12 = arg_51_1:GetWordFromCfg(115301013)
				local var_54_13 = arg_51_1:FormatText(var_54_12.content)

				arg_51_1.text_.text = var_54_13

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_15 = 6 <= 0 and var_54_11 or var_54_11 * (utf8.len(var_54_13) / 6)

				if (6 <= 0 and var_54_11 or var_54_11 * (utf8.len(var_54_13) / 6)) > 0 and var_54_11 < var_54_15 then
					arg_51_1.talkMaxDuration = var_54_15

					if var_54_15 + var_54_10 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_15 + var_54_10
					end
				end

				arg_51_1.text_.text = var_54_13
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301013", "story_v_out_115301.awb") ~= 0 then
					local var_54_16 = manager.audio:GetVoiceLength("story_v_out_115301", "115301013", "story_v_out_115301.awb") / 1000

					if var_54_16 + var_54_10 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_16 + var_54_10
					end

					if var_54_12.prefab_name ~= "" and arg_51_1.actors_[var_54_12.prefab_name] ~= nil then
						local var_54_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_12.prefab_name].transform, "story_v_out_115301", "115301013", "story_v_out_115301.awb")

						arg_51_1:RecordAudio("115301013", var_54_17)
						arg_51_1:RecordAudio("115301013", var_54_17)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_115301", "115301013", "story_v_out_115301.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_115301", "115301013", "story_v_out_115301.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_18 = math.max(var_54_11, arg_51_1.talkMaxDuration)

			if var_54_10 <= arg_51_1.time_ and arg_51_1.time_ < var_54_10 + var_54_18 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_10) / var_54_18

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_10 + var_54_18 and arg_51_1.time_ < var_54_10 + var_54_18 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play115301014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 115301014
		arg_55_1.duration_ = 2.73

		local var_55_0 = {
			ja = 2.733,
			ko = 1.8,
			zh = 2.066,
			en = 2.533
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play115301015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["1038"]) and arg_55_1.var_.actorSpriteComps1038 == nil then
				arg_55_1.var_.actorSpriteComps1038 = arg_55_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_0 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["1038"]) then
				if arg_55_1.var_.actorSpriteComps1038 then
					for iter_58_0, iter_58_1 in pairs(arg_55_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_58_1 then
							if arg_55_1.isInRecall_ then
								iter_58_1.color = Color.New(Mathf.Lerp(iter_58_1.color.r, arg_55_1.hightColor2.r, (arg_55_1.time_ - 0) / var_58_0), Mathf.Lerp(iter_58_1.color.g, arg_55_1.hightColor2.g, (arg_55_1.time_ - 0) / var_58_0), (Mathf.Lerp(iter_58_1.color.b, arg_55_1.hightColor2.b, (arg_55_1.time_ - 0) / var_58_0)))
							else
								local var_58_1 = Mathf.Lerp(iter_58_1.color.r, 0.5, (arg_55_1.time_ - 0) / var_58_0)

								iter_58_1.color = Color.New(var_58_1, var_58_1, var_58_1)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["1038"]) and arg_55_1.var_.actorSpriteComps1038 then
				for iter_58_2, iter_58_3 in pairs(arg_55_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_58_3 then
						iter_58_3.color = arg_55_1.isInRecall_ and (arg_55_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_55_1.var_.actorSpriteComps1038 = nil
			end

			local var_58_2 = arg_55_1.actors_["10030"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.actorSpriteComps10030 == nil then
				arg_55_1.var_.actorSpriteComps10030 = var_58_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_3 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_3 and not isNil(var_58_2) then
				if arg_55_1.var_.actorSpriteComps10030 then
					for iter_58_4, iter_58_5 in pairs(arg_55_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_58_5 then
							if arg_55_1.isInRecall_ then
								iter_58_5.color = Color.New(Mathf.Lerp(iter_58_5.color.r, arg_55_1.hightColor1.r, (arg_55_1.time_ - 0) / var_58_3), Mathf.Lerp(iter_58_5.color.g, arg_55_1.hightColor1.g, (arg_55_1.time_ - 0) / var_58_3), (Mathf.Lerp(iter_58_5.color.b, arg_55_1.hightColor1.b, (arg_55_1.time_ - 0) / var_58_3)))
							else
								local var_58_4 = Mathf.Lerp(iter_58_5.color.r, 1, (arg_55_1.time_ - 0) / var_58_3)

								iter_58_5.color = Color.New(var_58_4, var_58_4, var_58_4)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= 0 + var_58_3 and arg_55_1.time_ < 0 + var_58_3 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.actorSpriteComps10030 then
				for iter_58_6, iter_58_7 in pairs(arg_55_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_58_7 then
						iter_58_7.color = arg_55_1.isInRecall_ and (arg_55_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_55_1.var_.actorSpriteComps10030 = nil
			end

			local var_58_5 = 0
			local var_58_6 = 0.2

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_5 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_7 = arg_55_1:GetWordFromCfg(115301014)
				local var_58_8 = arg_55_1:FormatText(var_58_7.content)

				arg_55_1.text_.text = var_58_8

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_10 = 8 <= 0 and var_58_6 or var_58_6 * (utf8.len(var_58_8) / 8)

				if (8 <= 0 and var_58_6 or var_58_6 * (utf8.len(var_58_8) / 8)) > 0 and var_58_6 < var_58_10 then
					arg_55_1.talkMaxDuration = var_58_10

					if var_58_10 + var_58_5 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_5
					end
				end

				arg_55_1.text_.text = var_58_8
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301014", "story_v_out_115301.awb") ~= 0 then
					local var_58_11 = manager.audio:GetVoiceLength("story_v_out_115301", "115301014", "story_v_out_115301.awb") / 1000

					if var_58_11 + var_58_5 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_11 + var_58_5
					end

					if var_58_7.prefab_name ~= "" and arg_55_1.actors_[var_58_7.prefab_name] ~= nil then
						local var_58_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_7.prefab_name].transform, "story_v_out_115301", "115301014", "story_v_out_115301.awb")

						arg_55_1:RecordAudio("115301014", var_58_12)
						arg_55_1:RecordAudio("115301014", var_58_12)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_115301", "115301014", "story_v_out_115301.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_115301", "115301014", "story_v_out_115301.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_13 = math.max(var_58_6, arg_55_1.talkMaxDuration)

			if var_58_5 <= arg_55_1.time_ and arg_55_1.time_ < var_58_5 + var_58_13 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_5) / var_58_13

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_5 + var_58_13 and arg_55_1.time_ < var_58_5 + var_58_13 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play115301015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 115301015
		arg_59_1.duration_ = 10.1

		local var_59_0 = {
			ja = 10.1,
			ko = 8,
			zh = 5.033,
			en = 5.533
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play115301016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.575

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_1 = arg_59_1:GetWordFromCfg(115301015)
				local var_62_2 = arg_59_1:FormatText(var_62_1.content)

				arg_59_1.text_.text = var_62_2

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 23 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 23)

				if (23 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 23)) > 0 and var_62_0 < var_62_4 then
					arg_59_1.talkMaxDuration = var_62_4

					if var_62_4 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_4 + 0
					end
				end

				arg_59_1.text_.text = var_62_2
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301015", "story_v_out_115301.awb") ~= 0 then
					local var_62_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301015", "story_v_out_115301.awb") / 1000

					if var_62_5 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + 0
					end

					if var_62_1.prefab_name ~= "" and arg_59_1.actors_[var_62_1.prefab_name] ~= nil then
						local var_62_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_1.prefab_name].transform, "story_v_out_115301", "115301015", "story_v_out_115301.awb")

						arg_59_1:RecordAudio("115301015", var_62_6)
						arg_59_1:RecordAudio("115301015", var_62_6)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_115301", "115301015", "story_v_out_115301.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_115301", "115301015", "story_v_out_115301.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play115301016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 115301016
		arg_63_1.duration_ = 9.7

		local var_63_0 = {
			ja = 3.5,
			ko = 5.833,
			zh = 9.7,
			en = 7.1
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play115301017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1038"]) and arg_63_1.var_.actorSpriteComps1038 == nil then
				arg_63_1.var_.actorSpriteComps1038 = arg_63_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_0 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1038"]) then
				if arg_63_1.var_.actorSpriteComps1038 then
					for iter_66_0, iter_66_1 in pairs(arg_63_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_66_1 then
							if arg_63_1.isInRecall_ then
								iter_66_1.color = Color.New(Mathf.Lerp(iter_66_1.color.r, arg_63_1.hightColor1.r, (arg_63_1.time_ - 0) / var_66_0), Mathf.Lerp(iter_66_1.color.g, arg_63_1.hightColor1.g, (arg_63_1.time_ - 0) / var_66_0), (Mathf.Lerp(iter_66_1.color.b, arg_63_1.hightColor1.b, (arg_63_1.time_ - 0) / var_66_0)))
							else
								local var_66_1 = Mathf.Lerp(iter_66_1.color.r, 1, (arg_63_1.time_ - 0) / var_66_0)

								iter_66_1.color = Color.New(var_66_1, var_66_1, var_66_1)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1038"]) and arg_63_1.var_.actorSpriteComps1038 then
				for iter_66_2, iter_66_3 in pairs(arg_63_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_66_3 then
						iter_66_3.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_63_1.var_.actorSpriteComps1038 = nil
			end

			local var_66_2 = arg_63_1.actors_["10030"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.actorSpriteComps10030 == nil then
				arg_63_1.var_.actorSpriteComps10030 = var_66_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_3 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_3 and not isNil(var_66_2) then
				if arg_63_1.var_.actorSpriteComps10030 then
					for iter_66_4, iter_66_5 in pairs(arg_63_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_66_5 then
							if arg_63_1.isInRecall_ then
								iter_66_5.color = Color.New(Mathf.Lerp(iter_66_5.color.r, arg_63_1.hightColor2.r, (arg_63_1.time_ - 0) / var_66_3), Mathf.Lerp(iter_66_5.color.g, arg_63_1.hightColor2.g, (arg_63_1.time_ - 0) / var_66_3), (Mathf.Lerp(iter_66_5.color.b, arg_63_1.hightColor2.b, (arg_63_1.time_ - 0) / var_66_3)))
							else
								local var_66_4 = Mathf.Lerp(iter_66_5.color.r, 0.5, (arg_63_1.time_ - 0) / var_66_3)

								iter_66_5.color = Color.New(var_66_4, var_66_4, var_66_4)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 0 + var_66_3 and arg_63_1.time_ < 0 + var_66_3 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.actorSpriteComps10030 then
				for iter_66_6, iter_66_7 in pairs(arg_63_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_66_7 then
						iter_66_7.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_63_1.var_.actorSpriteComps10030 = nil
			end

			local var_66_5 = 0
			local var_66_6 = 0.725

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_5 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_7 = arg_63_1:GetWordFromCfg(115301016)
				local var_66_8 = arg_63_1:FormatText(var_66_7.content)

				arg_63_1.text_.text = var_66_8

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_10 = 28 <= 0 and var_66_6 or var_66_6 * (utf8.len(var_66_8) / 28)

				if (28 <= 0 and var_66_6 or var_66_6 * (utf8.len(var_66_8) / 28)) > 0 and var_66_6 < var_66_10 then
					arg_63_1.talkMaxDuration = var_66_10

					if var_66_10 + var_66_5 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_5
					end
				end

				arg_63_1.text_.text = var_66_8
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301016", "story_v_out_115301.awb") ~= 0 then
					local var_66_11 = manager.audio:GetVoiceLength("story_v_out_115301", "115301016", "story_v_out_115301.awb") / 1000

					if var_66_11 + var_66_5 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_11 + var_66_5
					end

					if var_66_7.prefab_name ~= "" and arg_63_1.actors_[var_66_7.prefab_name] ~= nil then
						local var_66_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_7.prefab_name].transform, "story_v_out_115301", "115301016", "story_v_out_115301.awb")

						arg_63_1:RecordAudio("115301016", var_66_12)
						arg_63_1:RecordAudio("115301016", var_66_12)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_115301", "115301016", "story_v_out_115301.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_115301", "115301016", "story_v_out_115301.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_13 = math.max(var_66_6, arg_63_1.talkMaxDuration)

			if var_66_5 <= arg_63_1.time_ and arg_63_1.time_ < var_66_5 + var_66_13 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_5) / var_66_13

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_5 + var_66_13 and arg_63_1.time_ < var_66_5 + var_66_13 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play115301017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 115301017
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play115301018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1038"]) and arg_67_1.var_.actorSpriteComps1038 == nil then
				arg_67_1.var_.actorSpriteComps1038 = arg_67_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_0 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1038"]) then
				if arg_67_1.var_.actorSpriteComps1038 then
					for iter_70_0, iter_70_1 in pairs(arg_67_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_70_1 then
							if arg_67_1.isInRecall_ then
								iter_70_1.color = Color.New(Mathf.Lerp(iter_70_1.color.r, arg_67_1.hightColor2.r, (arg_67_1.time_ - 0) / var_70_0), Mathf.Lerp(iter_70_1.color.g, arg_67_1.hightColor2.g, (arg_67_1.time_ - 0) / var_70_0), (Mathf.Lerp(iter_70_1.color.b, arg_67_1.hightColor2.b, (arg_67_1.time_ - 0) / var_70_0)))
							else
								local var_70_1 = Mathf.Lerp(iter_70_1.color.r, 0.5, (arg_67_1.time_ - 0) / var_70_0)

								iter_70_1.color = Color.New(var_70_1, var_70_1, var_70_1)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1038"]) and arg_67_1.var_.actorSpriteComps1038 then
				for iter_70_2, iter_70_3 in pairs(arg_67_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_70_3 then
						iter_70_3.color = arg_67_1.isInRecall_ and (arg_67_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_67_1.var_.actorSpriteComps1038 = nil
			end

			local var_70_2 = 0
			local var_70_3 = 0.9

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_2 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_4 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(115301017).content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_6 = 36 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_4) / 36)

				if (36 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_4) / 36)) > 0 and var_70_3 < var_70_6 then
					arg_67_1.talkMaxDuration = var_70_6

					if var_70_6 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_6 + var_70_2
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_7 = math.max(var_70_3, arg_67_1.talkMaxDuration)

			if var_70_2 <= arg_67_1.time_ and arg_67_1.time_ < var_70_2 + var_70_7 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_2) / var_70_7

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_2 + var_70_7 and arg_67_1.time_ < var_70_2 + var_70_7 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play115301018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 115301018
		arg_71_1.duration_ = 5.83

		local var_71_0 = {
			ja = 5.833,
			ko = 4.5,
			zh = 4.866,
			en = 3.166
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play115301019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos10030 = arg_71_1.actors_["10030"].transform.localPosition
				arg_71_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("10030", 4)

				for iter_74_0 = 0, arg_71_1.actors_["10030"].transform.childCount - 1 do
					local var_74_0 = arg_71_1.actors_["10030"].transform:GetChild(iter_74_0)

					if var_74_0.name == "split_5" or not string.find(var_74_0.name, "split") then
						var_74_0.gameObject:SetActive(true)
					else
						var_74_0.gameObject:SetActive(false)
					end
				end
			end

			local var_74_1 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_1 then
				arg_71_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_71_1.time_ - 0) / var_74_1)
			end

			if arg_71_1.time_ >= 0 + var_74_1 and arg_71_1.time_ < 0 + var_74_1 + arg_74_0 then
				arg_71_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			local var_74_2 = arg_71_1.actors_["10030"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.actorSpriteComps10030 == nil then
				arg_71_1.var_.actorSpriteComps10030 = var_74_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_3 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_3 and not isNil(var_74_2) then
				if arg_71_1.var_.actorSpriteComps10030 then
					for iter_74_1, iter_74_2 in pairs(arg_71_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_74_2 then
							if arg_71_1.isInRecall_ then
								iter_74_2.color = Color.New(Mathf.Lerp(iter_74_2.color.r, arg_71_1.hightColor1.r, (arg_71_1.time_ - 0) / var_74_3), Mathf.Lerp(iter_74_2.color.g, arg_71_1.hightColor1.g, (arg_71_1.time_ - 0) / var_74_3), (Mathf.Lerp(iter_74_2.color.b, arg_71_1.hightColor1.b, (arg_71_1.time_ - 0) / var_74_3)))
							else
								local var_74_4 = Mathf.Lerp(iter_74_2.color.r, 1, (arg_71_1.time_ - 0) / var_74_3)

								iter_74_2.color = Color.New(var_74_4, var_74_4, var_74_4)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= 0 + var_74_3 and arg_71_1.time_ < 0 + var_74_3 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.actorSpriteComps10030 then
				for iter_74_3, iter_74_4 in pairs(arg_71_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_74_4 then
						iter_74_4.color = arg_71_1.isInRecall_ and (arg_71_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_71_1.var_.actorSpriteComps10030 = nil
			end

			local var_74_5 = 0
			local var_74_6 = 0.45

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_5 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_7 = arg_71_1:GetWordFromCfg(115301018)
				local var_74_8 = arg_71_1:FormatText(var_74_7.content)

				arg_71_1.text_.text = var_74_8

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_10 = 18 <= 0 and var_74_6 or var_74_6 * (utf8.len(var_74_8) / 18)

				if (18 <= 0 and var_74_6 or var_74_6 * (utf8.len(var_74_8) / 18)) > 0 and var_74_6 < var_74_10 then
					arg_71_1.talkMaxDuration = var_74_10

					if var_74_10 + var_74_5 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_5
					end
				end

				arg_71_1.text_.text = var_74_8
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301018", "story_v_out_115301.awb") ~= 0 then
					local var_74_11 = manager.audio:GetVoiceLength("story_v_out_115301", "115301018", "story_v_out_115301.awb") / 1000

					if var_74_11 + var_74_5 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_11 + var_74_5
					end

					if var_74_7.prefab_name ~= "" and arg_71_1.actors_[var_74_7.prefab_name] ~= nil then
						local var_74_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_7.prefab_name].transform, "story_v_out_115301", "115301018", "story_v_out_115301.awb")

						arg_71_1:RecordAudio("115301018", var_74_12)
						arg_71_1:RecordAudio("115301018", var_74_12)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_115301", "115301018", "story_v_out_115301.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_115301", "115301018", "story_v_out_115301.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_13 = math.max(var_74_6, arg_71_1.talkMaxDuration)

			if var_74_5 <= arg_71_1.time_ and arg_71_1.time_ < var_74_5 + var_74_13 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_5) / var_74_13

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_5 + var_74_13 and arg_71_1.time_ < var_74_5 + var_74_13 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play115301019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 115301019
		arg_75_1.duration_ = 7.77

		local var_75_0 = {
			ja = 7.766,
			ko = 6.166,
			zh = 6.366,
			en = 4.466
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play115301020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["10030"]) and arg_75_1.var_.actorSpriteComps10030 == nil then
				arg_75_1.var_.actorSpriteComps10030 = arg_75_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_0 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["10030"]) then
				if arg_75_1.var_.actorSpriteComps10030 then
					for iter_78_0, iter_78_1 in pairs(arg_75_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_78_1 then
							if arg_75_1.isInRecall_ then
								iter_78_1.color = Color.New(Mathf.Lerp(iter_78_1.color.r, arg_75_1.hightColor2.r, (arg_75_1.time_ - 0) / var_78_0), Mathf.Lerp(iter_78_1.color.g, arg_75_1.hightColor2.g, (arg_75_1.time_ - 0) / var_78_0), (Mathf.Lerp(iter_78_1.color.b, arg_75_1.hightColor2.b, (arg_75_1.time_ - 0) / var_78_0)))
							else
								local var_78_1 = Mathf.Lerp(iter_78_1.color.r, 0.5, (arg_75_1.time_ - 0) / var_78_0)

								iter_78_1.color = Color.New(var_78_1, var_78_1, var_78_1)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["10030"]) and arg_75_1.var_.actorSpriteComps10030 then
				for iter_78_2, iter_78_3 in pairs(arg_75_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_78_3 then
						iter_78_3.color = arg_75_1.isInRecall_ and (arg_75_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_75_1.var_.actorSpriteComps10030 = nil
			end

			local var_78_2 = arg_75_1.actors_["1038"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1038 = var_78_2.localPosition
				var_78_2.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("1038", 2)

				for iter_78_4 = 0, var_78_2.childCount - 1 do
					local var_78_3 = var_78_2:GetChild(iter_78_4)

					if var_78_3.name == "split_1" or not string.find(var_78_3.name, "split") then
						var_78_3.gameObject:SetActive(true)
					else
						var_78_3.gameObject:SetActive(false)
					end
				end
			end

			local var_78_4 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				var_78_2.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_75_1.time_ - 0) / var_78_4)
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				var_78_2.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_78_5 = arg_75_1.actors_["1038"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_5) and arg_75_1.var_.actorSpriteComps1038 == nil then
				arg_75_1.var_.actorSpriteComps1038 = var_78_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_6 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_6 and not isNil(var_78_5) then
				if arg_75_1.var_.actorSpriteComps1038 then
					for iter_78_5, iter_78_6 in pairs(arg_75_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_78_6 then
							if arg_75_1.isInRecall_ then
								iter_78_6.color = Color.New(Mathf.Lerp(iter_78_6.color.r, arg_75_1.hightColor1.r, (arg_75_1.time_ - 0) / var_78_6), Mathf.Lerp(iter_78_6.color.g, arg_75_1.hightColor1.g, (arg_75_1.time_ - 0) / var_78_6), (Mathf.Lerp(iter_78_6.color.b, arg_75_1.hightColor1.b, (arg_75_1.time_ - 0) / var_78_6)))
							else
								local var_78_7 = Mathf.Lerp(iter_78_6.color.r, 1, (arg_75_1.time_ - 0) / var_78_6)

								iter_78_6.color = Color.New(var_78_7, var_78_7, var_78_7)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= 0 + var_78_6 and arg_75_1.time_ < 0 + var_78_6 + arg_78_0 and not isNil(var_78_5) and arg_75_1.var_.actorSpriteComps1038 then
				for iter_78_7, iter_78_8 in pairs(arg_75_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_78_8 then
						iter_78_8.color = arg_75_1.isInRecall_ and (arg_75_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_75_1.var_.actorSpriteComps1038 = nil
			end

			local var_78_8 = 0
			local var_78_9 = 0.475

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_8 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_10 = arg_75_1:GetWordFromCfg(115301019)
				local var_78_11 = arg_75_1:FormatText(var_78_10.content)

				arg_75_1.text_.text = var_78_11

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_13 = 19 <= 0 and var_78_9 or var_78_9 * (utf8.len(var_78_11) / 19)

				if (19 <= 0 and var_78_9 or var_78_9 * (utf8.len(var_78_11) / 19)) > 0 and var_78_9 < var_78_13 then
					arg_75_1.talkMaxDuration = var_78_13

					if var_78_13 + var_78_8 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_13 + var_78_8
					end
				end

				arg_75_1.text_.text = var_78_11
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301019", "story_v_out_115301.awb") ~= 0 then
					local var_78_14 = manager.audio:GetVoiceLength("story_v_out_115301", "115301019", "story_v_out_115301.awb") / 1000

					if var_78_14 + var_78_8 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_14 + var_78_8
					end

					if var_78_10.prefab_name ~= "" and arg_75_1.actors_[var_78_10.prefab_name] ~= nil then
						local var_78_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_10.prefab_name].transform, "story_v_out_115301", "115301019", "story_v_out_115301.awb")

						arg_75_1:RecordAudio("115301019", var_78_15)
						arg_75_1:RecordAudio("115301019", var_78_15)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_115301", "115301019", "story_v_out_115301.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_115301", "115301019", "story_v_out_115301.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_16 = math.max(var_78_9, arg_75_1.talkMaxDuration)

			if var_78_8 <= arg_75_1.time_ and arg_75_1.time_ < var_78_8 + var_78_16 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_8) / var_78_16

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_8 + var_78_16 and arg_75_1.time_ < var_78_8 + var_78_16 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play115301020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 115301020
		arg_79_1.duration_ = 4.03

		local var_79_0 = {
			ja = 2.733,
			ko = 3.366,
			zh = 4.033,
			en = 3.3
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play115301021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1038"]) and arg_79_1.var_.actorSpriteComps1038 == nil then
				arg_79_1.var_.actorSpriteComps1038 = arg_79_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_0 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1038"]) then
				if arg_79_1.var_.actorSpriteComps1038 then
					for iter_82_0, iter_82_1 in pairs(arg_79_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_82_1 then
							if arg_79_1.isInRecall_ then
								iter_82_1.color = Color.New(Mathf.Lerp(iter_82_1.color.r, arg_79_1.hightColor2.r, (arg_79_1.time_ - 0) / var_82_0), Mathf.Lerp(iter_82_1.color.g, arg_79_1.hightColor2.g, (arg_79_1.time_ - 0) / var_82_0), (Mathf.Lerp(iter_82_1.color.b, arg_79_1.hightColor2.b, (arg_79_1.time_ - 0) / var_82_0)))
							else
								local var_82_1 = Mathf.Lerp(iter_82_1.color.r, 0.5, (arg_79_1.time_ - 0) / var_82_0)

								iter_82_1.color = Color.New(var_82_1, var_82_1, var_82_1)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1038"]) and arg_79_1.var_.actorSpriteComps1038 then
				for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_82_3 then
						iter_82_3.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_79_1.var_.actorSpriteComps1038 = nil
			end

			local var_82_2 = arg_79_1.actors_["10030"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.actorSpriteComps10030 == nil then
				arg_79_1.var_.actorSpriteComps10030 = var_82_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_3 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_3 and not isNil(var_82_2) then
				if arg_79_1.var_.actorSpriteComps10030 then
					for iter_82_4, iter_82_5 in pairs(arg_79_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_82_5 then
							if arg_79_1.isInRecall_ then
								iter_82_5.color = Color.New(Mathf.Lerp(iter_82_5.color.r, arg_79_1.hightColor1.r, (arg_79_1.time_ - 0) / var_82_3), Mathf.Lerp(iter_82_5.color.g, arg_79_1.hightColor1.g, (arg_79_1.time_ - 0) / var_82_3), (Mathf.Lerp(iter_82_5.color.b, arg_79_1.hightColor1.b, (arg_79_1.time_ - 0) / var_82_3)))
							else
								local var_82_4 = Mathf.Lerp(iter_82_5.color.r, 1, (arg_79_1.time_ - 0) / var_82_3)

								iter_82_5.color = Color.New(var_82_4, var_82_4, var_82_4)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= 0 + var_82_3 and arg_79_1.time_ < 0 + var_82_3 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.actorSpriteComps10030 then
				for iter_82_6, iter_82_7 in pairs(arg_79_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_82_7 then
						iter_82_7.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_79_1.var_.actorSpriteComps10030 = nil
			end

			local var_82_5 = 0
			local var_82_6 = 0.35

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_7 = arg_79_1:GetWordFromCfg(115301020)
				local var_82_8 = arg_79_1:FormatText(var_82_7.content)

				arg_79_1.text_.text = var_82_8

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_10 = 14 <= 0 and var_82_6 or var_82_6 * (utf8.len(var_82_8) / 14)

				if (14 <= 0 and var_82_6 or var_82_6 * (utf8.len(var_82_8) / 14)) > 0 and var_82_6 < var_82_10 then
					arg_79_1.talkMaxDuration = var_82_10

					if var_82_10 + var_82_5 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_5
					end
				end

				arg_79_1.text_.text = var_82_8
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301020", "story_v_out_115301.awb") ~= 0 then
					local var_82_11 = manager.audio:GetVoiceLength("story_v_out_115301", "115301020", "story_v_out_115301.awb") / 1000

					if var_82_11 + var_82_5 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_11 + var_82_5
					end

					if var_82_7.prefab_name ~= "" and arg_79_1.actors_[var_82_7.prefab_name] ~= nil then
						local var_82_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_7.prefab_name].transform, "story_v_out_115301", "115301020", "story_v_out_115301.awb")

						arg_79_1:RecordAudio("115301020", var_82_12)
						arg_79_1:RecordAudio("115301020", var_82_12)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_115301", "115301020", "story_v_out_115301.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_115301", "115301020", "story_v_out_115301.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_13 = math.max(var_82_6, arg_79_1.talkMaxDuration)

			if var_82_5 <= arg_79_1.time_ and arg_79_1.time_ < var_82_5 + var_82_13 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_5) / var_82_13

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_5 + var_82_13 and arg_79_1.time_ < var_82_5 + var_82_13 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play115301021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 115301021
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play115301022(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				local var_86_0 = arg_83_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_86_0 then
					arg_83_1.var_.alphaOldValue10030 = var_86_0.alpha
					arg_83_1.var_.characterEffect10030 = var_86_0
				end

				arg_83_1.var_.alphaOldValue10030 = 1
			end

			local var_86_1 = 0.333333333333333

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_1 then
				if arg_83_1.var_.characterEffect10030 then
					arg_83_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_83_1.var_.alphaOldValue10030, 0, (arg_83_1.time_ - 0) / var_86_1)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_1 and arg_83_1.time_ < 0 + var_86_1 + arg_86_0 and arg_83_1.var_.characterEffect10030 then
				arg_83_1.var_.characterEffect10030.alpha = 0
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				local var_86_2 = arg_83_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_86_2 then
					arg_83_1.var_.alphaOldValue1038 = var_86_2.alpha
					arg_83_1.var_.characterEffect1038 = var_86_2
				end

				arg_83_1.var_.alphaOldValue1038 = 1
			end

			local var_86_3 = 0.333333333333333

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_3 then
				if arg_83_1.var_.characterEffect1038 then
					arg_83_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_83_1.var_.alphaOldValue1038, 0, (arg_83_1.time_ - 0) / var_86_3)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_3 and arg_83_1.time_ < 0 + var_86_3 + arg_86_0 and arg_83_1.var_.characterEffect1038 then
				arg_83_1.var_.characterEffect1038.alpha = 0
			end

			local var_86_4 = 0
			local var_86_5 = 0.925

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_4 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_6 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(115301021).content)

				arg_83_1.text_.text = var_86_6

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_8 = 37 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_6) / 37)

				if (37 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_6) / 37)) > 0 and var_86_5 < var_86_8 then
					arg_83_1.talkMaxDuration = var_86_8

					if var_86_8 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_4
					end
				end

				arg_83_1.text_.text = var_86_6
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_9 = math.max(var_86_5, arg_83_1.talkMaxDuration)

			if var_86_4 <= arg_83_1.time_ and arg_83_1.time_ < var_86_4 + var_86_9 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_4) / var_86_9

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_4 + var_86_9 and arg_83_1.time_ < var_86_4 + var_86_9 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play115301022 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 115301022
		arg_87_1.duration_ = 8.37

		local var_87_0 = {
			ja = 6.2,
			ko = 8.333,
			zh = 8.366,
			en = 8.266
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play115301023(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos10030 = arg_87_1.actors_["10030"].transform.localPosition
				arg_87_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("10030", 3)

				for iter_90_0 = 0, arg_87_1.actors_["10030"].transform.childCount - 1 do
					local var_90_0 = arg_87_1.actors_["10030"].transform:GetChild(iter_90_0)

					if var_90_0.name == "split_5" or not string.find(var_90_0.name, "split") then
						var_90_0.gameObject:SetActive(true)
					else
						var_90_0.gameObject:SetActive(false)
					end
				end
			end

			local var_90_1 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_1 then
				arg_87_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_87_1.time_ - 0) / var_90_1)
			end

			if arg_87_1.time_ >= 0 + var_90_1 and arg_87_1.time_ < 0 + var_90_1 + arg_90_0 then
				arg_87_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				local var_90_2 = arg_87_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_90_2 then
					arg_87_1.var_.alphaOldValue10030 = var_90_2.alpha
					arg_87_1.var_.characterEffect10030 = var_90_2
				end

				arg_87_1.var_.alphaOldValue10030 = 0
			end

			local var_90_3 = 0.333333333333333

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_3 then
				if arg_87_1.var_.characterEffect10030 then
					arg_87_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_87_1.var_.alphaOldValue10030, 1, (arg_87_1.time_ - 0) / var_90_3)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_3 and arg_87_1.time_ < 0 + var_90_3 + arg_90_0 and arg_87_1.var_.characterEffect10030 then
				arg_87_1.var_.characterEffect10030.alpha = 1
			end

			local var_90_4 = 0
			local var_90_5 = 1.125

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_6 = arg_87_1:GetWordFromCfg(115301022)
				local var_90_7 = arg_87_1:FormatText(var_90_6.content)

				arg_87_1.text_.text = var_90_7

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_9 = 45 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 45)

				if (45 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 45)) > 0 and var_90_5 < var_90_9 then
					arg_87_1.talkMaxDuration = var_90_9

					if var_90_9 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_9 + var_90_4
					end
				end

				arg_87_1.text_.text = var_90_7
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301022", "story_v_out_115301.awb") ~= 0 then
					local var_90_10 = manager.audio:GetVoiceLength("story_v_out_115301", "115301022", "story_v_out_115301.awb") / 1000

					if var_90_10 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_10 + var_90_4
					end

					if var_90_6.prefab_name ~= "" and arg_87_1.actors_[var_90_6.prefab_name] ~= nil then
						local var_90_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_6.prefab_name].transform, "story_v_out_115301", "115301022", "story_v_out_115301.awb")

						arg_87_1:RecordAudio("115301022", var_90_11)
						arg_87_1:RecordAudio("115301022", var_90_11)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_115301", "115301022", "story_v_out_115301.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_115301", "115301022", "story_v_out_115301.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_12 = math.max(var_90_5, arg_87_1.talkMaxDuration)

			if var_90_4 <= arg_87_1.time_ and arg_87_1.time_ < var_90_4 + var_90_12 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_4) / var_90_12

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_4 + var_90_12 and arg_87_1.time_ < var_90_4 + var_90_12 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play115301023 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 115301023
		arg_91_1.duration_ = 11.87

		local var_91_0 = {
			ja = 9.766,
			ko = 11.866,
			zh = 9.6,
			en = 11.433
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play115301024(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 1.25

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_1 = arg_91_1:GetWordFromCfg(115301023)
				local var_94_2 = arg_91_1:FormatText(var_94_1.content)

				arg_91_1.text_.text = var_94_2

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 50 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 50)

				if (50 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 50)) > 0 and var_94_0 < var_94_4 then
					arg_91_1.talkMaxDuration = var_94_4

					if var_94_4 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_4 + 0
					end
				end

				arg_91_1.text_.text = var_94_2
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301023", "story_v_out_115301.awb") ~= 0 then
					local var_94_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301023", "story_v_out_115301.awb") / 1000

					if var_94_5 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + 0
					end

					if var_94_1.prefab_name ~= "" and arg_91_1.actors_[var_94_1.prefab_name] ~= nil then
						local var_94_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_1.prefab_name].transform, "story_v_out_115301", "115301023", "story_v_out_115301.awb")

						arg_91_1:RecordAudio("115301023", var_94_6)
						arg_91_1:RecordAudio("115301023", var_94_6)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_115301", "115301023", "story_v_out_115301.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_115301", "115301023", "story_v_out_115301.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_7 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_7 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_7

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_7 and arg_91_1.time_ < 0 + var_94_7 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play115301024 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 115301024
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play115301025(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				local var_98_0 = arg_95_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_98_0 then
					arg_95_1.var_.alphaOldValue10030 = var_98_0.alpha
					arg_95_1.var_.characterEffect10030 = var_98_0
				end

				arg_95_1.var_.alphaOldValue10030 = 1
			end

			local var_98_1 = 0.333333333333333

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_1 then
				if arg_95_1.var_.characterEffect10030 then
					arg_95_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_95_1.var_.alphaOldValue10030, 0, (arg_95_1.time_ - 0) / var_98_1)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_1 and arg_95_1.time_ < 0 + var_98_1 + arg_98_0 and arg_95_1.var_.characterEffect10030 then
				arg_95_1.var_.characterEffect10030.alpha = 0
			end

			local var_98_2 = 0
			local var_98_3 = 0.55

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_2 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_4 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(115301024).content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_6 = 22 <= 0 and var_98_3 or var_98_3 * (utf8.len(var_98_4) / 22)

				if (22 <= 0 and var_98_3 or var_98_3 * (utf8.len(var_98_4) / 22)) > 0 and var_98_3 < var_98_6 then
					arg_95_1.talkMaxDuration = var_98_6

					if var_98_6 + var_98_2 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_6 + var_98_2
					end
				end

				arg_95_1.text_.text = var_98_4
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_3, arg_95_1.talkMaxDuration)

			if var_98_2 <= arg_95_1.time_ and arg_95_1.time_ < var_98_2 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_2) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_2 + var_98_7 and arg_95_1.time_ < var_98_2 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play115301025 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 115301025
		arg_99_1.duration_ = 4.1

		local var_99_0 = {
			ja = 4.1,
			ko = 1.4,
			zh = 2.866,
			en = 1.366
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play115301026(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1038 = arg_99_1.actors_["1038"].transform.localPosition
				arg_99_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("1038", 3)

				for iter_102_0 = 0, arg_99_1.actors_["1038"].transform.childCount - 1 do
					local var_102_0 = arg_99_1.actors_["1038"].transform:GetChild(iter_102_0)

					if var_102_0.name == "split_1" or not string.find(var_102_0.name, "split") then
						var_102_0.gameObject:SetActive(true)
					else
						var_102_0.gameObject:SetActive(false)
					end
				end
			end

			local var_102_1 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_1 then
				arg_99_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1038, Vector3.New(0, -400, 0), (arg_99_1.time_ - 0) / var_102_1)
			end

			if arg_99_1.time_ >= 0 + var_102_1 and arg_99_1.time_ < 0 + var_102_1 + arg_102_0 then
				arg_99_1.actors_["1038"].transform.localPosition = Vector3.New(0, -400, 0)
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				local var_102_2 = arg_99_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_102_2 then
					arg_99_1.var_.alphaOldValue1038 = var_102_2.alpha
					arg_99_1.var_.characterEffect1038 = var_102_2
				end

				arg_99_1.var_.alphaOldValue1038 = 0
			end

			local var_102_3 = 0.333333333333333

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_3 then
				if arg_99_1.var_.characterEffect1038 then
					arg_99_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_99_1.var_.alphaOldValue1038, 1, (arg_99_1.time_ - 0) / var_102_3)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_3 and arg_99_1.time_ < 0 + var_102_3 + arg_102_0 and arg_99_1.var_.characterEffect1038 then
				arg_99_1.var_.characterEffect1038.alpha = 1
			end

			local var_102_4 = arg_99_1.actors_["1038"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_4) and arg_99_1.var_.actorSpriteComps1038 == nil then
				arg_99_1.var_.actorSpriteComps1038 = var_102_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_5 = 0.2

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_5 and not isNil(var_102_4) then
				if arg_99_1.var_.actorSpriteComps1038 then
					for iter_102_1, iter_102_2 in pairs(arg_99_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_102_2 then
							if arg_99_1.isInRecall_ then
								iter_102_2.color = Color.New(Mathf.Lerp(iter_102_2.color.r, arg_99_1.hightColor1.r, (arg_99_1.time_ - 0) / var_102_5), Mathf.Lerp(iter_102_2.color.g, arg_99_1.hightColor1.g, (arg_99_1.time_ - 0) / var_102_5), (Mathf.Lerp(iter_102_2.color.b, arg_99_1.hightColor1.b, (arg_99_1.time_ - 0) / var_102_5)))
							else
								local var_102_6 = Mathf.Lerp(iter_102_2.color.r, 1, (arg_99_1.time_ - 0) / var_102_5)

								iter_102_2.color = Color.New(var_102_6, var_102_6, var_102_6)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= 0 + var_102_5 and arg_99_1.time_ < 0 + var_102_5 + arg_102_0 and not isNil(var_102_4) and arg_99_1.var_.actorSpriteComps1038 then
				for iter_102_3, iter_102_4 in pairs(arg_99_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_102_4 then
						iter_102_4.color = arg_99_1.isInRecall_ and (arg_99_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_99_1.var_.actorSpriteComps1038 = nil
			end

			local var_102_7 = 0
			local var_102_8 = 0.125

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_7 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_9 = arg_99_1:GetWordFromCfg(115301025)
				local var_102_10 = arg_99_1:FormatText(var_102_9.content)

				arg_99_1.text_.text = var_102_10

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_12 = 5 <= 0 and var_102_8 or var_102_8 * (utf8.len(var_102_10) / 5)

				if (5 <= 0 and var_102_8 or var_102_8 * (utf8.len(var_102_10) / 5)) > 0 and var_102_8 < var_102_12 then
					arg_99_1.talkMaxDuration = var_102_12

					if var_102_12 + var_102_7 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_12 + var_102_7
					end
				end

				arg_99_1.text_.text = var_102_10
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301025", "story_v_out_115301.awb") ~= 0 then
					local var_102_13 = manager.audio:GetVoiceLength("story_v_out_115301", "115301025", "story_v_out_115301.awb") / 1000

					if var_102_13 + var_102_7 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_13 + var_102_7
					end

					if var_102_9.prefab_name ~= "" and arg_99_1.actors_[var_102_9.prefab_name] ~= nil then
						local var_102_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_9.prefab_name].transform, "story_v_out_115301", "115301025", "story_v_out_115301.awb")

						arg_99_1:RecordAudio("115301025", var_102_14)
						arg_99_1:RecordAudio("115301025", var_102_14)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_115301", "115301025", "story_v_out_115301.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_115301", "115301025", "story_v_out_115301.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_15 = math.max(var_102_8, arg_99_1.talkMaxDuration)

			if var_102_7 <= arg_99_1.time_ and arg_99_1.time_ < var_102_7 + var_102_15 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_7) / var_102_15

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_7 + var_102_15 and arg_99_1.time_ < var_102_7 + var_102_15 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play115301026 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 115301026
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play115301027(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				local var_106_0 = arg_103_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_106_0 then
					arg_103_1.var_.alphaOldValue1038 = var_106_0.alpha
					arg_103_1.var_.characterEffect1038 = var_106_0
				end

				arg_103_1.var_.alphaOldValue1038 = 1
			end

			local var_106_1 = 0.333333333333333

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_1 then
				if arg_103_1.var_.characterEffect1038 then
					arg_103_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_103_1.var_.alphaOldValue1038, 0, (arg_103_1.time_ - 0) / var_106_1)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_1 and arg_103_1.time_ < 0 + var_106_1 + arg_106_0 and arg_103_1.var_.characterEffect1038 then
				arg_103_1.var_.characterEffect1038.alpha = 0
			end

			local var_106_2 = 0
			local var_106_3 = 1.675

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_2 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_4 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(115301026).content)

				arg_103_1.text_.text = var_106_4

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_6 = 67 <= 0 and var_106_3 or var_106_3 * (utf8.len(var_106_4) / 67)

				if (67 <= 0 and var_106_3 or var_106_3 * (utf8.len(var_106_4) / 67)) > 0 and var_106_3 < var_106_6 then
					arg_103_1.talkMaxDuration = var_106_6

					if var_106_6 + var_106_2 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_6 + var_106_2
					end
				end

				arg_103_1.text_.text = var_106_4
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_7 = math.max(var_106_3, arg_103_1.talkMaxDuration)

			if var_106_2 <= arg_103_1.time_ and arg_103_1.time_ < var_106_2 + var_106_7 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_2) / var_106_7

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_2 + var_106_7 and arg_103_1.time_ < var_106_2 + var_106_7 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play115301027 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 115301027
		arg_107_1.duration_ = 8.73

		local var_107_0 = {
			ja = 5.066,
			ko = 7.4,
			zh = 8.733,
			en = 5.433
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play115301028(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10030 = arg_107_1.actors_["10030"].transform.localPosition
				arg_107_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("10030", 3)

				for iter_110_0 = 0, arg_107_1.actors_["10030"].transform.childCount - 1 do
					local var_110_0 = arg_107_1.actors_["10030"].transform:GetChild(iter_110_0)

					if var_110_0.name == "split_3" or not string.find(var_110_0.name, "split") then
						var_110_0.gameObject:SetActive(true)
					else
						var_110_0.gameObject:SetActive(false)
					end
				end
			end

			local var_110_1 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_1 then
				arg_107_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_107_1.time_ - 0) / var_110_1)
			end

			if arg_107_1.time_ >= 0 + var_110_1 and arg_107_1.time_ < 0 + var_110_1 + arg_110_0 then
				arg_107_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			local var_110_2 = arg_107_1.actors_["10030"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.actorSpriteComps10030 == nil then
				arg_107_1.var_.actorSpriteComps10030 = var_110_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_3 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_3 and not isNil(var_110_2) then
				if arg_107_1.var_.actorSpriteComps10030 then
					for iter_110_1, iter_110_2 in pairs(arg_107_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_110_2 then
							if arg_107_1.isInRecall_ then
								iter_110_2.color = Color.New(Mathf.Lerp(iter_110_2.color.r, arg_107_1.hightColor1.r, (arg_107_1.time_ - 0) / var_110_3), Mathf.Lerp(iter_110_2.color.g, arg_107_1.hightColor1.g, (arg_107_1.time_ - 0) / var_110_3), (Mathf.Lerp(iter_110_2.color.b, arg_107_1.hightColor1.b, (arg_107_1.time_ - 0) / var_110_3)))
							else
								local var_110_4 = Mathf.Lerp(iter_110_2.color.r, 1, (arg_107_1.time_ - 0) / var_110_3)

								iter_110_2.color = Color.New(var_110_4, var_110_4, var_110_4)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= 0 + var_110_3 and arg_107_1.time_ < 0 + var_110_3 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.actorSpriteComps10030 then
				for iter_110_3, iter_110_4 in pairs(arg_107_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_110_4 then
						iter_110_4.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_107_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				local var_110_5 = arg_107_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_110_5 then
					arg_107_1.var_.alphaOldValue10030 = var_110_5.alpha
					arg_107_1.var_.characterEffect10030 = var_110_5
				end

				arg_107_1.var_.alphaOldValue10030 = 0
			end

			local var_110_6 = 0.333333333333333

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_6 then
				if arg_107_1.var_.characterEffect10030 then
					arg_107_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_107_1.var_.alphaOldValue10030, 1, (arg_107_1.time_ - 0) / var_110_6)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_6 and arg_107_1.time_ < 0 + var_110_6 + arg_110_0 and arg_107_1.var_.characterEffect10030 then
				arg_107_1.var_.characterEffect10030.alpha = 1
			end

			local var_110_7 = 0
			local var_110_8 = 0.65

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_7 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_9 = arg_107_1:GetWordFromCfg(115301027)
				local var_110_10 = arg_107_1:FormatText(var_110_9.content)

				arg_107_1.text_.text = var_110_10

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_12 = 26 <= 0 and var_110_8 or var_110_8 * (utf8.len(var_110_10) / 26)

				if (26 <= 0 and var_110_8 or var_110_8 * (utf8.len(var_110_10) / 26)) > 0 and var_110_8 < var_110_12 then
					arg_107_1.talkMaxDuration = var_110_12

					if var_110_12 + var_110_7 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_12 + var_110_7
					end
				end

				arg_107_1.text_.text = var_110_10
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301027", "story_v_out_115301.awb") ~= 0 then
					local var_110_13 = manager.audio:GetVoiceLength("story_v_out_115301", "115301027", "story_v_out_115301.awb") / 1000

					if var_110_13 + var_110_7 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_13 + var_110_7
					end

					if var_110_9.prefab_name ~= "" and arg_107_1.actors_[var_110_9.prefab_name] ~= nil then
						local var_110_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_9.prefab_name].transform, "story_v_out_115301", "115301027", "story_v_out_115301.awb")

						arg_107_1:RecordAudio("115301027", var_110_14)
						arg_107_1:RecordAudio("115301027", var_110_14)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_115301", "115301027", "story_v_out_115301.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_115301", "115301027", "story_v_out_115301.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_15 = math.max(var_110_8, arg_107_1.talkMaxDuration)

			if var_110_7 <= arg_107_1.time_ and arg_107_1.time_ < var_110_7 + var_110_15 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_7) / var_110_15

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_7 + var_110_15 and arg_107_1.time_ < var_110_7 + var_110_15 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play115301028 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 115301028
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play115301029(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["10030"]) and arg_111_1.var_.actorSpriteComps10030 == nil then
				arg_111_1.var_.actorSpriteComps10030 = arg_111_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_0 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["10030"]) then
				if arg_111_1.var_.actorSpriteComps10030 then
					for iter_114_0, iter_114_1 in pairs(arg_111_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_114_1 then
							if arg_111_1.isInRecall_ then
								iter_114_1.color = Color.New(Mathf.Lerp(iter_114_1.color.r, arg_111_1.hightColor2.r, (arg_111_1.time_ - 0) / var_114_0), Mathf.Lerp(iter_114_1.color.g, arg_111_1.hightColor2.g, (arg_111_1.time_ - 0) / var_114_0), (Mathf.Lerp(iter_114_1.color.b, arg_111_1.hightColor2.b, (arg_111_1.time_ - 0) / var_114_0)))
							else
								local var_114_1 = Mathf.Lerp(iter_114_1.color.r, 0.5, (arg_111_1.time_ - 0) / var_114_0)

								iter_114_1.color = Color.New(var_114_1, var_114_1, var_114_1)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["10030"]) and arg_111_1.var_.actorSpriteComps10030 then
				for iter_114_2, iter_114_3 in pairs(arg_111_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_114_3 then
						iter_114_3.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_111_1.var_.actorSpriteComps10030 = nil
			end

			local var_114_2 = 0
			local var_114_3 = 0.5

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_2 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_4 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(115301028).content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_6 = 20 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_4) / 20)

				if (20 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_4) / 20)) > 0 and var_114_3 < var_114_6 then
					arg_111_1.talkMaxDuration = var_114_6

					if var_114_6 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_6 + var_114_2
					end
				end

				arg_111_1.text_.text = var_114_4
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_3, arg_111_1.talkMaxDuration)

			if var_114_2 <= arg_111_1.time_ and arg_111_1.time_ < var_114_2 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_2) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_2 + var_114_7 and arg_111_1.time_ < var_114_2 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play115301029 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 115301029
		arg_115_1.duration_ = 13.37

		local var_115_0 = {
			ja = 13.366,
			ko = 8.9,
			zh = 11.7,
			en = 9.1
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play115301030(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1038 = arg_115_1.actors_["1038"].transform.localPosition
				arg_115_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("1038", 2)

				for iter_118_0 = 0, arg_115_1.actors_["1038"].transform.childCount - 1 do
					local var_118_0 = arg_115_1.actors_["1038"].transform:GetChild(iter_118_0)

					if var_118_0.name == "split_1" or not string.find(var_118_0.name, "split") then
						var_118_0.gameObject:SetActive(true)
					else
						var_118_0.gameObject:SetActive(false)
					end
				end
			end

			local var_118_1 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_1 then
				arg_115_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_115_1.time_ - 0) / var_118_1)
			end

			if arg_115_1.time_ >= 0 + var_118_1 and arg_115_1.time_ < 0 + var_118_1 + arg_118_0 then
				arg_115_1.actors_["1038"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_118_2 = arg_115_1.actors_["10030"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10030 = var_118_2.localPosition
				var_118_2.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10030", 4)

				for iter_118_1 = 0, var_118_2.childCount - 1 do
					local var_118_3 = var_118_2:GetChild(iter_118_1)

					if var_118_3.name == "split_3" or not string.find(var_118_3.name, "split") then
						var_118_3.gameObject:SetActive(true)
					else
						var_118_3.gameObject:SetActive(false)
					end
				end
			end

			local var_118_4 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 then
				var_118_2.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_115_1.time_ - 0) / var_118_4)
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 then
				var_118_2.localPosition = Vector3.New(390, -390, 150)
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				local var_118_5 = arg_115_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_118_5 then
					arg_115_1.var_.alphaOldValue1038 = var_118_5.alpha
					arg_115_1.var_.characterEffect1038 = var_118_5
				end

				arg_115_1.var_.alphaOldValue1038 = 0
			end

			local var_118_6 = 0.333333333333333

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_6 then
				if arg_115_1.var_.characterEffect1038 then
					arg_115_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_115_1.var_.alphaOldValue1038, 1, (arg_115_1.time_ - 0) / var_118_6)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_6 and arg_115_1.time_ < 0 + var_118_6 + arg_118_0 and arg_115_1.var_.characterEffect1038 then
				arg_115_1.var_.characterEffect1038.alpha = 1
			end

			local var_118_7 = arg_115_1.actors_["1038"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_7) and arg_115_1.var_.actorSpriteComps1038 == nil then
				arg_115_1.var_.actorSpriteComps1038 = var_118_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_8 = 0.2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_8 and not isNil(var_118_7) then
				if arg_115_1.var_.actorSpriteComps1038 then
					for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_118_3 then
							if arg_115_1.isInRecall_ then
								iter_118_3.color = Color.New(Mathf.Lerp(iter_118_3.color.r, arg_115_1.hightColor1.r, (arg_115_1.time_ - 0) / var_118_8), Mathf.Lerp(iter_118_3.color.g, arg_115_1.hightColor1.g, (arg_115_1.time_ - 0) / var_118_8), (Mathf.Lerp(iter_118_3.color.b, arg_115_1.hightColor1.b, (arg_115_1.time_ - 0) / var_118_8)))
							else
								local var_118_9 = Mathf.Lerp(iter_118_3.color.r, 1, (arg_115_1.time_ - 0) / var_118_8)

								iter_118_3.color = Color.New(var_118_9, var_118_9, var_118_9)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= 0 + var_118_8 and arg_115_1.time_ < 0 + var_118_8 + arg_118_0 and not isNil(var_118_7) and arg_115_1.var_.actorSpriteComps1038 then
				for iter_118_4, iter_118_5 in pairs(arg_115_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_118_5 then
						iter_118_5.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_115_1.var_.actorSpriteComps1038 = nil
			end

			local var_118_10 = 0
			local var_118_11 = 1.125

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_10 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_12 = arg_115_1:GetWordFromCfg(115301029)
				local var_118_13 = arg_115_1:FormatText(var_118_12.content)

				arg_115_1.text_.text = var_118_13

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_15 = 45 <= 0 and var_118_11 or var_118_11 * (utf8.len(var_118_13) / 45)

				if (45 <= 0 and var_118_11 or var_118_11 * (utf8.len(var_118_13) / 45)) > 0 and var_118_11 < var_118_15 then
					arg_115_1.talkMaxDuration = var_118_15

					if var_118_15 + var_118_10 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_15 + var_118_10
					end
				end

				arg_115_1.text_.text = var_118_13
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301029", "story_v_out_115301.awb") ~= 0 then
					local var_118_16 = manager.audio:GetVoiceLength("story_v_out_115301", "115301029", "story_v_out_115301.awb") / 1000

					if var_118_16 + var_118_10 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_16 + var_118_10
					end

					if var_118_12.prefab_name ~= "" and arg_115_1.actors_[var_118_12.prefab_name] ~= nil then
						local var_118_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_12.prefab_name].transform, "story_v_out_115301", "115301029", "story_v_out_115301.awb")

						arg_115_1:RecordAudio("115301029", var_118_17)
						arg_115_1:RecordAudio("115301029", var_118_17)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_115301", "115301029", "story_v_out_115301.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_115301", "115301029", "story_v_out_115301.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_18 = math.max(var_118_11, arg_115_1.talkMaxDuration)

			if var_118_10 <= arg_115_1.time_ and arg_115_1.time_ < var_118_10 + var_118_18 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_10) / var_118_18

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_10 + var_118_18 and arg_115_1.time_ < var_118_10 + var_118_18 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play115301030 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 115301030
		arg_119_1.duration_ = 16.6

		local var_119_0 = {
			ja = 16.6,
			ko = 12.066,
			zh = 12.6,
			en = 10.333
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play115301031(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1038 = arg_119_1.actors_["1038"].transform.localPosition
				arg_119_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("1038", 2)

				for iter_122_0 = 0, arg_119_1.actors_["1038"].transform.childCount - 1 do
					local var_122_0 = arg_119_1.actors_["1038"].transform:GetChild(iter_122_0)

					if var_122_0.name == "split_9" or not string.find(var_122_0.name, "split") then
						var_122_0.gameObject:SetActive(true)
					else
						var_122_0.gameObject:SetActive(false)
					end
				end
			end

			local var_122_1 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_1 then
				arg_119_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_119_1.time_ - 0) / var_122_1)
			end

			if arg_119_1.time_ >= 0 + var_122_1 and arg_119_1.time_ < 0 + var_122_1 + arg_122_0 then
				arg_119_1.actors_["1038"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_122_2 = 0
			local var_122_3 = 1.1

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_2 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_4 = arg_119_1:GetWordFromCfg(115301030)
				local var_122_5 = arg_119_1:FormatText(var_122_4.content)

				arg_119_1.text_.text = var_122_5

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_7 = 44 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_5) / 44)

				if (44 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_5) / 44)) > 0 and var_122_3 < var_122_7 then
					arg_119_1.talkMaxDuration = var_122_7

					if var_122_7 + var_122_2 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_7 + var_122_2
					end
				end

				arg_119_1.text_.text = var_122_5
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301030", "story_v_out_115301.awb") ~= 0 then
					local var_122_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301030", "story_v_out_115301.awb") / 1000

					if var_122_8 + var_122_2 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_8 + var_122_2
					end

					if var_122_4.prefab_name ~= "" and arg_119_1.actors_[var_122_4.prefab_name] ~= nil then
						local var_122_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_4.prefab_name].transform, "story_v_out_115301", "115301030", "story_v_out_115301.awb")

						arg_119_1:RecordAudio("115301030", var_122_9)
						arg_119_1:RecordAudio("115301030", var_122_9)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_115301", "115301030", "story_v_out_115301.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_115301", "115301030", "story_v_out_115301.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_10 = math.max(var_122_3, arg_119_1.talkMaxDuration)

			if var_122_2 <= arg_119_1.time_ and arg_119_1.time_ < var_122_2 + var_122_10 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_2) / var_122_10

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_2 + var_122_10 and arg_119_1.time_ < var_122_2 + var_122_10 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play115301031 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 115301031
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play115301032(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["1038"]) and arg_123_1.var_.actorSpriteComps1038 == nil then
				arg_123_1.var_.actorSpriteComps1038 = arg_123_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_0 = 0.2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["1038"]) then
				if arg_123_1.var_.actorSpriteComps1038 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_126_1 then
							if arg_123_1.isInRecall_ then
								iter_126_1.color = Color.New(Mathf.Lerp(iter_126_1.color.r, arg_123_1.hightColor2.r, (arg_123_1.time_ - 0) / var_126_0), Mathf.Lerp(iter_126_1.color.g, arg_123_1.hightColor2.g, (arg_123_1.time_ - 0) / var_126_0), (Mathf.Lerp(iter_126_1.color.b, arg_123_1.hightColor2.b, (arg_123_1.time_ - 0) / var_126_0)))
							else
								local var_126_1 = Mathf.Lerp(iter_126_1.color.r, 0.5, (arg_123_1.time_ - 0) / var_126_0)

								iter_126_1.color = Color.New(var_126_1, var_126_1, var_126_1)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["1038"]) and arg_123_1.var_.actorSpriteComps1038 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_126_3 then
						iter_126_3.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_123_1.var_.actorSpriteComps1038 = nil
			end

			local var_126_2 = 0
			local var_126_3 = 0.775

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_2 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_4 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(115301031).content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_6 = 31 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_4) / 31)

				if (31 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_4) / 31)) > 0 and var_126_3 < var_126_6 then
					arg_123_1.talkMaxDuration = var_126_6

					if var_126_6 + var_126_2 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_6 + var_126_2
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_7 = math.max(var_126_3, arg_123_1.talkMaxDuration)

			if var_126_2 <= arg_123_1.time_ and arg_123_1.time_ < var_126_2 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_2) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_2 + var_126_7 and arg_123_1.time_ < var_126_2 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play115301032 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 115301032
		arg_127_1.duration_ = 3.93

		local var_127_0 = {
			ja = 3.3,
			ko = 3.933,
			zh = 3.133,
			en = 3.433
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play115301033(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos10030 = arg_127_1.actors_["10030"].transform.localPosition
				arg_127_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10030", 4)

				for iter_130_0 = 0, arg_127_1.actors_["10030"].transform.childCount - 1 do
					local var_130_0 = arg_127_1.actors_["10030"].transform:GetChild(iter_130_0)

					if var_130_0.name == "split_5" or not string.find(var_130_0.name, "split") then
						var_130_0.gameObject:SetActive(true)
					else
						var_130_0.gameObject:SetActive(false)
					end
				end
			end

			local var_130_1 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_1 then
				arg_127_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_127_1.time_ - 0) / var_130_1)
			end

			if arg_127_1.time_ >= 0 + var_130_1 and arg_127_1.time_ < 0 + var_130_1 + arg_130_0 then
				arg_127_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			local var_130_2 = arg_127_1.actors_["10030"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.actorSpriteComps10030 == nil then
				arg_127_1.var_.actorSpriteComps10030 = var_130_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_3 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_3 and not isNil(var_130_2) then
				if arg_127_1.var_.actorSpriteComps10030 then
					for iter_130_1, iter_130_2 in pairs(arg_127_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_130_2 then
							if arg_127_1.isInRecall_ then
								iter_130_2.color = Color.New(Mathf.Lerp(iter_130_2.color.r, arg_127_1.hightColor1.r, (arg_127_1.time_ - 0) / var_130_3), Mathf.Lerp(iter_130_2.color.g, arg_127_1.hightColor1.g, (arg_127_1.time_ - 0) / var_130_3), (Mathf.Lerp(iter_130_2.color.b, arg_127_1.hightColor1.b, (arg_127_1.time_ - 0) / var_130_3)))
							else
								local var_130_4 = Mathf.Lerp(iter_130_2.color.r, 1, (arg_127_1.time_ - 0) / var_130_3)

								iter_130_2.color = Color.New(var_130_4, var_130_4, var_130_4)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_3 and arg_127_1.time_ < 0 + var_130_3 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.actorSpriteComps10030 then
				for iter_130_3, iter_130_4 in pairs(arg_127_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_130_4 then
						iter_130_4.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_127_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				local var_130_5 = arg_127_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_130_5 then
					arg_127_1.var_.alphaOldValue10030 = var_130_5.alpha
					arg_127_1.var_.characterEffect10030 = var_130_5
				end

				arg_127_1.var_.alphaOldValue10030 = 0
			end

			local var_130_6 = 0.0166666666666667

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_6 then
				if arg_127_1.var_.characterEffect10030 then
					arg_127_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_127_1.var_.alphaOldValue10030, 1, (arg_127_1.time_ - 0) / var_130_6)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_6 and arg_127_1.time_ < 0 + var_130_6 + arg_130_0 and arg_127_1.var_.characterEffect10030 then
				arg_127_1.var_.characterEffect10030.alpha = 1
			end

			local var_130_7 = 0
			local var_130_8 = 0.475

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_7 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_9 = arg_127_1:GetWordFromCfg(115301032)
				local var_130_10 = arg_127_1:FormatText(var_130_9.content)

				arg_127_1.text_.text = var_130_10

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_12 = 19 <= 0 and var_130_8 or var_130_8 * (utf8.len(var_130_10) / 19)

				if (19 <= 0 and var_130_8 or var_130_8 * (utf8.len(var_130_10) / 19)) > 0 and var_130_8 < var_130_12 then
					arg_127_1.talkMaxDuration = var_130_12

					if var_130_12 + var_130_7 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_12 + var_130_7
					end
				end

				arg_127_1.text_.text = var_130_10
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301032", "story_v_out_115301.awb") ~= 0 then
					local var_130_13 = manager.audio:GetVoiceLength("story_v_out_115301", "115301032", "story_v_out_115301.awb") / 1000

					if var_130_13 + var_130_7 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_13 + var_130_7
					end

					if var_130_9.prefab_name ~= "" and arg_127_1.actors_[var_130_9.prefab_name] ~= nil then
						local var_130_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_9.prefab_name].transform, "story_v_out_115301", "115301032", "story_v_out_115301.awb")

						arg_127_1:RecordAudio("115301032", var_130_14)
						arg_127_1:RecordAudio("115301032", var_130_14)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_115301", "115301032", "story_v_out_115301.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_115301", "115301032", "story_v_out_115301.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_15 = math.max(var_130_8, arg_127_1.talkMaxDuration)

			if var_130_7 <= arg_127_1.time_ and arg_127_1.time_ < var_130_7 + var_130_15 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_7) / var_130_15

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_7 + var_130_15 and arg_127_1.time_ < var_130_7 + var_130_15 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play115301033 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 115301033
		arg_131_1.duration_ = 6.6

		local var_131_0 = {
			ja = 4.633,
			ko = 6.6,
			zh = 6.366,
			en = 6.266
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play115301034(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos10030 = arg_131_1.actors_["10030"].transform.localPosition
				arg_131_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("10030", 4)

				for iter_134_0 = 0, arg_131_1.actors_["10030"].transform.childCount - 1 do
					local var_134_0 = arg_131_1.actors_["10030"].transform:GetChild(iter_134_0)

					if var_134_0.name == "split_5" or not string.find(var_134_0.name, "split") then
						var_134_0.gameObject:SetActive(true)
					else
						var_134_0.gameObject:SetActive(false)
					end
				end
			end

			local var_134_1 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_1 then
				arg_131_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_131_1.time_ - 0) / var_134_1)
			end

			if arg_131_1.time_ >= 0 + var_134_1 and arg_131_1.time_ < 0 + var_134_1 + arg_134_0 then
				arg_131_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			local var_134_2 = 0
			local var_134_3 = 0.65

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_2 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_4 = arg_131_1:GetWordFromCfg(115301033)
				local var_134_5 = arg_131_1:FormatText(var_134_4.content)

				arg_131_1.text_.text = var_134_5

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_7 = 26 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_5) / 26)

				if (26 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_5) / 26)) > 0 and var_134_3 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_2
					end
				end

				arg_131_1.text_.text = var_134_5
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301033", "story_v_out_115301.awb") ~= 0 then
					local var_134_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301033", "story_v_out_115301.awb") / 1000

					if var_134_8 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_8 + var_134_2
					end

					if var_134_4.prefab_name ~= "" and arg_131_1.actors_[var_134_4.prefab_name] ~= nil then
						local var_134_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_4.prefab_name].transform, "story_v_out_115301", "115301033", "story_v_out_115301.awb")

						arg_131_1:RecordAudio("115301033", var_134_9)
						arg_131_1:RecordAudio("115301033", var_134_9)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_115301", "115301033", "story_v_out_115301.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_115301", "115301033", "story_v_out_115301.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_10 = math.max(var_134_3, arg_131_1.talkMaxDuration)

			if var_134_2 <= arg_131_1.time_ and arg_131_1.time_ < var_134_2 + var_134_10 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_2) / var_134_10

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_2 + var_134_10 and arg_131_1.time_ < var_134_2 + var_134_10 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play115301034 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 115301034
		arg_135_1.duration_ = 6.73

		local var_135_0 = {
			ja = 6.733,
			ko = 4.166,
			zh = 5.366,
			en = 4
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play115301035(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1038 = arg_135_1.actors_["1038"].transform.localPosition
				arg_135_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("1038", 2)

				for iter_138_0 = 0, arg_135_1.actors_["1038"].transform.childCount - 1 do
					local var_138_0 = arg_135_1.actors_["1038"].transform:GetChild(iter_138_0)

					if var_138_0.name == "split_1" or not string.find(var_138_0.name, "split") then
						var_138_0.gameObject:SetActive(true)
					else
						var_138_0.gameObject:SetActive(false)
					end
				end
			end

			local var_138_1 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_1 then
				arg_135_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_135_1.time_ - 0) / var_138_1)
			end

			if arg_135_1.time_ >= 0 + var_138_1 and arg_135_1.time_ < 0 + var_138_1 + arg_138_0 then
				arg_135_1.actors_["1038"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_138_2 = arg_135_1.actors_["10030"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps10030 == nil then
				arg_135_1.var_.actorSpriteComps10030 = var_138_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_3 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_3 and not isNil(var_138_2) then
				if arg_135_1.var_.actorSpriteComps10030 then
					for iter_138_1, iter_138_2 in pairs(arg_135_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_138_2 then
							if arg_135_1.isInRecall_ then
								iter_138_2.color = Color.New(Mathf.Lerp(iter_138_2.color.r, arg_135_1.hightColor2.r, (arg_135_1.time_ - 0) / var_138_3), Mathf.Lerp(iter_138_2.color.g, arg_135_1.hightColor2.g, (arg_135_1.time_ - 0) / var_138_3), (Mathf.Lerp(iter_138_2.color.b, arg_135_1.hightColor2.b, (arg_135_1.time_ - 0) / var_138_3)))
							else
								local var_138_4 = Mathf.Lerp(iter_138_2.color.r, 0.5, (arg_135_1.time_ - 0) / var_138_3)

								iter_138_2.color = Color.New(var_138_4, var_138_4, var_138_4)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_3 and arg_135_1.time_ < 0 + var_138_3 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps10030 then
				for iter_138_3, iter_138_4 in pairs(arg_135_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_138_4 then
						iter_138_4.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_135_1.var_.actorSpriteComps10030 = nil
			end

			local var_138_5 = 0
			local var_138_6 = 0.55

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_7 = arg_135_1:GetWordFromCfg(115301034)
				local var_138_8 = arg_135_1:FormatText(var_138_7.content)

				arg_135_1.text_.text = var_138_8

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_10 = 22 <= 0 and var_138_6 or var_138_6 * (utf8.len(var_138_8) / 22)

				if (22 <= 0 and var_138_6 or var_138_6 * (utf8.len(var_138_8) / 22)) > 0 and var_138_6 < var_138_10 then
					arg_135_1.talkMaxDuration = var_138_10

					if var_138_10 + var_138_5 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_5
					end
				end

				arg_135_1.text_.text = var_138_8
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301034", "story_v_out_115301.awb") ~= 0 then
					local var_138_11 = manager.audio:GetVoiceLength("story_v_out_115301", "115301034", "story_v_out_115301.awb") / 1000

					if var_138_11 + var_138_5 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_11 + var_138_5
					end

					if var_138_7.prefab_name ~= "" and arg_135_1.actors_[var_138_7.prefab_name] ~= nil then
						local var_138_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_7.prefab_name].transform, "story_v_out_115301", "115301034", "story_v_out_115301.awb")

						arg_135_1:RecordAudio("115301034", var_138_12)
						arg_135_1:RecordAudio("115301034", var_138_12)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_115301", "115301034", "story_v_out_115301.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_115301", "115301034", "story_v_out_115301.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_13 = math.max(var_138_6, arg_135_1.talkMaxDuration)

			if var_138_5 <= arg_135_1.time_ and arg_135_1.time_ < var_138_5 + var_138_13 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_5) / var_138_13

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_5 + var_138_13 and arg_135_1.time_ < var_138_5 + var_138_13 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play115301035 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 115301035
		arg_139_1.duration_ = 4.17

		local var_139_0 = {
			ja = 2.3,
			ko = 4.166,
			zh = 2.3,
			en = 1.533
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play115301036(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["10030"]) and arg_139_1.var_.actorSpriteComps10030 == nil then
				arg_139_1.var_.actorSpriteComps10030 = arg_139_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_0 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["10030"]) then
				if arg_139_1.var_.actorSpriteComps10030 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_142_1 then
							if arg_139_1.isInRecall_ then
								iter_142_1.color = Color.New(Mathf.Lerp(iter_142_1.color.r, arg_139_1.hightColor1.r, (arg_139_1.time_ - 0) / var_142_0), Mathf.Lerp(iter_142_1.color.g, arg_139_1.hightColor1.g, (arg_139_1.time_ - 0) / var_142_0), (Mathf.Lerp(iter_142_1.color.b, arg_139_1.hightColor1.b, (arg_139_1.time_ - 0) / var_142_0)))
							else
								local var_142_1 = Mathf.Lerp(iter_142_1.color.r, 1, (arg_139_1.time_ - 0) / var_142_0)

								iter_142_1.color = Color.New(var_142_1, var_142_1, var_142_1)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["10030"]) and arg_139_1.var_.actorSpriteComps10030 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_142_3 then
						iter_142_3.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_139_1.var_.actorSpriteComps10030 = nil
			end

			local var_142_2 = arg_139_1.actors_["1038"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.actorSpriteComps1038 == nil then
				arg_139_1.var_.actorSpriteComps1038 = var_142_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_3 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_3 and not isNil(var_142_2) then
				if arg_139_1.var_.actorSpriteComps1038 then
					for iter_142_4, iter_142_5 in pairs(arg_139_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_142_5 then
							if arg_139_1.isInRecall_ then
								iter_142_5.color = Color.New(Mathf.Lerp(iter_142_5.color.r, arg_139_1.hightColor2.r, (arg_139_1.time_ - 0) / var_142_3), Mathf.Lerp(iter_142_5.color.g, arg_139_1.hightColor2.g, (arg_139_1.time_ - 0) / var_142_3), (Mathf.Lerp(iter_142_5.color.b, arg_139_1.hightColor2.b, (arg_139_1.time_ - 0) / var_142_3)))
							else
								local var_142_4 = Mathf.Lerp(iter_142_5.color.r, 0.5, (arg_139_1.time_ - 0) / var_142_3)

								iter_142_5.color = Color.New(var_142_4, var_142_4, var_142_4)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_3 and arg_139_1.time_ < 0 + var_142_3 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.actorSpriteComps1038 then
				for iter_142_6, iter_142_7 in pairs(arg_139_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_142_7 then
						iter_142_7.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_139_1.var_.actorSpriteComps1038 = nil
			end

			local var_142_5 = arg_139_1.actors_["10030"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10030 = var_142_5.localPosition
				var_142_5.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10030", 4)

				for iter_142_8 = 0, var_142_5.childCount - 1 do
					local var_142_6 = var_142_5:GetChild(iter_142_8)

					if var_142_6.name == "split_1" or not string.find(var_142_6.name, "split") then
						var_142_6.gameObject:SetActive(true)
					else
						var_142_6.gameObject:SetActive(false)
					end
				end
			end

			local var_142_7 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_7 then
				var_142_5.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_139_1.time_ - 0) / var_142_7)
			end

			if arg_139_1.time_ >= 0 + var_142_7 and arg_139_1.time_ < 0 + var_142_7 + arg_142_0 then
				var_142_5.localPosition = Vector3.New(390, -390, 150)
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				local var_142_8 = arg_139_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_142_8 then
					arg_139_1.var_.alphaOldValue10030 = var_142_8.alpha
					arg_139_1.var_.characterEffect10030 = var_142_8
				end

				arg_139_1.var_.alphaOldValue10030 = 0
			end

			local var_142_9 = 0.0166666666666667

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_9 then
				if arg_139_1.var_.characterEffect10030 then
					arg_139_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_139_1.var_.alphaOldValue10030, 1, (arg_139_1.time_ - 0) / var_142_9)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_9 and arg_139_1.time_ < 0 + var_142_9 + arg_142_0 and arg_139_1.var_.characterEffect10030 then
				arg_139_1.var_.characterEffect10030.alpha = 1
			end

			local var_142_10 = 0
			local var_142_11 = 0.3

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_12 = arg_139_1:GetWordFromCfg(115301035)
				local var_142_13 = arg_139_1:FormatText(var_142_12.content)

				arg_139_1.text_.text = var_142_13

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_15 = 12 <= 0 and var_142_11 or var_142_11 * (utf8.len(var_142_13) / 12)

				if (12 <= 0 and var_142_11 or var_142_11 * (utf8.len(var_142_13) / 12)) > 0 and var_142_11 < var_142_15 then
					arg_139_1.talkMaxDuration = var_142_15

					if var_142_15 + var_142_10 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_15 + var_142_10
					end
				end

				arg_139_1.text_.text = var_142_13
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301035", "story_v_out_115301.awb") ~= 0 then
					local var_142_16 = manager.audio:GetVoiceLength("story_v_out_115301", "115301035", "story_v_out_115301.awb") / 1000

					if var_142_16 + var_142_10 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_16 + var_142_10
					end

					if var_142_12.prefab_name ~= "" and arg_139_1.actors_[var_142_12.prefab_name] ~= nil then
						local var_142_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_12.prefab_name].transform, "story_v_out_115301", "115301035", "story_v_out_115301.awb")

						arg_139_1:RecordAudio("115301035", var_142_17)
						arg_139_1:RecordAudio("115301035", var_142_17)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_115301", "115301035", "story_v_out_115301.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_115301", "115301035", "story_v_out_115301.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_18 = math.max(var_142_11, arg_139_1.talkMaxDuration)

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_18 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_10) / var_142_18

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_10 + var_142_18 and arg_139_1.time_ < var_142_10 + var_142_18 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play115301036 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 115301036
		arg_143_1.duration_ = 9.03

		local var_143_0 = {
			ja = 8.5,
			ko = 8.366,
			zh = 9.033,
			en = 7.733
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play115301037(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["10030"]) and arg_143_1.var_.actorSpriteComps10030 == nil then
				arg_143_1.var_.actorSpriteComps10030 = arg_143_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_0 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["10030"]) then
				if arg_143_1.var_.actorSpriteComps10030 then
					for iter_146_0, iter_146_1 in pairs(arg_143_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_146_1 then
							if arg_143_1.isInRecall_ then
								iter_146_1.color = Color.New(Mathf.Lerp(iter_146_1.color.r, arg_143_1.hightColor2.r, (arg_143_1.time_ - 0) / var_146_0), Mathf.Lerp(iter_146_1.color.g, arg_143_1.hightColor2.g, (arg_143_1.time_ - 0) / var_146_0), (Mathf.Lerp(iter_146_1.color.b, arg_143_1.hightColor2.b, (arg_143_1.time_ - 0) / var_146_0)))
							else
								local var_146_1 = Mathf.Lerp(iter_146_1.color.r, 0.5, (arg_143_1.time_ - 0) / var_146_0)

								iter_146_1.color = Color.New(var_146_1, var_146_1, var_146_1)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["10030"]) and arg_143_1.var_.actorSpriteComps10030 then
				for iter_146_2, iter_146_3 in pairs(arg_143_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_146_3 then
						iter_146_3.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_143_1.var_.actorSpriteComps10030 = nil
			end

			local var_146_2 = arg_143_1.actors_["1038"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.actorSpriteComps1038 == nil then
				arg_143_1.var_.actorSpriteComps1038 = var_146_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_3 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_3 and not isNil(var_146_2) then
				if arg_143_1.var_.actorSpriteComps1038 then
					for iter_146_4, iter_146_5 in pairs(arg_143_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_146_5 then
							if arg_143_1.isInRecall_ then
								iter_146_5.color = Color.New(Mathf.Lerp(iter_146_5.color.r, arg_143_1.hightColor1.r, (arg_143_1.time_ - 0) / var_146_3), Mathf.Lerp(iter_146_5.color.g, arg_143_1.hightColor1.g, (arg_143_1.time_ - 0) / var_146_3), (Mathf.Lerp(iter_146_5.color.b, arg_143_1.hightColor1.b, (arg_143_1.time_ - 0) / var_146_3)))
							else
								local var_146_4 = Mathf.Lerp(iter_146_5.color.r, 1, (arg_143_1.time_ - 0) / var_146_3)

								iter_146_5.color = Color.New(var_146_4, var_146_4, var_146_4)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_3 and arg_143_1.time_ < 0 + var_146_3 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.actorSpriteComps1038 then
				for iter_146_6, iter_146_7 in pairs(arg_143_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_146_7 then
						iter_146_7.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_143_1.var_.actorSpriteComps1038 = nil
			end

			local var_146_5 = arg_143_1.actors_["1038"].transform

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1038 = var_146_5.localPosition
				var_146_5.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("1038", 2)

				for iter_146_8 = 0, var_146_5.childCount - 1 do
					local var_146_6 = var_146_5:GetChild(iter_146_8)

					if var_146_6.name == "split_9" or not string.find(var_146_6.name, "split") then
						var_146_6.gameObject:SetActive(true)
					else
						var_146_6.gameObject:SetActive(false)
					end
				end
			end

			local var_146_7 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_7 then
				var_146_5.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_143_1.time_ - 0) / var_146_7)
			end

			if arg_143_1.time_ >= 0 + var_146_7 and arg_143_1.time_ < 0 + var_146_7 + arg_146_0 then
				var_146_5.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_146_8 = 0
			local var_146_9 = 0.825

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_8 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_10 = arg_143_1:GetWordFromCfg(115301036)
				local var_146_11 = arg_143_1:FormatText(var_146_10.content)

				arg_143_1.text_.text = var_146_11

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_13 = 33 <= 0 and var_146_9 or var_146_9 * (utf8.len(var_146_11) / 33)

				if (33 <= 0 and var_146_9 or var_146_9 * (utf8.len(var_146_11) / 33)) > 0 and var_146_9 < var_146_13 then
					arg_143_1.talkMaxDuration = var_146_13

					if var_146_13 + var_146_8 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_13 + var_146_8
					end
				end

				arg_143_1.text_.text = var_146_11
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301036", "story_v_out_115301.awb") ~= 0 then
					local var_146_14 = manager.audio:GetVoiceLength("story_v_out_115301", "115301036", "story_v_out_115301.awb") / 1000

					if var_146_14 + var_146_8 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_14 + var_146_8
					end

					if var_146_10.prefab_name ~= "" and arg_143_1.actors_[var_146_10.prefab_name] ~= nil then
						local var_146_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_10.prefab_name].transform, "story_v_out_115301", "115301036", "story_v_out_115301.awb")

						arg_143_1:RecordAudio("115301036", var_146_15)
						arg_143_1:RecordAudio("115301036", var_146_15)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_115301", "115301036", "story_v_out_115301.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_115301", "115301036", "story_v_out_115301.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_16 = math.max(var_146_9, arg_143_1.talkMaxDuration)

			if var_146_8 <= arg_143_1.time_ and arg_143_1.time_ < var_146_8 + var_146_16 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_8) / var_146_16

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_8 + var_146_16 and arg_143_1.time_ < var_146_8 + var_146_16 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play115301037 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 115301037
		arg_147_1.duration_ = 16.63

		local var_147_0 = {
			ja = 16.633,
			ko = 10.733,
			zh = 14.666,
			en = 13.8
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play115301038(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 1.3

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_1 = arg_147_1:GetWordFromCfg(115301037)
				local var_150_2 = arg_147_1:FormatText(var_150_1.content)

				arg_147_1.text_.text = var_150_2

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 52 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 52)

				if (52 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 52)) > 0 and var_150_0 < var_150_4 then
					arg_147_1.talkMaxDuration = var_150_4

					if var_150_4 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_4 + 0
					end
				end

				arg_147_1.text_.text = var_150_2
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301037", "story_v_out_115301.awb") ~= 0 then
					local var_150_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301037", "story_v_out_115301.awb") / 1000

					if var_150_5 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + 0
					end

					if var_150_1.prefab_name ~= "" and arg_147_1.actors_[var_150_1.prefab_name] ~= nil then
						local var_150_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_1.prefab_name].transform, "story_v_out_115301", "115301037", "story_v_out_115301.awb")

						arg_147_1:RecordAudio("115301037", var_150_6)
						arg_147_1:RecordAudio("115301037", var_150_6)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_115301", "115301037", "story_v_out_115301.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_115301", "115301037", "story_v_out_115301.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_7 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_7 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_7

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_7 and arg_147_1.time_ < 0 + var_150_7 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play115301038 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 115301038
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play115301039(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				local var_154_0 = arg_151_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_154_0 then
					arg_151_1.var_.alphaOldValue10030 = var_154_0.alpha
					arg_151_1.var_.characterEffect10030 = var_154_0
				end

				arg_151_1.var_.alphaOldValue10030 = 1
			end

			local var_154_1 = 0.333333333333333

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_1 then
				if arg_151_1.var_.characterEffect10030 then
					arg_151_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_151_1.var_.alphaOldValue10030, 0, (arg_151_1.time_ - 0) / var_154_1)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_1 and arg_151_1.time_ < 0 + var_154_1 + arg_154_0 and arg_151_1.var_.characterEffect10030 then
				arg_151_1.var_.characterEffect10030.alpha = 0
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				local var_154_2 = arg_151_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_154_2 then
					arg_151_1.var_.alphaOldValue1038 = var_154_2.alpha
					arg_151_1.var_.characterEffect1038 = var_154_2
				end

				arg_151_1.var_.alphaOldValue1038 = 1
			end

			local var_154_3 = 0.333333333333333

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_3 then
				if arg_151_1.var_.characterEffect1038 then
					arg_151_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_151_1.var_.alphaOldValue1038, 0, (arg_151_1.time_ - 0) / var_154_3)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_3 and arg_151_1.time_ < 0 + var_154_3 + arg_154_0 and arg_151_1.var_.characterEffect1038 then
				arg_151_1.var_.characterEffect1038.alpha = 0
			end

			local var_154_4 = 0
			local var_154_5 = 0.825

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_6 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(115301038).content)

				arg_151_1.text_.text = var_154_6

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_8 = 33 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_6) / 33)

				if (33 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_6) / 33)) > 0 and var_154_5 < var_154_8 then
					arg_151_1.talkMaxDuration = var_154_8

					if var_154_8 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_4
					end
				end

				arg_151_1.text_.text = var_154_6
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_9 = math.max(var_154_5, arg_151_1.talkMaxDuration)

			if var_154_4 <= arg_151_1.time_ and arg_151_1.time_ < var_154_4 + var_154_9 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_4) / var_154_9

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_4 + var_154_9 and arg_151_1.time_ < var_154_4 + var_154_9 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play115301039 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 115301039
		arg_155_1.duration_ = 11.27

		local var_155_0 = {
			ja = 11.266,
			ko = 10.866,
			zh = 9.533,
			en = 9.1
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play115301040(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos10030 = arg_155_1.actors_["10030"].transform.localPosition
				arg_155_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("10030", 3)

				for iter_158_0 = 0, arg_155_1.actors_["10030"].transform.childCount - 1 do
					local var_158_0 = arg_155_1.actors_["10030"].transform:GetChild(iter_158_0)

					if var_158_0.name == "split_3" or not string.find(var_158_0.name, "split") then
						var_158_0.gameObject:SetActive(true)
					else
						var_158_0.gameObject:SetActive(false)
					end
				end
			end

			local var_158_1 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_1 then
				arg_155_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_155_1.time_ - 0) / var_158_1)
			end

			if arg_155_1.time_ >= 0 + var_158_1 and arg_155_1.time_ < 0 + var_158_1 + arg_158_0 then
				arg_155_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			local var_158_2 = arg_155_1.actors_["10030"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps10030 == nil then
				arg_155_1.var_.actorSpriteComps10030 = var_158_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_3 = 0.2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_3 and not isNil(var_158_2) then
				if arg_155_1.var_.actorSpriteComps10030 then
					for iter_158_1, iter_158_2 in pairs(arg_155_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_158_2 then
							if arg_155_1.isInRecall_ then
								iter_158_2.color = Color.New(Mathf.Lerp(iter_158_2.color.r, arg_155_1.hightColor1.r, (arg_155_1.time_ - 0) / var_158_3), Mathf.Lerp(iter_158_2.color.g, arg_155_1.hightColor1.g, (arg_155_1.time_ - 0) / var_158_3), (Mathf.Lerp(iter_158_2.color.b, arg_155_1.hightColor1.b, (arg_155_1.time_ - 0) / var_158_3)))
							else
								local var_158_4 = Mathf.Lerp(iter_158_2.color.r, 1, (arg_155_1.time_ - 0) / var_158_3)

								iter_158_2.color = Color.New(var_158_4, var_158_4, var_158_4)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_3 and arg_155_1.time_ < 0 + var_158_3 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps10030 then
				for iter_158_3, iter_158_4 in pairs(arg_155_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_158_4 then
						iter_158_4.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_155_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				local var_158_5 = arg_155_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_158_5 then
					arg_155_1.var_.alphaOldValue10030 = var_158_5.alpha
					arg_155_1.var_.characterEffect10030 = var_158_5
				end

				arg_155_1.var_.alphaOldValue10030 = 0
			end

			local var_158_6 = 0.333333333333333

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_6 then
				if arg_155_1.var_.characterEffect10030 then
					arg_155_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_155_1.var_.alphaOldValue10030, 1, (arg_155_1.time_ - 0) / var_158_6)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_6 and arg_155_1.time_ < 0 + var_158_6 + arg_158_0 and arg_155_1.var_.characterEffect10030 then
				arg_155_1.var_.characterEffect10030.alpha = 1
			end

			local var_158_7 = 0
			local var_158_8 = 1.025

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_7 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_9 = arg_155_1:GetWordFromCfg(115301039)
				local var_158_10 = arg_155_1:FormatText(var_158_9.content)

				arg_155_1.text_.text = var_158_10

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_12 = 41 <= 0 and var_158_8 or var_158_8 * (utf8.len(var_158_10) / 41)

				if (41 <= 0 and var_158_8 or var_158_8 * (utf8.len(var_158_10) / 41)) > 0 and var_158_8 < var_158_12 then
					arg_155_1.talkMaxDuration = var_158_12

					if var_158_12 + var_158_7 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_12 + var_158_7
					end
				end

				arg_155_1.text_.text = var_158_10
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301039", "story_v_out_115301.awb") ~= 0 then
					local var_158_13 = manager.audio:GetVoiceLength("story_v_out_115301", "115301039", "story_v_out_115301.awb") / 1000

					if var_158_13 + var_158_7 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_13 + var_158_7
					end

					if var_158_9.prefab_name ~= "" and arg_155_1.actors_[var_158_9.prefab_name] ~= nil then
						local var_158_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_9.prefab_name].transform, "story_v_out_115301", "115301039", "story_v_out_115301.awb")

						arg_155_1:RecordAudio("115301039", var_158_14)
						arg_155_1:RecordAudio("115301039", var_158_14)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_115301", "115301039", "story_v_out_115301.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_115301", "115301039", "story_v_out_115301.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_15 = math.max(var_158_8, arg_155_1.talkMaxDuration)

			if var_158_7 <= arg_155_1.time_ and arg_155_1.time_ < var_158_7 + var_158_15 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_7) / var_158_15

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_7 + var_158_15 and arg_155_1.time_ < var_158_7 + var_158_15 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play115301040 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 115301040
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play115301041(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				local var_162_0 = arg_159_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_162_0 then
					arg_159_1.var_.alphaOldValue10030 = var_162_0.alpha
					arg_159_1.var_.characterEffect10030 = var_162_0
				end

				arg_159_1.var_.alphaOldValue10030 = 1
			end

			local var_162_1 = 0.333333333333333

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_1 then
				if arg_159_1.var_.characterEffect10030 then
					arg_159_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_159_1.var_.alphaOldValue10030, 0, (arg_159_1.time_ - 0) / var_162_1)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_1 and arg_159_1.time_ < 0 + var_162_1 + arg_162_0 and arg_159_1.var_.characterEffect10030 then
				arg_159_1.var_.characterEffect10030.alpha = 0
			end

			local var_162_2 = 0
			local var_162_3 = 1.175

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_2 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_4 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(115301040).content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_6 = 47 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_4) / 47)

				if (47 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_4) / 47)) > 0 and var_162_3 < var_162_6 then
					arg_159_1.talkMaxDuration = var_162_6

					if var_162_6 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_6 + var_162_2
					end
				end

				arg_159_1.text_.text = var_162_4
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_3, arg_159_1.talkMaxDuration)

			if var_162_2 <= arg_159_1.time_ and arg_159_1.time_ < var_162_2 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_2) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_2 + var_162_7 and arg_159_1.time_ < var_162_2 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play115301041 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 115301041
		arg_163_1.duration_ = 4.9

		local var_163_0 = {
			ja = 4.233,
			ko = 4.9,
			zh = 3.433,
			en = 4.1
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play115301042(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos10030 = arg_163_1.actors_["10030"].transform.localPosition
				arg_163_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("10030", 4)

				for iter_166_0 = 0, arg_163_1.actors_["10030"].transform.childCount - 1 do
					local var_166_0 = arg_163_1.actors_["10030"].transform:GetChild(iter_166_0)

					if var_166_0.name == "split_5" or not string.find(var_166_0.name, "split") then
						var_166_0.gameObject:SetActive(true)
					else
						var_166_0.gameObject:SetActive(false)
					end
				end
			end

			local var_166_1 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_1 then
				arg_163_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_163_1.time_ - 0) / var_166_1)
			end

			if arg_163_1.time_ >= 0 + var_166_1 and arg_163_1.time_ < 0 + var_166_1 + arg_166_0 then
				arg_163_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				local var_166_2 = arg_163_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_166_2 then
					arg_163_1.var_.alphaOldValue10030 = var_166_2.alpha
					arg_163_1.var_.characterEffect10030 = var_166_2
				end

				arg_163_1.var_.alphaOldValue10030 = 0
			end

			local var_166_3 = 0.333333333333333

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_3 then
				if arg_163_1.var_.characterEffect10030 then
					arg_163_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_163_1.var_.alphaOldValue10030, 1, (arg_163_1.time_ - 0) / var_166_3)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_3 and arg_163_1.time_ < 0 + var_166_3 + arg_166_0 and arg_163_1.var_.characterEffect10030 then
				arg_163_1.var_.characterEffect10030.alpha = 1
			end

			local var_166_4 = arg_163_1.actors_["10030"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_4) and arg_163_1.var_.actorSpriteComps10030 == nil then
				arg_163_1.var_.actorSpriteComps10030 = var_166_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_5 = 0.2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_5 and not isNil(var_166_4) then
				if arg_163_1.var_.actorSpriteComps10030 then
					for iter_166_1, iter_166_2 in pairs(arg_163_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_166_2 then
							if arg_163_1.isInRecall_ then
								iter_166_2.color = Color.New(Mathf.Lerp(iter_166_2.color.r, arg_163_1.hightColor1.r, (arg_163_1.time_ - 0) / var_166_5), Mathf.Lerp(iter_166_2.color.g, arg_163_1.hightColor1.g, (arg_163_1.time_ - 0) / var_166_5), (Mathf.Lerp(iter_166_2.color.b, arg_163_1.hightColor1.b, (arg_163_1.time_ - 0) / var_166_5)))
							else
								local var_166_6 = Mathf.Lerp(iter_166_2.color.r, 1, (arg_163_1.time_ - 0) / var_166_5)

								iter_166_2.color = Color.New(var_166_6, var_166_6, var_166_6)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_5 and arg_163_1.time_ < 0 + var_166_5 + arg_166_0 and not isNil(var_166_4) and arg_163_1.var_.actorSpriteComps10030 then
				for iter_166_3, iter_166_4 in pairs(arg_163_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_166_4 then
						iter_166_4.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_163_1.var_.actorSpriteComps10030 = nil
			end

			local var_166_7 = 0
			local var_166_8 = 0.3

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_7 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_9 = arg_163_1:GetWordFromCfg(115301041)
				local var_166_10 = arg_163_1:FormatText(var_166_9.content)

				arg_163_1.text_.text = var_166_10

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_12 = 12 <= 0 and var_166_8 or var_166_8 * (utf8.len(var_166_10) / 12)

				if (12 <= 0 and var_166_8 or var_166_8 * (utf8.len(var_166_10) / 12)) > 0 and var_166_8 < var_166_12 then
					arg_163_1.talkMaxDuration = var_166_12

					if var_166_12 + var_166_7 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_12 + var_166_7
					end
				end

				arg_163_1.text_.text = var_166_10
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301041", "story_v_out_115301.awb") ~= 0 then
					local var_166_13 = manager.audio:GetVoiceLength("story_v_out_115301", "115301041", "story_v_out_115301.awb") / 1000

					if var_166_13 + var_166_7 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_7
					end

					if var_166_9.prefab_name ~= "" and arg_163_1.actors_[var_166_9.prefab_name] ~= nil then
						local var_166_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_9.prefab_name].transform, "story_v_out_115301", "115301041", "story_v_out_115301.awb")

						arg_163_1:RecordAudio("115301041", var_166_14)
						arg_163_1:RecordAudio("115301041", var_166_14)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_115301", "115301041", "story_v_out_115301.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_115301", "115301041", "story_v_out_115301.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_15 = math.max(var_166_8, arg_163_1.talkMaxDuration)

			if var_166_7 <= arg_163_1.time_ and arg_163_1.time_ < var_166_7 + var_166_15 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_7) / var_166_15

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_7 + var_166_15 and arg_163_1.time_ < var_166_7 + var_166_15 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play115301042 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 115301042
		arg_167_1.duration_ = 5.2

		local var_167_0 = {
			ja = 5.2,
			ko = 2.666,
			zh = 4.766,
			en = 3.7
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play115301043(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1038 = arg_167_1.actors_["1038"].transform.localPosition
				arg_167_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("1038", 2)

				for iter_170_0 = 0, arg_167_1.actors_["1038"].transform.childCount - 1 do
					local var_170_0 = arg_167_1.actors_["1038"].transform:GetChild(iter_170_0)

					if var_170_0.name == "split_7" or not string.find(var_170_0.name, "split") then
						var_170_0.gameObject:SetActive(true)
					else
						var_170_0.gameObject:SetActive(false)
					end
				end
			end

			local var_170_1 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_1 then
				arg_167_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_167_1.time_ - 0) / var_170_1)
			end

			if arg_167_1.time_ >= 0 + var_170_1 and arg_167_1.time_ < 0 + var_170_1 + arg_170_0 then
				arg_167_1.actors_["1038"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_170_2 = arg_167_1.actors_["10030"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.actorSpriteComps10030 == nil then
				arg_167_1.var_.actorSpriteComps10030 = var_170_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_3 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_3 and not isNil(var_170_2) then
				if arg_167_1.var_.actorSpriteComps10030 then
					for iter_170_1, iter_170_2 in pairs(arg_167_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_170_2 then
							if arg_167_1.isInRecall_ then
								iter_170_2.color = Color.New(Mathf.Lerp(iter_170_2.color.r, arg_167_1.hightColor2.r, (arg_167_1.time_ - 0) / var_170_3), Mathf.Lerp(iter_170_2.color.g, arg_167_1.hightColor2.g, (arg_167_1.time_ - 0) / var_170_3), (Mathf.Lerp(iter_170_2.color.b, arg_167_1.hightColor2.b, (arg_167_1.time_ - 0) / var_170_3)))
							else
								local var_170_4 = Mathf.Lerp(iter_170_2.color.r, 0.5, (arg_167_1.time_ - 0) / var_170_3)

								iter_170_2.color = Color.New(var_170_4, var_170_4, var_170_4)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_3 and arg_167_1.time_ < 0 + var_170_3 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.actorSpriteComps10030 then
				for iter_170_3, iter_170_4 in pairs(arg_167_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_170_4 then
						iter_170_4.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_167_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				local var_170_5 = arg_167_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_170_5 then
					arg_167_1.var_.alphaOldValue1038 = var_170_5.alpha
					arg_167_1.var_.characterEffect1038 = var_170_5
				end

				arg_167_1.var_.alphaOldValue1038 = 0
			end

			local var_170_6 = 0.333333333333333

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_6 then
				if arg_167_1.var_.characterEffect1038 then
					arg_167_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_167_1.var_.alphaOldValue1038, 1, (arg_167_1.time_ - 0) / var_170_6)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_6 and arg_167_1.time_ < 0 + var_170_6 + arg_170_0 and arg_167_1.var_.characterEffect1038 then
				arg_167_1.var_.characterEffect1038.alpha = 1
			end

			local var_170_7 = arg_167_1.actors_["1038"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_7) and arg_167_1.var_.actorSpriteComps1038 == nil then
				arg_167_1.var_.actorSpriteComps1038 = var_170_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_8 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_8 and not isNil(var_170_7) then
				if arg_167_1.var_.actorSpriteComps1038 then
					for iter_170_5, iter_170_6 in pairs(arg_167_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_170_6 then
							if arg_167_1.isInRecall_ then
								iter_170_6.color = Color.New(Mathf.Lerp(iter_170_6.color.r, arg_167_1.hightColor1.r, (arg_167_1.time_ - 0) / var_170_8), Mathf.Lerp(iter_170_6.color.g, arg_167_1.hightColor1.g, (arg_167_1.time_ - 0) / var_170_8), (Mathf.Lerp(iter_170_6.color.b, arg_167_1.hightColor1.b, (arg_167_1.time_ - 0) / var_170_8)))
							else
								local var_170_9 = Mathf.Lerp(iter_170_6.color.r, 1, (arg_167_1.time_ - 0) / var_170_8)

								iter_170_6.color = Color.New(var_170_9, var_170_9, var_170_9)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_8 and arg_167_1.time_ < 0 + var_170_8 + arg_170_0 and not isNil(var_170_7) and arg_167_1.var_.actorSpriteComps1038 then
				for iter_170_7, iter_170_8 in pairs(arg_167_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_170_8 then
						iter_170_8.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_167_1.var_.actorSpriteComps1038 = nil
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:AudioAction("play", "music", "bgm_activity_1_3_warchess", "bgm_activity_1_3_warchess", "bgm_activity_1_3_warchess.awb")

				local var_170_12 = manager.audio:GetAudioName("bgm_activity_1_3_warchess", "bgm_activity_1_3_warchess")

				if "" ~= "" then
					if arg_167_1.bgmTxt_.text ~= var_170_12 and arg_167_1.bgmTxt_.text ~= "" then
						if arg_167_1.bgmTxt2_.text ~= "" then
							arg_167_1.bgmTxt_.text = arg_167_1.bgmTxt2_.text
						end

						arg_167_1.bgmTxt2_.text = var_170_12

						arg_167_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_167_1.bgmTxt_.text = var_170_12
						arg_167_1.bgmTxt2_.text = var_170_12
					end

					if arg_167_1.bgmTimer then
						arg_167_1.bgmTimer:Stop()

						arg_167_1.bgmTimer = nil
					end

					if arg_167_1.settingData.show_music_name == 1 then
						arg_167_1.musicController:SetSelectedState("show")
						arg_167_1.musicAnimator_:Play("open", 0, 0)

						if arg_167_1.settingData.music_time ~= 0 then
							arg_167_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_167_1.settingData.music_time), function()
								if arg_167_1 == nil or isNil(arg_167_1.bgmTxt_) then
									return
								end

								arg_167_1.musicController:SetSelectedState("hide")
								arg_167_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_170_13 = 0
			local var_170_14 = 0.25

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_13 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_15 = arg_167_1:GetWordFromCfg(115301042)
				local var_170_16 = arg_167_1:FormatText(var_170_15.content)

				arg_167_1.text_.text = var_170_16

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_18 = 10 <= 0 and var_170_14 or var_170_14 * (utf8.len(var_170_16) / 10)

				if (10 <= 0 and var_170_14 or var_170_14 * (utf8.len(var_170_16) / 10)) > 0 and var_170_14 < var_170_18 then
					arg_167_1.talkMaxDuration = var_170_18

					if var_170_18 + var_170_13 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_18 + var_170_13
					end
				end

				arg_167_1.text_.text = var_170_16
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301042", "story_v_out_115301.awb") ~= 0 then
					local var_170_19 = manager.audio:GetVoiceLength("story_v_out_115301", "115301042", "story_v_out_115301.awb") / 1000

					if var_170_19 + var_170_13 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_19 + var_170_13
					end

					if var_170_15.prefab_name ~= "" and arg_167_1.actors_[var_170_15.prefab_name] ~= nil then
						local var_170_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_15.prefab_name].transform, "story_v_out_115301", "115301042", "story_v_out_115301.awb")

						arg_167_1:RecordAudio("115301042", var_170_20)
						arg_167_1:RecordAudio("115301042", var_170_20)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_115301", "115301042", "story_v_out_115301.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_115301", "115301042", "story_v_out_115301.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_21 = math.max(var_170_14, arg_167_1.talkMaxDuration)

			if var_170_13 <= arg_167_1.time_ and arg_167_1.time_ < var_170_13 + var_170_21 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_13) / var_170_21

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_13 + var_170_21 and arg_167_1.time_ < var_170_13 + var_170_21 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play115301043 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 115301043
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play115301044(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["1038"]) and arg_172_1.var_.actorSpriteComps1038 == nil then
				arg_172_1.var_.actorSpriteComps1038 = arg_172_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_0 = 0.2

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["1038"]) then
				if arg_172_1.var_.actorSpriteComps1038 then
					for iter_175_0, iter_175_1 in pairs(arg_172_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_175_1 then
							if arg_172_1.isInRecall_ then
								iter_175_1.color = Color.New(Mathf.Lerp(iter_175_1.color.r, arg_172_1.hightColor2.r, (arg_172_1.time_ - 0) / var_175_0), Mathf.Lerp(iter_175_1.color.g, arg_172_1.hightColor2.g, (arg_172_1.time_ - 0) / var_175_0), (Mathf.Lerp(iter_175_1.color.b, arg_172_1.hightColor2.b, (arg_172_1.time_ - 0) / var_175_0)))
							else
								local var_175_1 = Mathf.Lerp(iter_175_1.color.r, 0.5, (arg_172_1.time_ - 0) / var_175_0)

								iter_175_1.color = Color.New(var_175_1, var_175_1, var_175_1)
							end
						end
					end
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["1038"]) and arg_172_1.var_.actorSpriteComps1038 then
				for iter_175_2, iter_175_3 in pairs(arg_172_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_175_3 then
						iter_175_3.color = arg_172_1.isInRecall_ and (arg_172_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_172_1.var_.actorSpriteComps1038 = nil
			end

			local var_175_2 = 0
			local var_175_3 = 0.65

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_2 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_4 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(115301043).content)

				arg_172_1.text_.text = var_175_4

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_6 = 26 <= 0 and var_175_3 or var_175_3 * (utf8.len(var_175_4) / 26)

				if (26 <= 0 and var_175_3 or var_175_3 * (utf8.len(var_175_4) / 26)) > 0 and var_175_3 < var_175_6 then
					arg_172_1.talkMaxDuration = var_175_6

					if var_175_6 + var_175_2 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_6 + var_175_2
					end
				end

				arg_172_1.text_.text = var_175_4
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_7 = math.max(var_175_3, arg_172_1.talkMaxDuration)

			if var_175_2 <= arg_172_1.time_ and arg_172_1.time_ < var_175_2 + var_175_7 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_2) / var_175_7

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_2 + var_175_7 and arg_172_1.time_ < var_175_2 + var_175_7 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play115301044 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 115301044
		arg_176_1.duration_ = 4.57

		local var_176_0 = {
			ja = 4.566,
			ko = 3.666,
			zh = 3.933,
			en = 4.133
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play115301045(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["10030"]) and arg_176_1.var_.actorSpriteComps10030 == nil then
				arg_176_1.var_.actorSpriteComps10030 = arg_176_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_0 = 0.2

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 and not isNil(arg_176_1.actors_["10030"]) then
				if arg_176_1.var_.actorSpriteComps10030 then
					for iter_179_0, iter_179_1 in pairs(arg_176_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_179_1 then
							if arg_176_1.isInRecall_ then
								iter_179_1.color = Color.New(Mathf.Lerp(iter_179_1.color.r, arg_176_1.hightColor1.r, (arg_176_1.time_ - 0) / var_179_0), Mathf.Lerp(iter_179_1.color.g, arg_176_1.hightColor1.g, (arg_176_1.time_ - 0) / var_179_0), (Mathf.Lerp(iter_179_1.color.b, arg_176_1.hightColor1.b, (arg_176_1.time_ - 0) / var_179_0)))
							else
								local var_179_1 = Mathf.Lerp(iter_179_1.color.r, 1, (arg_176_1.time_ - 0) / var_179_0)

								iter_179_1.color = Color.New(var_179_1, var_179_1, var_179_1)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 and not isNil(arg_176_1.actors_["10030"]) and arg_176_1.var_.actorSpriteComps10030 then
				for iter_179_2, iter_179_3 in pairs(arg_176_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_179_3 then
						iter_179_3.color = arg_176_1.isInRecall_ and (arg_176_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_176_1.var_.actorSpriteComps10030 = nil
			end

			local var_179_2 = arg_176_1.actors_["10030"].transform

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos10030 = var_179_2.localPosition
				var_179_2.localScale = Vector3.New(1, 1, 1)

				arg_176_1:CheckSpriteTmpPos("10030", 4)

				for iter_179_4 = 0, var_179_2.childCount - 1 do
					local var_179_3 = var_179_2:GetChild(iter_179_4)

					if var_179_3.name == "split_1" or not string.find(var_179_3.name, "split") then
						var_179_3.gameObject:SetActive(true)
					else
						var_179_3.gameObject:SetActive(false)
					end
				end
			end

			local var_179_4 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_4 then
				var_179_2.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_176_1.time_ - 0) / var_179_4)
			end

			if arg_176_1.time_ >= 0 + var_179_4 and arg_176_1.time_ < 0 + var_179_4 + arg_179_0 then
				var_179_2.localPosition = Vector3.New(390, -390, 150)
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				local var_179_5 = arg_176_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_179_5 then
					arg_176_1.var_.alphaOldValue10030 = var_179_5.alpha
					arg_176_1.var_.characterEffect10030 = var_179_5
				end

				arg_176_1.var_.alphaOldValue10030 = 0
			end

			local var_179_6 = 0.0166666666666667

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_6 then
				if arg_176_1.var_.characterEffect10030 then
					arg_176_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_176_1.var_.alphaOldValue10030, 1, (arg_176_1.time_ - 0) / var_179_6)
				end
			end

			if arg_176_1.time_ >= 0 + var_179_6 and arg_176_1.time_ < 0 + var_179_6 + arg_179_0 and arg_176_1.var_.characterEffect10030 then
				arg_176_1.var_.characterEffect10030.alpha = 1
			end

			local var_179_7 = 0
			local var_179_8 = 0.35

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_7 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_9 = arg_176_1:GetWordFromCfg(115301044)
				local var_179_10 = arg_176_1:FormatText(var_179_9.content)

				arg_176_1.text_.text = var_179_10

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_12 = 14 <= 0 and var_179_8 or var_179_8 * (utf8.len(var_179_10) / 14)

				if (14 <= 0 and var_179_8 or var_179_8 * (utf8.len(var_179_10) / 14)) > 0 and var_179_8 < var_179_12 then
					arg_176_1.talkMaxDuration = var_179_12

					if var_179_12 + var_179_7 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_12 + var_179_7
					end
				end

				arg_176_1.text_.text = var_179_10
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301044", "story_v_out_115301.awb") ~= 0 then
					local var_179_13 = manager.audio:GetVoiceLength("story_v_out_115301", "115301044", "story_v_out_115301.awb") / 1000

					if var_179_13 + var_179_7 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_13 + var_179_7
					end

					if var_179_9.prefab_name ~= "" and arg_176_1.actors_[var_179_9.prefab_name] ~= nil then
						local var_179_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_9.prefab_name].transform, "story_v_out_115301", "115301044", "story_v_out_115301.awb")

						arg_176_1:RecordAudio("115301044", var_179_14)
						arg_176_1:RecordAudio("115301044", var_179_14)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_115301", "115301044", "story_v_out_115301.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_115301", "115301044", "story_v_out_115301.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_15 = math.max(var_179_8, arg_176_1.talkMaxDuration)

			if var_179_7 <= arg_176_1.time_ and arg_176_1.time_ < var_179_7 + var_179_15 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_7) / var_179_15

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_7 + var_179_15 and arg_176_1.time_ < var_179_7 + var_179_15 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play115301045 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 115301045
		arg_180_1.duration_ = 2.8

		local var_180_0 = {
			ja = 2.4,
			ko = 1.166,
			zh = 2.8,
			en = 1.3
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play115301046(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos1038 = arg_180_1.actors_["1038"].transform.localPosition
				arg_180_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_180_1:CheckSpriteTmpPos("1038", 2)

				for iter_183_0 = 0, arg_180_1.actors_["1038"].transform.childCount - 1 do
					local var_183_0 = arg_180_1.actors_["1038"].transform:GetChild(iter_183_0)

					if var_183_0.name == "split_1" or not string.find(var_183_0.name, "split") then
						var_183_0.gameObject:SetActive(true)
					else
						var_183_0.gameObject:SetActive(false)
					end
				end
			end

			local var_183_1 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_1 then
				arg_180_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_180_1.time_ - 0) / var_183_1)
			end

			if arg_180_1.time_ >= 0 + var_183_1 and arg_180_1.time_ < 0 + var_183_1 + arg_183_0 then
				arg_180_1.actors_["1038"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_183_2 = arg_180_1.actors_["10030"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_2) and arg_180_1.var_.actorSpriteComps10030 == nil then
				arg_180_1.var_.actorSpriteComps10030 = var_183_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_3 = 0.2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_3 and not isNil(var_183_2) then
				if arg_180_1.var_.actorSpriteComps10030 then
					for iter_183_1, iter_183_2 in pairs(arg_180_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_183_2 then
							if arg_180_1.isInRecall_ then
								iter_183_2.color = Color.New(Mathf.Lerp(iter_183_2.color.r, arg_180_1.hightColor2.r, (arg_180_1.time_ - 0) / var_183_3), Mathf.Lerp(iter_183_2.color.g, arg_180_1.hightColor2.g, (arg_180_1.time_ - 0) / var_183_3), (Mathf.Lerp(iter_183_2.color.b, arg_180_1.hightColor2.b, (arg_180_1.time_ - 0) / var_183_3)))
							else
								local var_183_4 = Mathf.Lerp(iter_183_2.color.r, 0.5, (arg_180_1.time_ - 0) / var_183_3)

								iter_183_2.color = Color.New(var_183_4, var_183_4, var_183_4)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= 0 + var_183_3 and arg_180_1.time_ < 0 + var_183_3 + arg_183_0 and not isNil(var_183_2) and arg_180_1.var_.actorSpriteComps10030 then
				for iter_183_3, iter_183_4 in pairs(arg_180_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_183_4 then
						iter_183_4.color = arg_180_1.isInRecall_ and (arg_180_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_180_1.var_.actorSpriteComps10030 = nil
			end

			local var_183_5 = arg_180_1.actors_["1038"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_5) and arg_180_1.var_.actorSpriteComps1038 == nil then
				arg_180_1.var_.actorSpriteComps1038 = var_183_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_6 = 0.2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_6 and not isNil(var_183_5) then
				if arg_180_1.var_.actorSpriteComps1038 then
					for iter_183_5, iter_183_6 in pairs(arg_180_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_183_6 then
							if arg_180_1.isInRecall_ then
								iter_183_6.color = Color.New(Mathf.Lerp(iter_183_6.color.r, arg_180_1.hightColor1.r, (arg_180_1.time_ - 0) / var_183_6), Mathf.Lerp(iter_183_6.color.g, arg_180_1.hightColor1.g, (arg_180_1.time_ - 0) / var_183_6), (Mathf.Lerp(iter_183_6.color.b, arg_180_1.hightColor1.b, (arg_180_1.time_ - 0) / var_183_6)))
							else
								local var_183_7 = Mathf.Lerp(iter_183_6.color.r, 1, (arg_180_1.time_ - 0) / var_183_6)

								iter_183_6.color = Color.New(var_183_7, var_183_7, var_183_7)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= 0 + var_183_6 and arg_180_1.time_ < 0 + var_183_6 + arg_183_0 and not isNil(var_183_5) and arg_180_1.var_.actorSpriteComps1038 then
				for iter_183_7, iter_183_8 in pairs(arg_180_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_183_8 then
						iter_183_8.color = arg_180_1.isInRecall_ and (arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_180_1.var_.actorSpriteComps1038 = nil
			end

			local var_183_8 = 0
			local var_183_9 = 0.125

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_8 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_10 = arg_180_1:GetWordFromCfg(115301045)
				local var_183_11 = arg_180_1:FormatText(var_183_10.content)

				arg_180_1.text_.text = var_183_11

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_13 = 5 <= 0 and var_183_9 or var_183_9 * (utf8.len(var_183_11) / 5)

				if (5 <= 0 and var_183_9 or var_183_9 * (utf8.len(var_183_11) / 5)) > 0 and var_183_9 < var_183_13 then
					arg_180_1.talkMaxDuration = var_183_13

					if var_183_13 + var_183_8 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_13 + var_183_8
					end
				end

				arg_180_1.text_.text = var_183_11
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301045", "story_v_out_115301.awb") ~= 0 then
					local var_183_14 = manager.audio:GetVoiceLength("story_v_out_115301", "115301045", "story_v_out_115301.awb") / 1000

					if var_183_14 + var_183_8 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_14 + var_183_8
					end

					if var_183_10.prefab_name ~= "" and arg_180_1.actors_[var_183_10.prefab_name] ~= nil then
						local var_183_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_10.prefab_name].transform, "story_v_out_115301", "115301045", "story_v_out_115301.awb")

						arg_180_1:RecordAudio("115301045", var_183_15)
						arg_180_1:RecordAudio("115301045", var_183_15)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_115301", "115301045", "story_v_out_115301.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_115301", "115301045", "story_v_out_115301.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_16 = math.max(var_183_9, arg_180_1.talkMaxDuration)

			if var_183_8 <= arg_180_1.time_ and arg_180_1.time_ < var_183_8 + var_183_16 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_8) / var_183_16

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_8 + var_183_16 and arg_180_1.time_ < var_183_8 + var_183_16 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play115301046 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 115301046
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play115301047(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				local var_187_0 = arg_184_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_187_0 then
					arg_184_1.var_.alphaOldValue10030 = var_187_0.alpha
					arg_184_1.var_.characterEffect10030 = var_187_0
				end

				arg_184_1.var_.alphaOldValue10030 = 1
			end

			local var_187_1 = 0.333333333333333

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_1 then
				if arg_184_1.var_.characterEffect10030 then
					arg_184_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_184_1.var_.alphaOldValue10030, 0, (arg_184_1.time_ - 0) / var_187_1)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_1 and arg_184_1.time_ < 0 + var_187_1 + arg_187_0 and arg_184_1.var_.characterEffect10030 then
				arg_184_1.var_.characterEffect10030.alpha = 0
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				local var_187_2 = arg_184_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_187_2 then
					arg_184_1.var_.alphaOldValue1038 = var_187_2.alpha
					arg_184_1.var_.characterEffect1038 = var_187_2
				end

				arg_184_1.var_.alphaOldValue1038 = 1
			end

			local var_187_3 = 0.333333333333333

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_3 then
				if arg_184_1.var_.characterEffect1038 then
					arg_184_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_184_1.var_.alphaOldValue1038, 0, (arg_184_1.time_ - 0) / var_187_3)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_3 and arg_184_1.time_ < 0 + var_187_3 + arg_187_0 and arg_184_1.var_.characterEffect1038 then
				arg_184_1.var_.characterEffect1038.alpha = 0
			end

			local var_187_4 = 0
			local var_187_5 = 0.6

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_6 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(115301046).content)

				arg_184_1.text_.text = var_187_6

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_8 = 24 <= 0 and var_187_5 or var_187_5 * (utf8.len(var_187_6) / 24)

				if (24 <= 0 and var_187_5 or var_187_5 * (utf8.len(var_187_6) / 24)) > 0 and var_187_5 < var_187_8 then
					arg_184_1.talkMaxDuration = var_187_8

					if var_187_8 + var_187_4 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_8 + var_187_4
					end
				end

				arg_184_1.text_.text = var_187_6
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_9 = math.max(var_187_5, arg_184_1.talkMaxDuration)

			if var_187_4 <= arg_184_1.time_ and arg_184_1.time_ < var_187_4 + var_187_9 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_4) / var_187_9

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_4 + var_187_9 and arg_184_1.time_ < var_187_4 + var_187_9 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play115301047 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 115301047
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play115301048(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0.9

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_1 = arg_188_1:FormatText(arg_188_1:GetWordFromCfg(115301047).content)

				arg_188_1.text_.text = var_191_1

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_3 = 36 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_1) / 36)

				if (36 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_1) / 36)) > 0 and var_191_0 < var_191_3 then
					arg_188_1.talkMaxDuration = var_191_3

					if var_191_3 + 0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_3 + 0
					end
				end

				arg_188_1.text_.text = var_191_1
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_4 = math.max(var_191_0, arg_188_1.talkMaxDuration)

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_4 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - 0) / var_191_4

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= 0 + var_191_4 and arg_188_1.time_ < 0 + var_191_4 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play115301048 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 115301048
		arg_192_1.duration_ = 16.03

		local var_192_0 = {
			ja = 16.033,
			ko = 6.833,
			zh = 8.3,
			en = 8.766
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play115301049(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos10030 = arg_192_1.actors_["10030"].transform.localPosition
				arg_192_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("10030", 3)

				for iter_195_0 = 0, arg_192_1.actors_["10030"].transform.childCount - 1 do
					local var_195_0 = arg_192_1.actors_["10030"].transform:GetChild(iter_195_0)

					if var_195_0.name == "split_1" or not string.find(var_195_0.name, "split") then
						var_195_0.gameObject:SetActive(true)
					else
						var_195_0.gameObject:SetActive(false)
					end
				end
			end

			local var_195_1 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_1 then
				arg_192_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_192_1.time_ - 0) / var_195_1)
			end

			if arg_192_1.time_ >= 0 + var_195_1 and arg_192_1.time_ < 0 + var_195_1 + arg_195_0 then
				arg_192_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			local var_195_2 = arg_192_1.actors_["10030"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_2) and arg_192_1.var_.actorSpriteComps10030 == nil then
				arg_192_1.var_.actorSpriteComps10030 = var_195_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_3 = 0.2

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_3 and not isNil(var_195_2) then
				if arg_192_1.var_.actorSpriteComps10030 then
					for iter_195_1, iter_195_2 in pairs(arg_192_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_195_2 then
							if arg_192_1.isInRecall_ then
								iter_195_2.color = Color.New(Mathf.Lerp(iter_195_2.color.r, arg_192_1.hightColor1.r, (arg_192_1.time_ - 0) / var_195_3), Mathf.Lerp(iter_195_2.color.g, arg_192_1.hightColor1.g, (arg_192_1.time_ - 0) / var_195_3), (Mathf.Lerp(iter_195_2.color.b, arg_192_1.hightColor1.b, (arg_192_1.time_ - 0) / var_195_3)))
							else
								local var_195_4 = Mathf.Lerp(iter_195_2.color.r, 1, (arg_192_1.time_ - 0) / var_195_3)

								iter_195_2.color = Color.New(var_195_4, var_195_4, var_195_4)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= 0 + var_195_3 and arg_192_1.time_ < 0 + var_195_3 + arg_195_0 and not isNil(var_195_2) and arg_192_1.var_.actorSpriteComps10030 then
				for iter_195_3, iter_195_4 in pairs(arg_192_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_195_4 then
						iter_195_4.color = arg_192_1.isInRecall_ and (arg_192_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_192_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				local var_195_5 = arg_192_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_195_5 then
					arg_192_1.var_.alphaOldValue10030 = var_195_5.alpha
					arg_192_1.var_.characterEffect10030 = var_195_5
				end

				arg_192_1.var_.alphaOldValue10030 = 0
			end

			local var_195_6 = 0.333333333333333

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_6 then
				if arg_192_1.var_.characterEffect10030 then
					arg_192_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_192_1.var_.alphaOldValue10030, 1, (arg_192_1.time_ - 0) / var_195_6)
				end
			end

			if arg_192_1.time_ >= 0 + var_195_6 and arg_192_1.time_ < 0 + var_195_6 + arg_195_0 and arg_192_1.var_.characterEffect10030 then
				arg_192_1.var_.characterEffect10030.alpha = 1
			end

			local var_195_7 = 0
			local var_195_8 = 0.575

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_7 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_9 = arg_192_1:GetWordFromCfg(115301048)
				local var_195_10 = arg_192_1:FormatText(var_195_9.content)

				arg_192_1.text_.text = var_195_10

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_12 = 23 <= 0 and var_195_8 or var_195_8 * (utf8.len(var_195_10) / 23)

				if (23 <= 0 and var_195_8 or var_195_8 * (utf8.len(var_195_10) / 23)) > 0 and var_195_8 < var_195_12 then
					arg_192_1.talkMaxDuration = var_195_12

					if var_195_12 + var_195_7 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_12 + var_195_7
					end
				end

				arg_192_1.text_.text = var_195_10
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301048", "story_v_out_115301.awb") ~= 0 then
					local var_195_13 = manager.audio:GetVoiceLength("story_v_out_115301", "115301048", "story_v_out_115301.awb") / 1000

					if var_195_13 + var_195_7 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_13 + var_195_7
					end

					if var_195_9.prefab_name ~= "" and arg_192_1.actors_[var_195_9.prefab_name] ~= nil then
						local var_195_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_9.prefab_name].transform, "story_v_out_115301", "115301048", "story_v_out_115301.awb")

						arg_192_1:RecordAudio("115301048", var_195_14)
						arg_192_1:RecordAudio("115301048", var_195_14)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_115301", "115301048", "story_v_out_115301.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_115301", "115301048", "story_v_out_115301.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_15 = math.max(var_195_8, arg_192_1.talkMaxDuration)

			if var_195_7 <= arg_192_1.time_ and arg_192_1.time_ < var_195_7 + var_195_15 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_7) / var_195_15

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_7 + var_195_15 and arg_192_1.time_ < var_195_7 + var_195_15 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play115301049 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 115301049
		arg_196_1.duration_ = 9.17

		local var_196_0 = {
			ja = 8.3,
			ko = 6.566,
			zh = 7.233,
			en = 9.166
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play115301050(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0.725

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_1 = arg_196_1:GetWordFromCfg(115301049)
				local var_199_2 = arg_196_1:FormatText(var_199_1.content)

				arg_196_1.text_.text = var_199_2

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_4 = 29 <= 0 and var_199_0 or var_199_0 * (utf8.len(var_199_2) / 29)

				if (29 <= 0 and var_199_0 or var_199_0 * (utf8.len(var_199_2) / 29)) > 0 and var_199_0 < var_199_4 then
					arg_196_1.talkMaxDuration = var_199_4

					if var_199_4 + 0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_4 + 0
					end
				end

				arg_196_1.text_.text = var_199_2
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301049", "story_v_out_115301.awb") ~= 0 then
					local var_199_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301049", "story_v_out_115301.awb") / 1000

					if var_199_5 + 0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_5 + 0
					end

					if var_199_1.prefab_name ~= "" and arg_196_1.actors_[var_199_1.prefab_name] ~= nil then
						local var_199_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_1.prefab_name].transform, "story_v_out_115301", "115301049", "story_v_out_115301.awb")

						arg_196_1:RecordAudio("115301049", var_199_6)
						arg_196_1:RecordAudio("115301049", var_199_6)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_115301", "115301049", "story_v_out_115301.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_115301", "115301049", "story_v_out_115301.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_7 = math.max(var_199_0, arg_196_1.talkMaxDuration)

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_7 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - 0) / var_199_7

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= 0 + var_199_7 and arg_196_1.time_ < 0 + var_199_7 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play115301050 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 115301050
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play115301051(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				local var_203_0 = arg_200_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_203_0 then
					arg_200_1.var_.alphaOldValue10030 = var_203_0.alpha
					arg_200_1.var_.characterEffect10030 = var_203_0
				end

				arg_200_1.var_.alphaOldValue10030 = 1
			end

			local var_203_1 = 0.333333333333333

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_1 then
				if arg_200_1.var_.characterEffect10030 then
					arg_200_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_200_1.var_.alphaOldValue10030, 0, (arg_200_1.time_ - 0) / var_203_1)
				end
			end

			if arg_200_1.time_ >= 0 + var_203_1 and arg_200_1.time_ < 0 + var_203_1 + arg_203_0 and arg_200_1.var_.characterEffect10030 then
				arg_200_1.var_.characterEffect10030.alpha = 0
			end

			local var_203_2 = 0
			local var_203_3 = 1.575

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_2 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_4 = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(115301050).content)

				arg_200_1.text_.text = var_203_4

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_6 = 63 <= 0 and var_203_3 or var_203_3 * (utf8.len(var_203_4) / 63)

				if (63 <= 0 and var_203_3 or var_203_3 * (utf8.len(var_203_4) / 63)) > 0 and var_203_3 < var_203_6 then
					arg_200_1.talkMaxDuration = var_203_6

					if var_203_6 + var_203_2 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_6 + var_203_2
					end
				end

				arg_200_1.text_.text = var_203_4
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_7 = math.max(var_203_3, arg_200_1.talkMaxDuration)

			if var_203_2 <= arg_200_1.time_ and arg_200_1.time_ < var_203_2 + var_203_7 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_2) / var_203_7

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_2 + var_203_7 and arg_200_1.time_ < var_203_2 + var_203_7 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play115301051 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 115301051
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play115301052(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 1.075

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, false)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_1 = arg_204_1:FormatText(arg_204_1:GetWordFromCfg(115301051).content)

				arg_204_1.text_.text = var_207_1

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_3 = 43 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_1) / 43)

				if (43 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_1) / 43)) > 0 and var_207_0 < var_207_3 then
					arg_204_1.talkMaxDuration = var_207_3

					if var_207_3 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_3 + 0
					end
				end

				arg_204_1.text_.text = var_207_1
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_4 = math.max(var_207_0, arg_204_1.talkMaxDuration)

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_4 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - 0) / var_207_4

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= 0 + var_207_4 and arg_204_1.time_ < 0 + var_207_4 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play115301052 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 115301052
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play115301053(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 1.6

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_1 = arg_208_1:FormatText(arg_208_1:GetWordFromCfg(115301052).content)

				arg_208_1.text_.text = var_211_1

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_3 = 64 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_1) / 64)

				if (64 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_1) / 64)) > 0 and var_211_0 < var_211_3 then
					arg_208_1.talkMaxDuration = var_211_3

					if var_211_3 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_3 + 0
					end
				end

				arg_208_1.text_.text = var_211_1
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_4 = math.max(var_211_0, arg_208_1.talkMaxDuration)

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_4 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - 0) / var_211_4

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= 0 + var_211_4 and arg_208_1.time_ < 0 + var_211_4 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play115301053 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 115301053
		arg_212_1.duration_ = 7.8

		local var_212_0 = {
			ja = 7.8,
			ko = 6.866,
			zh = 6.933,
			en = 7.366
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play115301054(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos10030 = arg_212_1.actors_["10030"].transform.localPosition
				arg_212_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_212_1:CheckSpriteTmpPos("10030", 3)

				for iter_215_0 = 0, arg_212_1.actors_["10030"].transform.childCount - 1 do
					local var_215_0 = arg_212_1.actors_["10030"].transform:GetChild(iter_215_0)

					if var_215_0.name == "split_3" or not string.find(var_215_0.name, "split") then
						var_215_0.gameObject:SetActive(true)
					else
						var_215_0.gameObject:SetActive(false)
					end
				end
			end

			local var_215_1 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_1 then
				arg_212_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_212_1.time_ - 0) / var_215_1)
			end

			if arg_212_1.time_ >= 0 + var_215_1 and arg_212_1.time_ < 0 + var_215_1 + arg_215_0 then
				arg_212_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			local var_215_2 = arg_212_1.actors_["10030"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_2) and arg_212_1.var_.actorSpriteComps10030 == nil then
				arg_212_1.var_.actorSpriteComps10030 = var_215_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_3 = 0.2

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_3 and not isNil(var_215_2) then
				if arg_212_1.var_.actorSpriteComps10030 then
					for iter_215_1, iter_215_2 in pairs(arg_212_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_215_2 then
							if arg_212_1.isInRecall_ then
								iter_215_2.color = Color.New(Mathf.Lerp(iter_215_2.color.r, arg_212_1.hightColor1.r, (arg_212_1.time_ - 0) / var_215_3), Mathf.Lerp(iter_215_2.color.g, arg_212_1.hightColor1.g, (arg_212_1.time_ - 0) / var_215_3), (Mathf.Lerp(iter_215_2.color.b, arg_212_1.hightColor1.b, (arg_212_1.time_ - 0) / var_215_3)))
							else
								local var_215_4 = Mathf.Lerp(iter_215_2.color.r, 1, (arg_212_1.time_ - 0) / var_215_3)

								iter_215_2.color = Color.New(var_215_4, var_215_4, var_215_4)
							end
						end
					end
				end
			end

			if arg_212_1.time_ >= 0 + var_215_3 and arg_212_1.time_ < 0 + var_215_3 + arg_215_0 and not isNil(var_215_2) and arg_212_1.var_.actorSpriteComps10030 then
				for iter_215_3, iter_215_4 in pairs(arg_212_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_215_4 then
						iter_215_4.color = arg_212_1.isInRecall_ and (arg_212_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_212_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				local var_215_5 = arg_212_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_215_5 then
					arg_212_1.var_.alphaOldValue10030 = var_215_5.alpha
					arg_212_1.var_.characterEffect10030 = var_215_5
				end

				arg_212_1.var_.alphaOldValue10030 = 0
			end

			local var_215_6 = 0.333333333333333

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_6 then
				if arg_212_1.var_.characterEffect10030 then
					arg_212_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_212_1.var_.alphaOldValue10030, 1, (arg_212_1.time_ - 0) / var_215_6)
				end
			end

			if arg_212_1.time_ >= 0 + var_215_6 and arg_212_1.time_ < 0 + var_215_6 + arg_215_0 and arg_212_1.var_.characterEffect10030 then
				arg_212_1.var_.characterEffect10030.alpha = 1
			end

			local var_215_7 = 0
			local var_215_8 = 0.775

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_7 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_9 = arg_212_1:GetWordFromCfg(115301053)
				local var_215_10 = arg_212_1:FormatText(var_215_9.content)

				arg_212_1.text_.text = var_215_10

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_12 = 31 <= 0 and var_215_8 or var_215_8 * (utf8.len(var_215_10) / 31)

				if (31 <= 0 and var_215_8 or var_215_8 * (utf8.len(var_215_10) / 31)) > 0 and var_215_8 < var_215_12 then
					arg_212_1.talkMaxDuration = var_215_12

					if var_215_12 + var_215_7 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_12 + var_215_7
					end
				end

				arg_212_1.text_.text = var_215_10
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301053", "story_v_out_115301.awb") ~= 0 then
					local var_215_13 = manager.audio:GetVoiceLength("story_v_out_115301", "115301053", "story_v_out_115301.awb") / 1000

					if var_215_13 + var_215_7 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_13 + var_215_7
					end

					if var_215_9.prefab_name ~= "" and arg_212_1.actors_[var_215_9.prefab_name] ~= nil then
						local var_215_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_9.prefab_name].transform, "story_v_out_115301", "115301053", "story_v_out_115301.awb")

						arg_212_1:RecordAudio("115301053", var_215_14)
						arg_212_1:RecordAudio("115301053", var_215_14)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_115301", "115301053", "story_v_out_115301.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_115301", "115301053", "story_v_out_115301.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_15 = math.max(var_215_8, arg_212_1.talkMaxDuration)

			if var_215_7 <= arg_212_1.time_ and arg_212_1.time_ < var_215_7 + var_215_15 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_7) / var_215_15

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_7 + var_215_15 and arg_212_1.time_ < var_215_7 + var_215_15 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play115301054 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 115301054
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play115301055(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				local var_219_0 = arg_216_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_219_0 then
					arg_216_1.var_.alphaOldValue10030 = var_219_0.alpha
					arg_216_1.var_.characterEffect10030 = var_219_0
				end

				arg_216_1.var_.alphaOldValue10030 = 1
			end

			local var_219_1 = 0.333333333333333

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_1 then
				if arg_216_1.var_.characterEffect10030 then
					arg_216_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_216_1.var_.alphaOldValue10030, 0, (arg_216_1.time_ - 0) / var_219_1)
				end
			end

			if arg_216_1.time_ >= 0 + var_219_1 and arg_216_1.time_ < 0 + var_219_1 + arg_219_0 and arg_216_1.var_.characterEffect10030 then
				arg_216_1.var_.characterEffect10030.alpha = 0
			end

			local var_219_2 = 0
			local var_219_3 = 1.575

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_2 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_4 = arg_216_1:FormatText(arg_216_1:GetWordFromCfg(115301054).content)

				arg_216_1.text_.text = var_219_4

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_6 = 63 <= 0 and var_219_3 or var_219_3 * (utf8.len(var_219_4) / 63)

				if (63 <= 0 and var_219_3 or var_219_3 * (utf8.len(var_219_4) / 63)) > 0 and var_219_3 < var_219_6 then
					arg_216_1.talkMaxDuration = var_219_6

					if var_219_6 + var_219_2 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_6 + var_219_2
					end
				end

				arg_216_1.text_.text = var_219_4
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_7 = math.max(var_219_3, arg_216_1.talkMaxDuration)

			if var_219_2 <= arg_216_1.time_ and arg_216_1.time_ < var_219_2 + var_219_7 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_2) / var_219_7

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_2 + var_219_7 and arg_216_1.time_ < var_219_2 + var_219_7 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play115301055 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 115301055
		arg_220_1.duration_ = 14.33

		local var_220_0 = {
			ja = 14.333,
			ko = 9.4,
			zh = 9.6,
			en = 12.2
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play115301056(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos1038 = arg_220_1.actors_["1038"].transform.localPosition
				arg_220_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_220_1:CheckSpriteTmpPos("1038", 2)

				for iter_223_0 = 0, arg_220_1.actors_["1038"].transform.childCount - 1 do
					local var_223_0 = arg_220_1.actors_["1038"].transform:GetChild(iter_223_0)

					if var_223_0.name == "split_1" or not string.find(var_223_0.name, "split") then
						var_223_0.gameObject:SetActive(true)
					else
						var_223_0.gameObject:SetActive(false)
					end
				end
			end

			local var_223_1 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_1 then
				arg_220_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_220_1.time_ - 0) / var_223_1)
			end

			if arg_220_1.time_ >= 0 + var_223_1 and arg_220_1.time_ < 0 + var_223_1 + arg_223_0 then
				arg_220_1.actors_["1038"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				local var_223_2 = arg_220_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_223_2 then
					arg_220_1.var_.alphaOldValue1038 = var_223_2.alpha
					arg_220_1.var_.characterEffect1038 = var_223_2
				end

				arg_220_1.var_.alphaOldValue1038 = 0
			end

			local var_223_3 = 0.333333333333333

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_3 then
				if arg_220_1.var_.characterEffect1038 then
					arg_220_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_220_1.var_.alphaOldValue1038, 1, (arg_220_1.time_ - 0) / var_223_3)
				end
			end

			if arg_220_1.time_ >= 0 + var_223_3 and arg_220_1.time_ < 0 + var_223_3 + arg_223_0 and arg_220_1.var_.characterEffect1038 then
				arg_220_1.var_.characterEffect1038.alpha = 1
			end

			local var_223_4 = 0
			local var_223_5 = 0.9

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_4 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_6 = arg_220_1:GetWordFromCfg(115301055)
				local var_223_7 = arg_220_1:FormatText(var_223_6.content)

				arg_220_1.text_.text = var_223_7

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_9 = 36 <= 0 and var_223_5 or var_223_5 * (utf8.len(var_223_7) / 36)

				if (36 <= 0 and var_223_5 or var_223_5 * (utf8.len(var_223_7) / 36)) > 0 and var_223_5 < var_223_9 then
					arg_220_1.talkMaxDuration = var_223_9

					if var_223_9 + var_223_4 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_9 + var_223_4
					end
				end

				arg_220_1.text_.text = var_223_7
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301055", "story_v_out_115301.awb") ~= 0 then
					local var_223_10 = manager.audio:GetVoiceLength("story_v_out_115301", "115301055", "story_v_out_115301.awb") / 1000

					if var_223_10 + var_223_4 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_10 + var_223_4
					end

					if var_223_6.prefab_name ~= "" and arg_220_1.actors_[var_223_6.prefab_name] ~= nil then
						local var_223_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_6.prefab_name].transform, "story_v_out_115301", "115301055", "story_v_out_115301.awb")

						arg_220_1:RecordAudio("115301055", var_223_11)
						arg_220_1:RecordAudio("115301055", var_223_11)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_115301", "115301055", "story_v_out_115301.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_115301", "115301055", "story_v_out_115301.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_12 = math.max(var_223_5, arg_220_1.talkMaxDuration)

			if var_223_4 <= arg_220_1.time_ and arg_220_1.time_ < var_223_4 + var_223_12 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_4) / var_223_12

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_4 + var_223_12 and arg_220_1.time_ < var_223_4 + var_223_12 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play115301056 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 115301056
		arg_224_1.duration_ = 1.3

		local var_224_0 = {
			ja = 0.999999999999,
			ko = 1,
			zh = 1.233,
			en = 1.3
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play115301057(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos10030 = arg_224_1.actors_["10030"].transform.localPosition
				arg_224_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_224_1:CheckSpriteTmpPos("10030", 4)

				for iter_227_0 = 0, arg_224_1.actors_["10030"].transform.childCount - 1 do
					local var_227_0 = arg_224_1.actors_["10030"].transform:GetChild(iter_227_0)

					if var_227_0.name == "split_1" or not string.find(var_227_0.name, "split") then
						var_227_0.gameObject:SetActive(true)
					else
						var_227_0.gameObject:SetActive(false)
					end
				end
			end

			local var_227_1 = 0.001

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_1 then
				arg_224_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_224_1.time_ - 0) / var_227_1)
			end

			if arg_224_1.time_ >= 0 + var_227_1 and arg_224_1.time_ < 0 + var_227_1 + arg_227_0 then
				arg_224_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			local var_227_2 = arg_224_1.actors_["1038"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_2) and arg_224_1.var_.actorSpriteComps1038 == nil then
				arg_224_1.var_.actorSpriteComps1038 = var_227_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_3 = 0.2

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_3 and not isNil(var_227_2) then
				if arg_224_1.var_.actorSpriteComps1038 then
					for iter_227_1, iter_227_2 in pairs(arg_224_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_227_2 then
							if arg_224_1.isInRecall_ then
								iter_227_2.color = Color.New(Mathf.Lerp(iter_227_2.color.r, arg_224_1.hightColor2.r, (arg_224_1.time_ - 0) / var_227_3), Mathf.Lerp(iter_227_2.color.g, arg_224_1.hightColor2.g, (arg_224_1.time_ - 0) / var_227_3), (Mathf.Lerp(iter_227_2.color.b, arg_224_1.hightColor2.b, (arg_224_1.time_ - 0) / var_227_3)))
							else
								local var_227_4 = Mathf.Lerp(iter_227_2.color.r, 0.5, (arg_224_1.time_ - 0) / var_227_3)

								iter_227_2.color = Color.New(var_227_4, var_227_4, var_227_4)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= 0 + var_227_3 and arg_224_1.time_ < 0 + var_227_3 + arg_227_0 and not isNil(var_227_2) and arg_224_1.var_.actorSpriteComps1038 then
				for iter_227_3, iter_227_4 in pairs(arg_224_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_227_4 then
						iter_227_4.color = arg_224_1.isInRecall_ and (arg_224_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_224_1.var_.actorSpriteComps1038 = nil
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				local var_227_5 = arg_224_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_227_5 then
					arg_224_1.var_.alphaOldValue10030 = var_227_5.alpha
					arg_224_1.var_.characterEffect10030 = var_227_5
				end

				arg_224_1.var_.alphaOldValue10030 = 0
			end

			local var_227_6 = 0.333333333333333

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_6 then
				if arg_224_1.var_.characterEffect10030 then
					arg_224_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_224_1.var_.alphaOldValue10030, 1, (arg_224_1.time_ - 0) / var_227_6)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_6 and arg_224_1.time_ < 0 + var_227_6 + arg_227_0 and arg_224_1.var_.characterEffect10030 then
				arg_224_1.var_.characterEffect10030.alpha = 1
			end

			local var_227_7 = 0
			local var_227_8 = 0.1

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_7 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_9 = arg_224_1:GetWordFromCfg(115301056)
				local var_227_10 = arg_224_1:FormatText(var_227_9.content)

				arg_224_1.text_.text = var_227_10

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_12 = 4 <= 0 and var_227_8 or var_227_8 * (utf8.len(var_227_10) / 4)

				if (4 <= 0 and var_227_8 or var_227_8 * (utf8.len(var_227_10) / 4)) > 0 and var_227_8 < var_227_12 then
					arg_224_1.talkMaxDuration = var_227_12

					if var_227_12 + var_227_7 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_12 + var_227_7
					end
				end

				arg_224_1.text_.text = var_227_10
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301056", "story_v_out_115301.awb") ~= 0 then
					local var_227_13 = manager.audio:GetVoiceLength("story_v_out_115301", "115301056", "story_v_out_115301.awb") / 1000

					if var_227_13 + var_227_7 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_13 + var_227_7
					end

					if var_227_9.prefab_name ~= "" and arg_224_1.actors_[var_227_9.prefab_name] ~= nil then
						local var_227_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_9.prefab_name].transform, "story_v_out_115301", "115301056", "story_v_out_115301.awb")

						arg_224_1:RecordAudio("115301056", var_227_14)
						arg_224_1:RecordAudio("115301056", var_227_14)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_115301", "115301056", "story_v_out_115301.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_115301", "115301056", "story_v_out_115301.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_15 = math.max(var_227_8, arg_224_1.talkMaxDuration)

			if var_227_7 <= arg_224_1.time_ and arg_224_1.time_ < var_227_7 + var_227_15 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_7) / var_227_15

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_7 + var_227_15 and arg_224_1.time_ < var_227_7 + var_227_15 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_224_1:InitPlayNodeList()
	end,
	Play115301057 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 115301057
		arg_228_1.duration_ = 8.3

		local var_228_0 = {
			ja = 8.3,
			ko = 5.033,
			zh = 6.2,
			en = 6.766
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play115301058(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(arg_228_1.actors_["10030"]) and arg_228_1.var_.actorSpriteComps10030 == nil then
				arg_228_1.var_.actorSpriteComps10030 = arg_228_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_0 = 0.2

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 and not isNil(arg_228_1.actors_["10030"]) then
				if arg_228_1.var_.actorSpriteComps10030 then
					for iter_231_0, iter_231_1 in pairs(arg_228_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_231_1 then
							if arg_228_1.isInRecall_ then
								iter_231_1.color = Color.New(Mathf.Lerp(iter_231_1.color.r, arg_228_1.hightColor2.r, (arg_228_1.time_ - 0) / var_231_0), Mathf.Lerp(iter_231_1.color.g, arg_228_1.hightColor2.g, (arg_228_1.time_ - 0) / var_231_0), (Mathf.Lerp(iter_231_1.color.b, arg_228_1.hightColor2.b, (arg_228_1.time_ - 0) / var_231_0)))
							else
								local var_231_1 = Mathf.Lerp(iter_231_1.color.r, 0.5, (arg_228_1.time_ - 0) / var_231_0)

								iter_231_1.color = Color.New(var_231_1, var_231_1, var_231_1)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 and not isNil(arg_228_1.actors_["10030"]) and arg_228_1.var_.actorSpriteComps10030 then
				for iter_231_2, iter_231_3 in pairs(arg_228_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_231_3 then
						iter_231_3.color = arg_228_1.isInRecall_ and (arg_228_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_228_1.var_.actorSpriteComps10030 = nil
			end

			local var_231_2 = arg_228_1.actors_["1038"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_2) and arg_228_1.var_.actorSpriteComps1038 == nil then
				arg_228_1.var_.actorSpriteComps1038 = var_231_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_3 = 0.2

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_3 and not isNil(var_231_2) then
				if arg_228_1.var_.actorSpriteComps1038 then
					for iter_231_4, iter_231_5 in pairs(arg_228_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_231_5 then
							if arg_228_1.isInRecall_ then
								iter_231_5.color = Color.New(Mathf.Lerp(iter_231_5.color.r, arg_228_1.hightColor1.r, (arg_228_1.time_ - 0) / var_231_3), Mathf.Lerp(iter_231_5.color.g, arg_228_1.hightColor1.g, (arg_228_1.time_ - 0) / var_231_3), (Mathf.Lerp(iter_231_5.color.b, arg_228_1.hightColor1.b, (arg_228_1.time_ - 0) / var_231_3)))
							else
								local var_231_4 = Mathf.Lerp(iter_231_5.color.r, 1, (arg_228_1.time_ - 0) / var_231_3)

								iter_231_5.color = Color.New(var_231_4, var_231_4, var_231_4)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= 0 + var_231_3 and arg_228_1.time_ < 0 + var_231_3 + arg_231_0 and not isNil(var_231_2) and arg_228_1.var_.actorSpriteComps1038 then
				for iter_231_6, iter_231_7 in pairs(arg_228_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_231_7 then
						iter_231_7.color = arg_228_1.isInRecall_ and (arg_228_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_228_1.var_.actorSpriteComps1038 = nil
			end

			local var_231_5 = 0
			local var_231_6 = 0.6

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_5 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_7 = arg_228_1:GetWordFromCfg(115301057)
				local var_231_8 = arg_228_1:FormatText(var_231_7.content)

				arg_228_1.text_.text = var_231_8

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_10 = 24 <= 0 and var_231_6 or var_231_6 * (utf8.len(var_231_8) / 24)

				if (24 <= 0 and var_231_6 or var_231_6 * (utf8.len(var_231_8) / 24)) > 0 and var_231_6 < var_231_10 then
					arg_228_1.talkMaxDuration = var_231_10

					if var_231_10 + var_231_5 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_10 + var_231_5
					end
				end

				arg_228_1.text_.text = var_231_8
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301057", "story_v_out_115301.awb") ~= 0 then
					local var_231_11 = manager.audio:GetVoiceLength("story_v_out_115301", "115301057", "story_v_out_115301.awb") / 1000

					if var_231_11 + var_231_5 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_11 + var_231_5
					end

					if var_231_7.prefab_name ~= "" and arg_228_1.actors_[var_231_7.prefab_name] ~= nil then
						local var_231_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_7.prefab_name].transform, "story_v_out_115301", "115301057", "story_v_out_115301.awb")

						arg_228_1:RecordAudio("115301057", var_231_12)
						arg_228_1:RecordAudio("115301057", var_231_12)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_115301", "115301057", "story_v_out_115301.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_115301", "115301057", "story_v_out_115301.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_13 = math.max(var_231_6, arg_228_1.talkMaxDuration)

			if var_231_5 <= arg_228_1.time_ and arg_228_1.time_ < var_231_5 + var_231_13 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_5) / var_231_13

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_5 + var_231_13 and arg_228_1.time_ < var_231_5 + var_231_13 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play115301058 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 115301058
		arg_232_1.duration_ = 10.4

		local var_232_0 = {
			ja = 10.4,
			ko = 7.3,
			zh = 7.566,
			en = 7.7
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play115301059(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(arg_232_1.actors_["10030"]) and arg_232_1.var_.actorSpriteComps10030 == nil then
				arg_232_1.var_.actorSpriteComps10030 = arg_232_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_235_0 = 0.2

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_0 and not isNil(arg_232_1.actors_["10030"]) then
				if arg_232_1.var_.actorSpriteComps10030 then
					for iter_235_0, iter_235_1 in pairs(arg_232_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_235_1 then
							if arg_232_1.isInRecall_ then
								iter_235_1.color = Color.New(Mathf.Lerp(iter_235_1.color.r, arg_232_1.hightColor1.r, (arg_232_1.time_ - 0) / var_235_0), Mathf.Lerp(iter_235_1.color.g, arg_232_1.hightColor1.g, (arg_232_1.time_ - 0) / var_235_0), (Mathf.Lerp(iter_235_1.color.b, arg_232_1.hightColor1.b, (arg_232_1.time_ - 0) / var_235_0)))
							else
								local var_235_1 = Mathf.Lerp(iter_235_1.color.r, 1, (arg_232_1.time_ - 0) / var_235_0)

								iter_235_1.color = Color.New(var_235_1, var_235_1, var_235_1)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 and not isNil(arg_232_1.actors_["10030"]) and arg_232_1.var_.actorSpriteComps10030 then
				for iter_235_2, iter_235_3 in pairs(arg_232_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_235_3 then
						iter_235_3.color = arg_232_1.isInRecall_ and (arg_232_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_232_1.var_.actorSpriteComps10030 = nil
			end

			local var_235_2 = arg_232_1.actors_["1038"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_2) and arg_232_1.var_.actorSpriteComps1038 == nil then
				arg_232_1.var_.actorSpriteComps1038 = var_235_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_235_3 = 0.2

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_3 and not isNil(var_235_2) then
				if arg_232_1.var_.actorSpriteComps1038 then
					for iter_235_4, iter_235_5 in pairs(arg_232_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_235_5 then
							if arg_232_1.isInRecall_ then
								iter_235_5.color = Color.New(Mathf.Lerp(iter_235_5.color.r, arg_232_1.hightColor2.r, (arg_232_1.time_ - 0) / var_235_3), Mathf.Lerp(iter_235_5.color.g, arg_232_1.hightColor2.g, (arg_232_1.time_ - 0) / var_235_3), (Mathf.Lerp(iter_235_5.color.b, arg_232_1.hightColor2.b, (arg_232_1.time_ - 0) / var_235_3)))
							else
								local var_235_4 = Mathf.Lerp(iter_235_5.color.r, 0.5, (arg_232_1.time_ - 0) / var_235_3)

								iter_235_5.color = Color.New(var_235_4, var_235_4, var_235_4)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= 0 + var_235_3 and arg_232_1.time_ < 0 + var_235_3 + arg_235_0 and not isNil(var_235_2) and arg_232_1.var_.actorSpriteComps1038 then
				for iter_235_6, iter_235_7 in pairs(arg_232_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_235_7 then
						iter_235_7.color = arg_232_1.isInRecall_ and (arg_232_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_232_1.var_.actorSpriteComps1038 = nil
			end

			local var_235_5 = 0
			local var_235_6 = 0.775

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_5 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_7 = arg_232_1:GetWordFromCfg(115301058)
				local var_235_8 = arg_232_1:FormatText(var_235_7.content)

				arg_232_1.text_.text = var_235_8

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_10 = 31 <= 0 and var_235_6 or var_235_6 * (utf8.len(var_235_8) / 31)

				if (31 <= 0 and var_235_6 or var_235_6 * (utf8.len(var_235_8) / 31)) > 0 and var_235_6 < var_235_10 then
					arg_232_1.talkMaxDuration = var_235_10

					if var_235_10 + var_235_5 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_10 + var_235_5
					end
				end

				arg_232_1.text_.text = var_235_8
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301058", "story_v_out_115301.awb") ~= 0 then
					local var_235_11 = manager.audio:GetVoiceLength("story_v_out_115301", "115301058", "story_v_out_115301.awb") / 1000

					if var_235_11 + var_235_5 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_11 + var_235_5
					end

					if var_235_7.prefab_name ~= "" and arg_232_1.actors_[var_235_7.prefab_name] ~= nil then
						local var_235_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_7.prefab_name].transform, "story_v_out_115301", "115301058", "story_v_out_115301.awb")

						arg_232_1:RecordAudio("115301058", var_235_12)
						arg_232_1:RecordAudio("115301058", var_235_12)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_115301", "115301058", "story_v_out_115301.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_115301", "115301058", "story_v_out_115301.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_13 = math.max(var_235_6, arg_232_1.talkMaxDuration)

			if var_235_5 <= arg_232_1.time_ and arg_232_1.time_ < var_235_5 + var_235_13 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_5) / var_235_13

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_5 + var_235_13 and arg_232_1.time_ < var_235_5 + var_235_13 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play115301059 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 115301059
		arg_236_1.duration_ = 2.4

		local var_236_0 = {
			ja = 1.766,
			ko = 1.333,
			zh = 2.4,
			en = 1.366
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play115301060(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(arg_236_1.actors_["10030"]) and arg_236_1.var_.actorSpriteComps10030 == nil then
				arg_236_1.var_.actorSpriteComps10030 = arg_236_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_0 = 0.2

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_0 and not isNil(arg_236_1.actors_["10030"]) then
				if arg_236_1.var_.actorSpriteComps10030 then
					for iter_239_0, iter_239_1 in pairs(arg_236_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_239_1 then
							if arg_236_1.isInRecall_ then
								iter_239_1.color = Color.New(Mathf.Lerp(iter_239_1.color.r, arg_236_1.hightColor2.r, (arg_236_1.time_ - 0) / var_239_0), Mathf.Lerp(iter_239_1.color.g, arg_236_1.hightColor2.g, (arg_236_1.time_ - 0) / var_239_0), (Mathf.Lerp(iter_239_1.color.b, arg_236_1.hightColor2.b, (arg_236_1.time_ - 0) / var_239_0)))
							else
								local var_239_1 = Mathf.Lerp(iter_239_1.color.r, 0.5, (arg_236_1.time_ - 0) / var_239_0)

								iter_239_1.color = Color.New(var_239_1, var_239_1, var_239_1)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= 0 + var_239_0 and arg_236_1.time_ < 0 + var_239_0 + arg_239_0 and not isNil(arg_236_1.actors_["10030"]) and arg_236_1.var_.actorSpriteComps10030 then
				for iter_239_2, iter_239_3 in pairs(arg_236_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_239_3 then
						iter_239_3.color = arg_236_1.isInRecall_ and (arg_236_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_236_1.var_.actorSpriteComps10030 = nil
			end

			local var_239_2 = arg_236_1.actors_["1038"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_2) and arg_236_1.var_.actorSpriteComps1038 == nil then
				arg_236_1.var_.actorSpriteComps1038 = var_239_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_3 = 0.2

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_3 and not isNil(var_239_2) then
				if arg_236_1.var_.actorSpriteComps1038 then
					for iter_239_4, iter_239_5 in pairs(arg_236_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_239_5 then
							if arg_236_1.isInRecall_ then
								iter_239_5.color = Color.New(Mathf.Lerp(iter_239_5.color.r, arg_236_1.hightColor1.r, (arg_236_1.time_ - 0) / var_239_3), Mathf.Lerp(iter_239_5.color.g, arg_236_1.hightColor1.g, (arg_236_1.time_ - 0) / var_239_3), (Mathf.Lerp(iter_239_5.color.b, arg_236_1.hightColor1.b, (arg_236_1.time_ - 0) / var_239_3)))
							else
								local var_239_4 = Mathf.Lerp(iter_239_5.color.r, 1, (arg_236_1.time_ - 0) / var_239_3)

								iter_239_5.color = Color.New(var_239_4, var_239_4, var_239_4)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= 0 + var_239_3 and arg_236_1.time_ < 0 + var_239_3 + arg_239_0 and not isNil(var_239_2) and arg_236_1.var_.actorSpriteComps1038 then
				for iter_239_6, iter_239_7 in pairs(arg_236_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_239_7 then
						iter_239_7.color = arg_236_1.isInRecall_ and (arg_236_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_236_1.var_.actorSpriteComps1038 = nil
			end

			local var_239_5 = arg_236_1.actors_["1038"].transform

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos1038 = var_239_5.localPosition
				var_239_5.localScale = Vector3.New(1, 1, 1)

				arg_236_1:CheckSpriteTmpPos("1038", 2)

				for iter_239_8 = 0, var_239_5.childCount - 1 do
					local var_239_6 = var_239_5:GetChild(iter_239_8)

					if var_239_6.name == "split_7" or not string.find(var_239_6.name, "split") then
						var_239_6.gameObject:SetActive(true)
					else
						var_239_6.gameObject:SetActive(false)
					end
				end
			end

			local var_239_7 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_7 then
				var_239_5.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_236_1.time_ - 0) / var_239_7)
			end

			if arg_236_1.time_ >= 0 + var_239_7 and arg_236_1.time_ < 0 + var_239_7 + arg_239_0 then
				var_239_5.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_239_8 = 0
			local var_239_9 = 0.075

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_8 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_10 = arg_236_1:GetWordFromCfg(115301059)
				local var_239_11 = arg_236_1:FormatText(var_239_10.content)

				arg_236_1.text_.text = var_239_11

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_13 = 3 <= 0 and var_239_9 or var_239_9 * (utf8.len(var_239_11) / 3)

				if (3 <= 0 and var_239_9 or var_239_9 * (utf8.len(var_239_11) / 3)) > 0 and var_239_9 < var_239_13 then
					arg_236_1.talkMaxDuration = var_239_13

					if var_239_13 + var_239_8 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_13 + var_239_8
					end
				end

				arg_236_1.text_.text = var_239_11
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301059", "story_v_out_115301.awb") ~= 0 then
					local var_239_14 = manager.audio:GetVoiceLength("story_v_out_115301", "115301059", "story_v_out_115301.awb") / 1000

					if var_239_14 + var_239_8 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_14 + var_239_8
					end

					if var_239_10.prefab_name ~= "" and arg_236_1.actors_[var_239_10.prefab_name] ~= nil then
						local var_239_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_10.prefab_name].transform, "story_v_out_115301", "115301059", "story_v_out_115301.awb")

						arg_236_1:RecordAudio("115301059", var_239_15)
						arg_236_1:RecordAudio("115301059", var_239_15)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_115301", "115301059", "story_v_out_115301.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_115301", "115301059", "story_v_out_115301.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_16 = math.max(var_239_9, arg_236_1.talkMaxDuration)

			if var_239_8 <= arg_236_1.time_ and arg_236_1.time_ < var_239_8 + var_239_16 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_8) / var_239_16

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_8 + var_239_16 and arg_236_1.time_ < var_239_8 + var_239_16 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play115301060 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 115301060
		arg_240_1.duration_ = 2.27

		local var_240_0 = {
			ja = 2.266,
			ko = 1.7,
			zh = 1.933,
			en = 1.333
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play115301061(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(arg_240_1.actors_["10030"]) and arg_240_1.var_.actorSpriteComps10030 == nil then
				arg_240_1.var_.actorSpriteComps10030 = arg_240_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_243_0 = 0.2

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 and not isNil(arg_240_1.actors_["10030"]) then
				if arg_240_1.var_.actorSpriteComps10030 then
					for iter_243_0, iter_243_1 in pairs(arg_240_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_243_1 then
							if arg_240_1.isInRecall_ then
								iter_243_1.color = Color.New(Mathf.Lerp(iter_243_1.color.r, arg_240_1.hightColor1.r, (arg_240_1.time_ - 0) / var_243_0), Mathf.Lerp(iter_243_1.color.g, arg_240_1.hightColor1.g, (arg_240_1.time_ - 0) / var_243_0), (Mathf.Lerp(iter_243_1.color.b, arg_240_1.hightColor1.b, (arg_240_1.time_ - 0) / var_243_0)))
							else
								local var_243_1 = Mathf.Lerp(iter_243_1.color.r, 1, (arg_240_1.time_ - 0) / var_243_0)

								iter_243_1.color = Color.New(var_243_1, var_243_1, var_243_1)
							end
						end
					end
				end
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 and not isNil(arg_240_1.actors_["10030"]) and arg_240_1.var_.actorSpriteComps10030 then
				for iter_243_2, iter_243_3 in pairs(arg_240_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_243_3 then
						iter_243_3.color = arg_240_1.isInRecall_ and (arg_240_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_240_1.var_.actorSpriteComps10030 = nil
			end

			local var_243_2 = arg_240_1.actors_["1038"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_2) and arg_240_1.var_.actorSpriteComps1038 == nil then
				arg_240_1.var_.actorSpriteComps1038 = var_243_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_243_3 = 0.2

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_3 and not isNil(var_243_2) then
				if arg_240_1.var_.actorSpriteComps1038 then
					for iter_243_4, iter_243_5 in pairs(arg_240_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_243_5 then
							if arg_240_1.isInRecall_ then
								iter_243_5.color = Color.New(Mathf.Lerp(iter_243_5.color.r, arg_240_1.hightColor2.r, (arg_240_1.time_ - 0) / var_243_3), Mathf.Lerp(iter_243_5.color.g, arg_240_1.hightColor2.g, (arg_240_1.time_ - 0) / var_243_3), (Mathf.Lerp(iter_243_5.color.b, arg_240_1.hightColor2.b, (arg_240_1.time_ - 0) / var_243_3)))
							else
								local var_243_4 = Mathf.Lerp(iter_243_5.color.r, 0.5, (arg_240_1.time_ - 0) / var_243_3)

								iter_243_5.color = Color.New(var_243_4, var_243_4, var_243_4)
							end
						end
					end
				end
			end

			if arg_240_1.time_ >= 0 + var_243_3 and arg_240_1.time_ < 0 + var_243_3 + arg_243_0 and not isNil(var_243_2) and arg_240_1.var_.actorSpriteComps1038 then
				for iter_243_6, iter_243_7 in pairs(arg_240_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_243_7 then
						iter_243_7.color = arg_240_1.isInRecall_ and (arg_240_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_240_1.var_.actorSpriteComps1038 = nil
			end

			local var_243_5 = arg_240_1.actors_["10030"].transform

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos10030 = var_243_5.localPosition
				var_243_5.localScale = Vector3.New(1, 1, 1)

				arg_240_1:CheckSpriteTmpPos("10030", 4)

				for iter_243_8 = 0, var_243_5.childCount - 1 do
					local var_243_6 = var_243_5:GetChild(iter_243_8)

					if var_243_6.name == "split_4" or not string.find(var_243_6.name, "split") then
						var_243_6.gameObject:SetActive(true)
					else
						var_243_6.gameObject:SetActive(false)
					end
				end
			end

			local var_243_7 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_7 then
				var_243_5.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_240_1.time_ - 0) / var_243_7)
			end

			if arg_240_1.time_ >= 0 + var_243_7 and arg_240_1.time_ < 0 + var_243_7 + arg_243_0 then
				var_243_5.localPosition = Vector3.New(390, -390, 150)
			end

			local var_243_8 = 0
			local var_243_9 = 0.075

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_8 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_10 = arg_240_1:GetWordFromCfg(115301060)
				local var_243_11 = arg_240_1:FormatText(var_243_10.content)

				arg_240_1.text_.text = var_243_11

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_13 = 3 <= 0 and var_243_9 or var_243_9 * (utf8.len(var_243_11) / 3)

				if (3 <= 0 and var_243_9 or var_243_9 * (utf8.len(var_243_11) / 3)) > 0 and var_243_9 < var_243_13 then
					arg_240_1.talkMaxDuration = var_243_13

					if var_243_13 + var_243_8 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_13 + var_243_8
					end
				end

				arg_240_1.text_.text = var_243_11
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301060", "story_v_out_115301.awb") ~= 0 then
					local var_243_14 = manager.audio:GetVoiceLength("story_v_out_115301", "115301060", "story_v_out_115301.awb") / 1000

					if var_243_14 + var_243_8 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_14 + var_243_8
					end

					if var_243_10.prefab_name ~= "" and arg_240_1.actors_[var_243_10.prefab_name] ~= nil then
						local var_243_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_10.prefab_name].transform, "story_v_out_115301", "115301060", "story_v_out_115301.awb")

						arg_240_1:RecordAudio("115301060", var_243_15)
						arg_240_1:RecordAudio("115301060", var_243_15)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_115301", "115301060", "story_v_out_115301.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_115301", "115301060", "story_v_out_115301.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_16 = math.max(var_243_9, arg_240_1.talkMaxDuration)

			if var_243_8 <= arg_240_1.time_ and arg_240_1.time_ < var_243_8 + var_243_16 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_8) / var_243_16

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_8 + var_243_16 and arg_240_1.time_ < var_243_8 + var_243_16 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play115301061 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 115301061
		arg_244_1.duration_ = 8.13

		local var_244_0 = {
			ja = 6.8,
			ko = 4.533,
			zh = 8.133,
			en = 5.566
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play115301062(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(arg_244_1.actors_["10030"]) and arg_244_1.var_.actorSpriteComps10030 == nil then
				arg_244_1.var_.actorSpriteComps10030 = arg_244_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_0 = 0.2

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 and not isNil(arg_244_1.actors_["10030"]) then
				if arg_244_1.var_.actorSpriteComps10030 then
					for iter_247_0, iter_247_1 in pairs(arg_244_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_247_1 then
							if arg_244_1.isInRecall_ then
								iter_247_1.color = Color.New(Mathf.Lerp(iter_247_1.color.r, arg_244_1.hightColor2.r, (arg_244_1.time_ - 0) / var_247_0), Mathf.Lerp(iter_247_1.color.g, arg_244_1.hightColor2.g, (arg_244_1.time_ - 0) / var_247_0), (Mathf.Lerp(iter_247_1.color.b, arg_244_1.hightColor2.b, (arg_244_1.time_ - 0) / var_247_0)))
							else
								local var_247_1 = Mathf.Lerp(iter_247_1.color.r, 0.5, (arg_244_1.time_ - 0) / var_247_0)

								iter_247_1.color = Color.New(var_247_1, var_247_1, var_247_1)
							end
						end
					end
				end
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 and not isNil(arg_244_1.actors_["10030"]) and arg_244_1.var_.actorSpriteComps10030 then
				for iter_247_2, iter_247_3 in pairs(arg_244_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_247_3 then
						iter_247_3.color = arg_244_1.isInRecall_ and (arg_244_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_244_1.var_.actorSpriteComps10030 = nil
			end

			local var_247_2 = arg_244_1.actors_["1038"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_2) and arg_244_1.var_.actorSpriteComps1038 == nil then
				arg_244_1.var_.actorSpriteComps1038 = var_247_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_3 = 0.2

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_3 and not isNil(var_247_2) then
				if arg_244_1.var_.actorSpriteComps1038 then
					for iter_247_4, iter_247_5 in pairs(arg_244_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_247_5 then
							if arg_244_1.isInRecall_ then
								iter_247_5.color = Color.New(Mathf.Lerp(iter_247_5.color.r, arg_244_1.hightColor1.r, (arg_244_1.time_ - 0) / var_247_3), Mathf.Lerp(iter_247_5.color.g, arg_244_1.hightColor1.g, (arg_244_1.time_ - 0) / var_247_3), (Mathf.Lerp(iter_247_5.color.b, arg_244_1.hightColor1.b, (arg_244_1.time_ - 0) / var_247_3)))
							else
								local var_247_4 = Mathf.Lerp(iter_247_5.color.r, 1, (arg_244_1.time_ - 0) / var_247_3)

								iter_247_5.color = Color.New(var_247_4, var_247_4, var_247_4)
							end
						end
					end
				end
			end

			if arg_244_1.time_ >= 0 + var_247_3 and arg_244_1.time_ < 0 + var_247_3 + arg_247_0 and not isNil(var_247_2) and arg_244_1.var_.actorSpriteComps1038 then
				for iter_247_6, iter_247_7 in pairs(arg_244_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_247_7 then
						iter_247_7.color = arg_244_1.isInRecall_ and (arg_244_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_244_1.var_.actorSpriteComps1038 = nil
			end

			local var_247_5 = 0
			local var_247_6 = 0.775

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_5 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_7 = arg_244_1:GetWordFromCfg(115301061)
				local var_247_8 = arg_244_1:FormatText(var_247_7.content)

				arg_244_1.text_.text = var_247_8

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_10 = 31 <= 0 and var_247_6 or var_247_6 * (utf8.len(var_247_8) / 31)

				if (31 <= 0 and var_247_6 or var_247_6 * (utf8.len(var_247_8) / 31)) > 0 and var_247_6 < var_247_10 then
					arg_244_1.talkMaxDuration = var_247_10

					if var_247_10 + var_247_5 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_10 + var_247_5
					end
				end

				arg_244_1.text_.text = var_247_8
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301061", "story_v_out_115301.awb") ~= 0 then
					local var_247_11 = manager.audio:GetVoiceLength("story_v_out_115301", "115301061", "story_v_out_115301.awb") / 1000

					if var_247_11 + var_247_5 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_11 + var_247_5
					end

					if var_247_7.prefab_name ~= "" and arg_244_1.actors_[var_247_7.prefab_name] ~= nil then
						local var_247_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_7.prefab_name].transform, "story_v_out_115301", "115301061", "story_v_out_115301.awb")

						arg_244_1:RecordAudio("115301061", var_247_12)
						arg_244_1:RecordAudio("115301061", var_247_12)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_115301", "115301061", "story_v_out_115301.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_115301", "115301061", "story_v_out_115301.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_13 = math.max(var_247_6, arg_244_1.talkMaxDuration)

			if var_247_5 <= arg_244_1.time_ and arg_244_1.time_ < var_247_5 + var_247_13 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_5) / var_247_13

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_5 + var_247_13 and arg_244_1.time_ < var_247_5 + var_247_13 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play115301062 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 115301062
		arg_248_1.duration_ = 1.8

		local var_248_0 = {
			ja = 1.2,
			ko = 0.999999999999,
			zh = 1.8,
			en = 1.1
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play115301063(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(arg_248_1.actors_["10030"]) and arg_248_1.var_.actorSpriteComps10030 == nil then
				arg_248_1.var_.actorSpriteComps10030 = arg_248_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_251_0 = 0.2

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 and not isNil(arg_248_1.actors_["10030"]) then
				if arg_248_1.var_.actorSpriteComps10030 then
					for iter_251_0, iter_251_1 in pairs(arg_248_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_251_1 then
							if arg_248_1.isInRecall_ then
								iter_251_1.color = Color.New(Mathf.Lerp(iter_251_1.color.r, arg_248_1.hightColor1.r, (arg_248_1.time_ - 0) / var_251_0), Mathf.Lerp(iter_251_1.color.g, arg_248_1.hightColor1.g, (arg_248_1.time_ - 0) / var_251_0), (Mathf.Lerp(iter_251_1.color.b, arg_248_1.hightColor1.b, (arg_248_1.time_ - 0) / var_251_0)))
							else
								local var_251_1 = Mathf.Lerp(iter_251_1.color.r, 1, (arg_248_1.time_ - 0) / var_251_0)

								iter_251_1.color = Color.New(var_251_1, var_251_1, var_251_1)
							end
						end
					end
				end
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 and not isNil(arg_248_1.actors_["10030"]) and arg_248_1.var_.actorSpriteComps10030 then
				for iter_251_2, iter_251_3 in pairs(arg_248_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_251_3 then
						iter_251_3.color = arg_248_1.isInRecall_ and (arg_248_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_248_1.var_.actorSpriteComps10030 = nil
			end

			local var_251_2 = arg_248_1.actors_["1038"]

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(var_251_2) and arg_248_1.var_.actorSpriteComps1038 == nil then
				arg_248_1.var_.actorSpriteComps1038 = var_251_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_251_3 = 0.2

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_3 and not isNil(var_251_2) then
				if arg_248_1.var_.actorSpriteComps1038 then
					for iter_251_4, iter_251_5 in pairs(arg_248_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_251_5 then
							if arg_248_1.isInRecall_ then
								iter_251_5.color = Color.New(Mathf.Lerp(iter_251_5.color.r, arg_248_1.hightColor2.r, (arg_248_1.time_ - 0) / var_251_3), Mathf.Lerp(iter_251_5.color.g, arg_248_1.hightColor2.g, (arg_248_1.time_ - 0) / var_251_3), (Mathf.Lerp(iter_251_5.color.b, arg_248_1.hightColor2.b, (arg_248_1.time_ - 0) / var_251_3)))
							else
								local var_251_4 = Mathf.Lerp(iter_251_5.color.r, 0.5, (arg_248_1.time_ - 0) / var_251_3)

								iter_251_5.color = Color.New(var_251_4, var_251_4, var_251_4)
							end
						end
					end
				end
			end

			if arg_248_1.time_ >= 0 + var_251_3 and arg_248_1.time_ < 0 + var_251_3 + arg_251_0 and not isNil(var_251_2) and arg_248_1.var_.actorSpriteComps1038 then
				for iter_251_6, iter_251_7 in pairs(arg_248_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_251_7 then
						iter_251_7.color = arg_248_1.isInRecall_ and (arg_248_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_248_1.var_.actorSpriteComps1038 = nil
			end

			local var_251_5 = arg_248_1.actors_["10030"].transform

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos10030 = var_251_5.localPosition
				var_251_5.localScale = Vector3.New(1, 1, 1)

				arg_248_1:CheckSpriteTmpPos("10030", 4)

				for iter_251_8 = 0, var_251_5.childCount - 1 do
					local var_251_6 = var_251_5:GetChild(iter_251_8)

					if var_251_6.name == "split_1" or not string.find(var_251_6.name, "split") then
						var_251_6.gameObject:SetActive(true)
					else
						var_251_6.gameObject:SetActive(false)
					end
				end
			end

			local var_251_7 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_7 then
				var_251_5.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_248_1.time_ - 0) / var_251_7)
			end

			if arg_248_1.time_ >= 0 + var_251_7 and arg_248_1.time_ < 0 + var_251_7 + arg_251_0 then
				var_251_5.localPosition = Vector3.New(390, -390, 150)
			end

			local var_251_8 = 0
			local var_251_9 = 0.1

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_8 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_10 = arg_248_1:GetWordFromCfg(115301062)
				local var_251_11 = arg_248_1:FormatText(var_251_10.content)

				arg_248_1.text_.text = var_251_11

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_13 = 4 <= 0 and var_251_9 or var_251_9 * (utf8.len(var_251_11) / 4)

				if (4 <= 0 and var_251_9 or var_251_9 * (utf8.len(var_251_11) / 4)) > 0 and var_251_9 < var_251_13 then
					arg_248_1.talkMaxDuration = var_251_13

					if var_251_13 + var_251_8 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_13 + var_251_8
					end
				end

				arg_248_1.text_.text = var_251_11
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301062", "story_v_out_115301.awb") ~= 0 then
					local var_251_14 = manager.audio:GetVoiceLength("story_v_out_115301", "115301062", "story_v_out_115301.awb") / 1000

					if var_251_14 + var_251_8 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_14 + var_251_8
					end

					if var_251_10.prefab_name ~= "" and arg_248_1.actors_[var_251_10.prefab_name] ~= nil then
						local var_251_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_10.prefab_name].transform, "story_v_out_115301", "115301062", "story_v_out_115301.awb")

						arg_248_1:RecordAudio("115301062", var_251_15)
						arg_248_1:RecordAudio("115301062", var_251_15)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_115301", "115301062", "story_v_out_115301.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_115301", "115301062", "story_v_out_115301.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_16 = math.max(var_251_9, arg_248_1.talkMaxDuration)

			if var_251_8 <= arg_248_1.time_ and arg_248_1.time_ < var_251_8 + var_251_16 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_8) / var_251_16

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_8 + var_251_16 and arg_248_1.time_ < var_251_8 + var_251_16 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_248_1:InitPlayNodeList()
	end,
	Play115301063 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 115301063
		arg_252_1.duration_ = 12.57

		local var_252_0 = {
			ja = 9.766,
			ko = 7.6,
			zh = 11.666,
			en = 12.566
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play115301064(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(arg_252_1.actors_["10030"]) and arg_252_1.var_.actorSpriteComps10030 == nil then
				arg_252_1.var_.actorSpriteComps10030 = arg_252_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_255_0 = 0.2

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 and not isNil(arg_252_1.actors_["10030"]) then
				if arg_252_1.var_.actorSpriteComps10030 then
					for iter_255_0, iter_255_1 in pairs(arg_252_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_255_1 then
							if arg_252_1.isInRecall_ then
								iter_255_1.color = Color.New(Mathf.Lerp(iter_255_1.color.r, arg_252_1.hightColor2.r, (arg_252_1.time_ - 0) / var_255_0), Mathf.Lerp(iter_255_1.color.g, arg_252_1.hightColor2.g, (arg_252_1.time_ - 0) / var_255_0), (Mathf.Lerp(iter_255_1.color.b, arg_252_1.hightColor2.b, (arg_252_1.time_ - 0) / var_255_0)))
							else
								local var_255_1 = Mathf.Lerp(iter_255_1.color.r, 0.5, (arg_252_1.time_ - 0) / var_255_0)

								iter_255_1.color = Color.New(var_255_1, var_255_1, var_255_1)
							end
						end
					end
				end
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 and not isNil(arg_252_1.actors_["10030"]) and arg_252_1.var_.actorSpriteComps10030 then
				for iter_255_2, iter_255_3 in pairs(arg_252_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_255_3 then
						iter_255_3.color = arg_252_1.isInRecall_ and (arg_252_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_252_1.var_.actorSpriteComps10030 = nil
			end

			local var_255_2 = arg_252_1.actors_["1038"]

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(var_255_2) and arg_252_1.var_.actorSpriteComps1038 == nil then
				arg_252_1.var_.actorSpriteComps1038 = var_255_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_255_3 = 0.2

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_3 and not isNil(var_255_2) then
				if arg_252_1.var_.actorSpriteComps1038 then
					for iter_255_4, iter_255_5 in pairs(arg_252_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_255_5 then
							if arg_252_1.isInRecall_ then
								iter_255_5.color = Color.New(Mathf.Lerp(iter_255_5.color.r, arg_252_1.hightColor1.r, (arg_252_1.time_ - 0) / var_255_3), Mathf.Lerp(iter_255_5.color.g, arg_252_1.hightColor1.g, (arg_252_1.time_ - 0) / var_255_3), (Mathf.Lerp(iter_255_5.color.b, arg_252_1.hightColor1.b, (arg_252_1.time_ - 0) / var_255_3)))
							else
								local var_255_4 = Mathf.Lerp(iter_255_5.color.r, 1, (arg_252_1.time_ - 0) / var_255_3)

								iter_255_5.color = Color.New(var_255_4, var_255_4, var_255_4)
							end
						end
					end
				end
			end

			if arg_252_1.time_ >= 0 + var_255_3 and arg_252_1.time_ < 0 + var_255_3 + arg_255_0 and not isNil(var_255_2) and arg_252_1.var_.actorSpriteComps1038 then
				for iter_255_6, iter_255_7 in pairs(arg_252_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_255_7 then
						iter_255_7.color = arg_252_1.isInRecall_ and (arg_252_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_252_1.var_.actorSpriteComps1038 = nil
			end

			local var_255_5 = 0
			local var_255_6 = 1.125

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_5 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_7 = arg_252_1:GetWordFromCfg(115301063)
				local var_255_8 = arg_252_1:FormatText(var_255_7.content)

				arg_252_1.text_.text = var_255_8

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_10 = 45 <= 0 and var_255_6 or var_255_6 * (utf8.len(var_255_8) / 45)

				if (45 <= 0 and var_255_6 or var_255_6 * (utf8.len(var_255_8) / 45)) > 0 and var_255_6 < var_255_10 then
					arg_252_1.talkMaxDuration = var_255_10

					if var_255_10 + var_255_5 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_10 + var_255_5
					end
				end

				arg_252_1.text_.text = var_255_8
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301063", "story_v_out_115301.awb") ~= 0 then
					local var_255_11 = manager.audio:GetVoiceLength("story_v_out_115301", "115301063", "story_v_out_115301.awb") / 1000

					if var_255_11 + var_255_5 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_11 + var_255_5
					end

					if var_255_7.prefab_name ~= "" and arg_252_1.actors_[var_255_7.prefab_name] ~= nil then
						local var_255_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_7.prefab_name].transform, "story_v_out_115301", "115301063", "story_v_out_115301.awb")

						arg_252_1:RecordAudio("115301063", var_255_12)
						arg_252_1:RecordAudio("115301063", var_255_12)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_115301", "115301063", "story_v_out_115301.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_115301", "115301063", "story_v_out_115301.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_13 = math.max(var_255_6, arg_252_1.talkMaxDuration)

			if var_255_5 <= arg_252_1.time_ and arg_252_1.time_ < var_255_5 + var_255_13 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_5) / var_255_13

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_5 + var_255_13 and arg_252_1.time_ < var_255_5 + var_255_13 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play115301064 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 115301064
		arg_256_1.duration_ = 13.17

		local var_256_0 = {
			ja = 13.166,
			ko = 11.9,
			zh = 12.5,
			en = 12.366
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play115301065(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 1.2

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_1 = arg_256_1:GetWordFromCfg(115301064)
				local var_259_2 = arg_256_1:FormatText(var_259_1.content)

				arg_256_1.text_.text = var_259_2

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_4 = 48 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_2) / 48)

				if (48 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_2) / 48)) > 0 and var_259_0 < var_259_4 then
					arg_256_1.talkMaxDuration = var_259_4

					if var_259_4 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_4 + 0
					end
				end

				arg_256_1.text_.text = var_259_2
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301064", "story_v_out_115301.awb") ~= 0 then
					local var_259_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301064", "story_v_out_115301.awb") / 1000

					if var_259_5 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_5 + 0
					end

					if var_259_1.prefab_name ~= "" and arg_256_1.actors_[var_259_1.prefab_name] ~= nil then
						local var_259_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_1.prefab_name].transform, "story_v_out_115301", "115301064", "story_v_out_115301.awb")

						arg_256_1:RecordAudio("115301064", var_259_6)
						arg_256_1:RecordAudio("115301064", var_259_6)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_115301", "115301064", "story_v_out_115301.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_115301", "115301064", "story_v_out_115301.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_7 = math.max(var_259_0, arg_256_1.talkMaxDuration)

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_7 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - 0) / var_259_7

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= 0 + var_259_7 and arg_256_1.time_ < 0 + var_259_7 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play115301065 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 115301065
		arg_260_1.duration_ = 9.93

		local var_260_0 = {
			ja = 9.933,
			ko = 5.966,
			zh = 7.6,
			en = 5.6
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play115301066(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0.7

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_1 = arg_260_1:GetWordFromCfg(115301065)
				local var_263_2 = arg_260_1:FormatText(var_263_1.content)

				arg_260_1.text_.text = var_263_2

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_4 = 28 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_2) / 28)

				if (28 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_2) / 28)) > 0 and var_263_0 < var_263_4 then
					arg_260_1.talkMaxDuration = var_263_4

					if var_263_4 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_4 + 0
					end
				end

				arg_260_1.text_.text = var_263_2
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301065", "story_v_out_115301.awb") ~= 0 then
					local var_263_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301065", "story_v_out_115301.awb") / 1000

					if var_263_5 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_5 + 0
					end

					if var_263_1.prefab_name ~= "" and arg_260_1.actors_[var_263_1.prefab_name] ~= nil then
						local var_263_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_1.prefab_name].transform, "story_v_out_115301", "115301065", "story_v_out_115301.awb")

						arg_260_1:RecordAudio("115301065", var_263_6)
						arg_260_1:RecordAudio("115301065", var_263_6)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_115301", "115301065", "story_v_out_115301.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_115301", "115301065", "story_v_out_115301.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_7 = math.max(var_263_0, arg_260_1.talkMaxDuration)

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_7 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - 0) / var_263_7

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= 0 + var_263_7 and arg_260_1.time_ < 0 + var_263_7 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play115301066 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 115301066
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play115301067(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(arg_264_1.actors_["1038"]) and arg_264_1.var_.actorSpriteComps1038 == nil then
				arg_264_1.var_.actorSpriteComps1038 = arg_264_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_267_0 = 0.2

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 and not isNil(arg_264_1.actors_["1038"]) then
				if arg_264_1.var_.actorSpriteComps1038 then
					for iter_267_0, iter_267_1 in pairs(arg_264_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_267_1 then
							if arg_264_1.isInRecall_ then
								iter_267_1.color = Color.New(Mathf.Lerp(iter_267_1.color.r, arg_264_1.hightColor2.r, (arg_264_1.time_ - 0) / var_267_0), Mathf.Lerp(iter_267_1.color.g, arg_264_1.hightColor2.g, (arg_264_1.time_ - 0) / var_267_0), (Mathf.Lerp(iter_267_1.color.b, arg_264_1.hightColor2.b, (arg_264_1.time_ - 0) / var_267_0)))
							else
								local var_267_1 = Mathf.Lerp(iter_267_1.color.r, 0.5, (arg_264_1.time_ - 0) / var_267_0)

								iter_267_1.color = Color.New(var_267_1, var_267_1, var_267_1)
							end
						end
					end
				end
			end

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 and not isNil(arg_264_1.actors_["1038"]) and arg_264_1.var_.actorSpriteComps1038 then
				for iter_267_2, iter_267_3 in pairs(arg_264_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_267_3 then
						iter_267_3.color = arg_264_1.isInRecall_ and (arg_264_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_264_1.var_.actorSpriteComps1038 = nil
			end

			local var_267_2 = 0
			local var_267_3 = 1.125

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_2 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, false)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_4 = arg_264_1:FormatText(arg_264_1:GetWordFromCfg(115301066).content)

				arg_264_1.text_.text = var_267_4

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_6 = 45 <= 0 and var_267_3 or var_267_3 * (utf8.len(var_267_4) / 45)

				if (45 <= 0 and var_267_3 or var_267_3 * (utf8.len(var_267_4) / 45)) > 0 and var_267_3 < var_267_6 then
					arg_264_1.talkMaxDuration = var_267_6

					if var_267_6 + var_267_2 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_6 + var_267_2
					end
				end

				arg_264_1.text_.text = var_267_4
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_7 = math.max(var_267_3, arg_264_1.talkMaxDuration)

			if var_267_2 <= arg_264_1.time_ and arg_264_1.time_ < var_267_2 + var_267_7 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_2) / var_267_7

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_2 + var_267_7 and arg_264_1.time_ < var_267_2 + var_267_7 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play115301067 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 115301067
		arg_268_1.duration_ = 3.77

		local var_268_0 = {
			ja = 1.033,
			ko = 2.133,
			zh = 3.766,
			en = 1.6
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play115301068(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.var_.moveOldPos10030 = arg_268_1.actors_["10030"].transform.localPosition
				arg_268_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_268_1:CheckSpriteTmpPos("10030", 4)

				for iter_271_0 = 0, arg_268_1.actors_["10030"].transform.childCount - 1 do
					local var_271_0 = arg_268_1.actors_["10030"].transform:GetChild(iter_271_0)

					if var_271_0.name == "split_3" or not string.find(var_271_0.name, "split") then
						var_271_0.gameObject:SetActive(true)
					else
						var_271_0.gameObject:SetActive(false)
					end
				end
			end

			local var_271_1 = 0.001

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_1 then
				arg_268_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_268_1.time_ - 0) / var_271_1)
			end

			if arg_268_1.time_ >= 0 + var_271_1 and arg_268_1.time_ < 0 + var_271_1 + arg_271_0 then
				arg_268_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			local var_271_2 = arg_268_1.actors_["10030"]

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(var_271_2) and arg_268_1.var_.actorSpriteComps10030 == nil then
				arg_268_1.var_.actorSpriteComps10030 = var_271_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_271_3 = 0.2

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_3 and not isNil(var_271_2) then
				if arg_268_1.var_.actorSpriteComps10030 then
					for iter_271_1, iter_271_2 in pairs(arg_268_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_271_2 then
							if arg_268_1.isInRecall_ then
								iter_271_2.color = Color.New(Mathf.Lerp(iter_271_2.color.r, arg_268_1.hightColor1.r, (arg_268_1.time_ - 0) / var_271_3), Mathf.Lerp(iter_271_2.color.g, arg_268_1.hightColor1.g, (arg_268_1.time_ - 0) / var_271_3), (Mathf.Lerp(iter_271_2.color.b, arg_268_1.hightColor1.b, (arg_268_1.time_ - 0) / var_271_3)))
							else
								local var_271_4 = Mathf.Lerp(iter_271_2.color.r, 1, (arg_268_1.time_ - 0) / var_271_3)

								iter_271_2.color = Color.New(var_271_4, var_271_4, var_271_4)
							end
						end
					end
				end
			end

			if arg_268_1.time_ >= 0 + var_271_3 and arg_268_1.time_ < 0 + var_271_3 + arg_271_0 and not isNil(var_271_2) and arg_268_1.var_.actorSpriteComps10030 then
				for iter_271_3, iter_271_4 in pairs(arg_268_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_271_4 then
						iter_271_4.color = arg_268_1.isInRecall_ and (arg_268_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_268_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				local var_271_5 = arg_268_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_271_5 then
					arg_268_1.var_.alphaOldValue10030 = var_271_5.alpha
					arg_268_1.var_.characterEffect10030 = var_271_5
				end

				arg_268_1.var_.alphaOldValue10030 = 0
			end

			local var_271_6 = 0.0166666666666667

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_6 then
				if arg_268_1.var_.characterEffect10030 then
					arg_268_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_268_1.var_.alphaOldValue10030, 1, (arg_268_1.time_ - 0) / var_271_6)
				end
			end

			if arg_268_1.time_ >= 0 + var_271_6 and arg_268_1.time_ < 0 + var_271_6 + arg_271_0 and arg_268_1.var_.characterEffect10030 then
				arg_268_1.var_.characterEffect10030.alpha = 1
			end

			local var_271_7 = 0
			local var_271_8 = 0.125

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_7 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_9 = arg_268_1:GetWordFromCfg(115301067)
				local var_271_10 = arg_268_1:FormatText(var_271_9.content)

				arg_268_1.text_.text = var_271_10

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_12 = 5 <= 0 and var_271_8 or var_271_8 * (utf8.len(var_271_10) / 5)

				if (5 <= 0 and var_271_8 or var_271_8 * (utf8.len(var_271_10) / 5)) > 0 and var_271_8 < var_271_12 then
					arg_268_1.talkMaxDuration = var_271_12

					if var_271_12 + var_271_7 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_12 + var_271_7
					end
				end

				arg_268_1.text_.text = var_271_10
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301067", "story_v_out_115301.awb") ~= 0 then
					local var_271_13 = manager.audio:GetVoiceLength("story_v_out_115301", "115301067", "story_v_out_115301.awb") / 1000

					if var_271_13 + var_271_7 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_13 + var_271_7
					end

					if var_271_9.prefab_name ~= "" and arg_268_1.actors_[var_271_9.prefab_name] ~= nil then
						local var_271_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_9.prefab_name].transform, "story_v_out_115301", "115301067", "story_v_out_115301.awb")

						arg_268_1:RecordAudio("115301067", var_271_14)
						arg_268_1:RecordAudio("115301067", var_271_14)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_115301", "115301067", "story_v_out_115301.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_115301", "115301067", "story_v_out_115301.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_15 = math.max(var_271_8, arg_268_1.talkMaxDuration)

			if var_271_7 <= arg_268_1.time_ and arg_268_1.time_ < var_271_7 + var_271_15 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_7) / var_271_15

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_7 + var_271_15 and arg_268_1.time_ < var_271_7 + var_271_15 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_268_1:InitPlayNodeList()
	end,
	Play115301068 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 115301068
		arg_272_1.duration_ = 5

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play115301069(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				local var_275_0 = arg_272_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_275_0 then
					arg_272_1.var_.alphaOldValue10030 = var_275_0.alpha
					arg_272_1.var_.characterEffect10030 = var_275_0
				end

				arg_272_1.var_.alphaOldValue10030 = 1
			end

			local var_275_1 = 0.333333333333333

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_1 then
				if arg_272_1.var_.characterEffect10030 then
					arg_272_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_272_1.var_.alphaOldValue10030, 0, (arg_272_1.time_ - 0) / var_275_1)
				end
			end

			if arg_272_1.time_ >= 0 + var_275_1 and arg_272_1.time_ < 0 + var_275_1 + arg_275_0 and arg_272_1.var_.characterEffect10030 then
				arg_272_1.var_.characterEffect10030.alpha = 0
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				local var_275_2 = arg_272_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_275_2 then
					arg_272_1.var_.alphaOldValue1038 = var_275_2.alpha
					arg_272_1.var_.characterEffect1038 = var_275_2
				end

				arg_272_1.var_.alphaOldValue1038 = 1
			end

			local var_275_3 = 0.333333333333333

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_3 then
				if arg_272_1.var_.characterEffect1038 then
					arg_272_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_272_1.var_.alphaOldValue1038, 0, (arg_272_1.time_ - 0) / var_275_3)
				end
			end

			if arg_272_1.time_ >= 0 + var_275_3 and arg_272_1.time_ < 0 + var_275_3 + arg_275_0 and arg_272_1.var_.characterEffect1038 then
				arg_272_1.var_.characterEffect1038.alpha = 0
			end

			local var_275_4 = 0
			local var_275_5 = 0.85

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_4 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, false)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_6 = arg_272_1:FormatText(arg_272_1:GetWordFromCfg(115301068).content)

				arg_272_1.text_.text = var_275_6

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_8 = 34 <= 0 and var_275_5 or var_275_5 * (utf8.len(var_275_6) / 34)

				if (34 <= 0 and var_275_5 or var_275_5 * (utf8.len(var_275_6) / 34)) > 0 and var_275_5 < var_275_8 then
					arg_272_1.talkMaxDuration = var_275_8

					if var_275_8 + var_275_4 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_8 + var_275_4
					end
				end

				arg_272_1.text_.text = var_275_6
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)
				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_9 = math.max(var_275_5, arg_272_1.talkMaxDuration)

			if var_275_4 <= arg_272_1.time_ and arg_272_1.time_ < var_275_4 + var_275_9 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_4) / var_275_9

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_4 + var_275_9 and arg_272_1.time_ < var_275_4 + var_275_9 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play115301069 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 115301069
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play115301070(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0.95

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, false)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_1 = arg_276_1:FormatText(arg_276_1:GetWordFromCfg(115301069).content)

				arg_276_1.text_.text = var_279_1

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_3 = 38 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_1) / 38)

				if (38 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_1) / 38)) > 0 and var_279_0 < var_279_3 then
					arg_276_1.talkMaxDuration = var_279_3

					if var_279_3 + 0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_3 + 0
					end
				end

				arg_276_1.text_.text = var_279_1
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_4 = math.max(var_279_0, arg_276_1.talkMaxDuration)

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_4 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - 0) / var_279_4

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= 0 + var_279_4 and arg_276_1.time_ < 0 + var_279_4 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play115301070 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 115301070
		arg_280_1.duration_ = 15.97

		local var_280_0 = {
			ja = 15.966,
			ko = 12.466,
			zh = 12.333,
			en = 12.833
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play115301071(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.var_.moveOldPos1038 = arg_280_1.actors_["1038"].transform.localPosition
				arg_280_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_280_1:CheckSpriteTmpPos("1038", 3)

				for iter_283_0 = 0, arg_280_1.actors_["1038"].transform.childCount - 1 do
					local var_283_0 = arg_280_1.actors_["1038"].transform:GetChild(iter_283_0)

					if var_283_0.name == "split_1" or not string.find(var_283_0.name, "split") then
						var_283_0.gameObject:SetActive(true)
					else
						var_283_0.gameObject:SetActive(false)
					end
				end
			end

			local var_283_1 = 0.001

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_1 then
				arg_280_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos1038, Vector3.New(0, -400, 0), (arg_280_1.time_ - 0) / var_283_1)
			end

			if arg_280_1.time_ >= 0 + var_283_1 and arg_280_1.time_ < 0 + var_283_1 + arg_283_0 then
				arg_280_1.actors_["1038"].transform.localPosition = Vector3.New(0, -400, 0)
			end

			local var_283_2 = arg_280_1.actors_["1038"]

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(var_283_2) and arg_280_1.var_.actorSpriteComps1038 == nil then
				arg_280_1.var_.actorSpriteComps1038 = var_283_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_283_3 = 0.2

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_3 and not isNil(var_283_2) then
				if arg_280_1.var_.actorSpriteComps1038 then
					for iter_283_1, iter_283_2 in pairs(arg_280_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_283_2 then
							if arg_280_1.isInRecall_ then
								iter_283_2.color = Color.New(Mathf.Lerp(iter_283_2.color.r, arg_280_1.hightColor1.r, (arg_280_1.time_ - 0) / var_283_3), Mathf.Lerp(iter_283_2.color.g, arg_280_1.hightColor1.g, (arg_280_1.time_ - 0) / var_283_3), (Mathf.Lerp(iter_283_2.color.b, arg_280_1.hightColor1.b, (arg_280_1.time_ - 0) / var_283_3)))
							else
								local var_283_4 = Mathf.Lerp(iter_283_2.color.r, 1, (arg_280_1.time_ - 0) / var_283_3)

								iter_283_2.color = Color.New(var_283_4, var_283_4, var_283_4)
							end
						end
					end
				end
			end

			if arg_280_1.time_ >= 0 + var_283_3 and arg_280_1.time_ < 0 + var_283_3 + arg_283_0 and not isNil(var_283_2) and arg_280_1.var_.actorSpriteComps1038 then
				for iter_283_3, iter_283_4 in pairs(arg_280_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_283_4 then
						iter_283_4.color = arg_280_1.isInRecall_ and (arg_280_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_280_1.var_.actorSpriteComps1038 = nil
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				local var_283_5 = arg_280_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_283_5 then
					arg_280_1.var_.alphaOldValue1038 = var_283_5.alpha
					arg_280_1.var_.characterEffect1038 = var_283_5
				end

				arg_280_1.var_.alphaOldValue1038 = 0
			end

			local var_283_6 = 0.333333333333333

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_6 then
				if arg_280_1.var_.characterEffect1038 then
					arg_280_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_280_1.var_.alphaOldValue1038, 1, (arg_280_1.time_ - 0) / var_283_6)
				end
			end

			if arg_280_1.time_ >= 0 + var_283_6 and arg_280_1.time_ < 0 + var_283_6 + arg_283_0 and arg_280_1.var_.characterEffect1038 then
				arg_280_1.var_.characterEffect1038.alpha = 1
			end

			local var_283_7 = 0
			local var_283_8 = 1.15

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_7 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_9 = arg_280_1:GetWordFromCfg(115301070)
				local var_283_10 = arg_280_1:FormatText(var_283_9.content)

				arg_280_1.text_.text = var_283_10

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_12 = 46 <= 0 and var_283_8 or var_283_8 * (utf8.len(var_283_10) / 46)

				if (46 <= 0 and var_283_8 or var_283_8 * (utf8.len(var_283_10) / 46)) > 0 and var_283_8 < var_283_12 then
					arg_280_1.talkMaxDuration = var_283_12

					if var_283_12 + var_283_7 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_12 + var_283_7
					end
				end

				arg_280_1.text_.text = var_283_10
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301070", "story_v_out_115301.awb") ~= 0 then
					local var_283_13 = manager.audio:GetVoiceLength("story_v_out_115301", "115301070", "story_v_out_115301.awb") / 1000

					if var_283_13 + var_283_7 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_13 + var_283_7
					end

					if var_283_9.prefab_name ~= "" and arg_280_1.actors_[var_283_9.prefab_name] ~= nil then
						local var_283_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_9.prefab_name].transform, "story_v_out_115301", "115301070", "story_v_out_115301.awb")

						arg_280_1:RecordAudio("115301070", var_283_14)
						arg_280_1:RecordAudio("115301070", var_283_14)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_115301", "115301070", "story_v_out_115301.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_115301", "115301070", "story_v_out_115301.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_15 = math.max(var_283_8, arg_280_1.talkMaxDuration)

			if var_283_7 <= arg_280_1.time_ and arg_280_1.time_ < var_283_7 + var_283_15 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_7) / var_283_15

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_7 + var_283_15 and arg_280_1.time_ < var_283_7 + var_283_15 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_280_1:InitPlayNodeList()
	end,
	Play115301071 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 115301071
		arg_284_1.duration_ = 11.6

		local var_284_0 = {
			ja = 11.6,
			ko = 8.766,
			zh = 10.266,
			en = 8.966
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play115301072(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0.9

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_1 = arg_284_1:GetWordFromCfg(115301071)
				local var_287_2 = arg_284_1:FormatText(var_287_1.content)

				arg_284_1.text_.text = var_287_2

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_4 = 36 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_2) / 36)

				if (36 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_2) / 36)) > 0 and var_287_0 < var_287_4 then
					arg_284_1.talkMaxDuration = var_287_4

					if var_287_4 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_4 + 0
					end
				end

				arg_284_1.text_.text = var_287_2
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301071", "story_v_out_115301.awb") ~= 0 then
					local var_287_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301071", "story_v_out_115301.awb") / 1000

					if var_287_5 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_5 + 0
					end

					if var_287_1.prefab_name ~= "" and arg_284_1.actors_[var_287_1.prefab_name] ~= nil then
						local var_287_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_1.prefab_name].transform, "story_v_out_115301", "115301071", "story_v_out_115301.awb")

						arg_284_1:RecordAudio("115301071", var_287_6)
						arg_284_1:RecordAudio("115301071", var_287_6)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_115301", "115301071", "story_v_out_115301.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_115301", "115301071", "story_v_out_115301.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_7 = math.max(var_287_0, arg_284_1.talkMaxDuration)

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_7 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - 0) / var_287_7

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= 0 + var_287_7 and arg_284_1.time_ < 0 + var_287_7 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play115301072 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 115301072
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play115301073(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				local var_291_0 = arg_288_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_291_0 then
					arg_288_1.var_.alphaOldValue1038 = var_291_0.alpha
					arg_288_1.var_.characterEffect1038 = var_291_0
				end

				arg_288_1.var_.alphaOldValue1038 = 1
			end

			local var_291_1 = 0.333333333333333

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_1 then
				if arg_288_1.var_.characterEffect1038 then
					arg_288_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_288_1.var_.alphaOldValue1038, 0, (arg_288_1.time_ - 0) / var_291_1)
				end
			end

			if arg_288_1.time_ >= 0 + var_291_1 and arg_288_1.time_ < 0 + var_291_1 + arg_291_0 and arg_288_1.var_.characterEffect1038 then
				arg_288_1.var_.characterEffect1038.alpha = 0
			end

			local var_291_2 = 0
			local var_291_3 = 0.675

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_2 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, false)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_4 = arg_288_1:FormatText(arg_288_1:GetWordFromCfg(115301072).content)

				arg_288_1.text_.text = var_291_4

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_6 = 27 <= 0 and var_291_3 or var_291_3 * (utf8.len(var_291_4) / 27)

				if (27 <= 0 and var_291_3 or var_291_3 * (utf8.len(var_291_4) / 27)) > 0 and var_291_3 < var_291_6 then
					arg_288_1.talkMaxDuration = var_291_6

					if var_291_6 + var_291_2 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_6 + var_291_2
					end
				end

				arg_288_1.text_.text = var_291_4
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_7 = math.max(var_291_3, arg_288_1.talkMaxDuration)

			if var_291_2 <= arg_288_1.time_ and arg_288_1.time_ < var_291_2 + var_291_7 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_2) / var_291_7

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_2 + var_291_7 and arg_288_1.time_ < var_291_2 + var_291_7 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play115301073 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 115301073
		arg_292_1.duration_ = 13.1

		local var_292_0 = {
			ja = 13.1,
			ko = 9.6,
			zh = 11,
			en = 10.166
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play115301074(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos1038 = arg_292_1.actors_["1038"].transform.localPosition
				arg_292_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_292_1:CheckSpriteTmpPos("1038", 2)

				for iter_295_0 = 0, arg_292_1.actors_["1038"].transform.childCount - 1 do
					local var_295_0 = arg_292_1.actors_["1038"].transform:GetChild(iter_295_0)

					if var_295_0.name == "split_1" or not string.find(var_295_0.name, "split") then
						var_295_0.gameObject:SetActive(true)
					else
						var_295_0.gameObject:SetActive(false)
					end
				end
			end

			local var_295_1 = 0.001

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_1 then
				arg_292_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_292_1.time_ - 0) / var_295_1)
			end

			if arg_292_1.time_ >= 0 + var_295_1 and arg_292_1.time_ < 0 + var_295_1 + arg_295_0 then
				arg_292_1.actors_["1038"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				local var_295_2 = arg_292_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_295_2 then
					arg_292_1.var_.alphaOldValue1038 = var_295_2.alpha
					arg_292_1.var_.characterEffect1038 = var_295_2
				end

				arg_292_1.var_.alphaOldValue1038 = 0
			end

			local var_295_3 = 0.333333333333333

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_3 then
				if arg_292_1.var_.characterEffect1038 then
					arg_292_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_292_1.var_.alphaOldValue1038, 1, (arg_292_1.time_ - 0) / var_295_3)
				end
			end

			if arg_292_1.time_ >= 0 + var_295_3 and arg_292_1.time_ < 0 + var_295_3 + arg_295_0 and arg_292_1.var_.characterEffect1038 then
				arg_292_1.var_.characterEffect1038.alpha = 1
			end

			local var_295_4 = arg_292_1.actors_["1038"]

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(var_295_4) and arg_292_1.var_.actorSpriteComps1038 == nil then
				arg_292_1.var_.actorSpriteComps1038 = var_295_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_295_5 = 0.2

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_5 and not isNil(var_295_4) then
				if arg_292_1.var_.actorSpriteComps1038 then
					for iter_295_1, iter_295_2 in pairs(arg_292_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_295_2 then
							if arg_292_1.isInRecall_ then
								iter_295_2.color = Color.New(Mathf.Lerp(iter_295_2.color.r, arg_292_1.hightColor1.r, (arg_292_1.time_ - 0) / var_295_5), Mathf.Lerp(iter_295_2.color.g, arg_292_1.hightColor1.g, (arg_292_1.time_ - 0) / var_295_5), (Mathf.Lerp(iter_295_2.color.b, arg_292_1.hightColor1.b, (arg_292_1.time_ - 0) / var_295_5)))
							else
								local var_295_6 = Mathf.Lerp(iter_295_2.color.r, 1, (arg_292_1.time_ - 0) / var_295_5)

								iter_295_2.color = Color.New(var_295_6, var_295_6, var_295_6)
							end
						end
					end
				end
			end

			if arg_292_1.time_ >= 0 + var_295_5 and arg_292_1.time_ < 0 + var_295_5 + arg_295_0 and not isNil(var_295_4) and arg_292_1.var_.actorSpriteComps1038 then
				for iter_295_3, iter_295_4 in pairs(arg_292_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_295_4 then
						iter_295_4.color = arg_292_1.isInRecall_ and (arg_292_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_292_1.var_.actorSpriteComps1038 = nil
			end

			local var_295_7 = 0
			local var_295_8 = 0.95

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_7 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_9 = arg_292_1:GetWordFromCfg(115301073)
				local var_295_10 = arg_292_1:FormatText(var_295_9.content)

				arg_292_1.text_.text = var_295_10

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_12 = 38 <= 0 and var_295_8 or var_295_8 * (utf8.len(var_295_10) / 38)

				if (38 <= 0 and var_295_8 or var_295_8 * (utf8.len(var_295_10) / 38)) > 0 and var_295_8 < var_295_12 then
					arg_292_1.talkMaxDuration = var_295_12

					if var_295_12 + var_295_7 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_12 + var_295_7
					end
				end

				arg_292_1.text_.text = var_295_10
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301073", "story_v_out_115301.awb") ~= 0 then
					local var_295_13 = manager.audio:GetVoiceLength("story_v_out_115301", "115301073", "story_v_out_115301.awb") / 1000

					if var_295_13 + var_295_7 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_13 + var_295_7
					end

					if var_295_9.prefab_name ~= "" and arg_292_1.actors_[var_295_9.prefab_name] ~= nil then
						local var_295_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_9.prefab_name].transform, "story_v_out_115301", "115301073", "story_v_out_115301.awb")

						arg_292_1:RecordAudio("115301073", var_295_14)
						arg_292_1:RecordAudio("115301073", var_295_14)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_115301", "115301073", "story_v_out_115301.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_115301", "115301073", "story_v_out_115301.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_15 = math.max(var_295_8, arg_292_1.talkMaxDuration)

			if var_295_7 <= arg_292_1.time_ and arg_292_1.time_ < var_295_7 + var_295_15 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_7) / var_295_15

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_7 + var_295_15 and arg_292_1.time_ < var_295_7 + var_295_15 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_292_1:InitPlayNodeList()
	end,
	Play115301074 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 115301074
		arg_296_1.duration_ = 7.1

		local var_296_0 = {
			ja = 5.266,
			ko = 5,
			zh = 7.1,
			en = 6.333
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play115301075(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos10030 = arg_296_1.actors_["10030"].transform.localPosition
				arg_296_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_296_1:CheckSpriteTmpPos("10030", 4)

				for iter_299_0 = 0, arg_296_1.actors_["10030"].transform.childCount - 1 do
					local var_299_0 = arg_296_1.actors_["10030"].transform:GetChild(iter_299_0)

					if var_299_0.name == "split_3" or not string.find(var_299_0.name, "split") then
						var_299_0.gameObject:SetActive(true)
					else
						var_299_0.gameObject:SetActive(false)
					end
				end
			end

			local var_299_1 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_1 then
				arg_296_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_296_1.time_ - 0) / var_299_1)
			end

			if arg_296_1.time_ >= 0 + var_299_1 and arg_296_1.time_ < 0 + var_299_1 + arg_299_0 then
				arg_296_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			local var_299_2 = arg_296_1.actors_["1038"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_2) and arg_296_1.var_.actorSpriteComps1038 == nil then
				arg_296_1.var_.actorSpriteComps1038 = var_299_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_3 = 0.2

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_3 and not isNil(var_299_2) then
				if arg_296_1.var_.actorSpriteComps1038 then
					for iter_299_1, iter_299_2 in pairs(arg_296_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_299_2 then
							if arg_296_1.isInRecall_ then
								iter_299_2.color = Color.New(Mathf.Lerp(iter_299_2.color.r, arg_296_1.hightColor2.r, (arg_296_1.time_ - 0) / var_299_3), Mathf.Lerp(iter_299_2.color.g, arg_296_1.hightColor2.g, (arg_296_1.time_ - 0) / var_299_3), (Mathf.Lerp(iter_299_2.color.b, arg_296_1.hightColor2.b, (arg_296_1.time_ - 0) / var_299_3)))
							else
								local var_299_4 = Mathf.Lerp(iter_299_2.color.r, 0.5, (arg_296_1.time_ - 0) / var_299_3)

								iter_299_2.color = Color.New(var_299_4, var_299_4, var_299_4)
							end
						end
					end
				end
			end

			if arg_296_1.time_ >= 0 + var_299_3 and arg_296_1.time_ < 0 + var_299_3 + arg_299_0 and not isNil(var_299_2) and arg_296_1.var_.actorSpriteComps1038 then
				for iter_299_3, iter_299_4 in pairs(arg_296_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_299_4 then
						iter_299_4.color = arg_296_1.isInRecall_ and (arg_296_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_296_1.var_.actorSpriteComps1038 = nil
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				local var_299_5 = arg_296_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_299_5 then
					arg_296_1.var_.alphaOldValue10030 = var_299_5.alpha
					arg_296_1.var_.characterEffect10030 = var_299_5
				end

				arg_296_1.var_.alphaOldValue10030 = 0
			end

			local var_299_6 = 0.333333333333333

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_6 then
				if arg_296_1.var_.characterEffect10030 then
					arg_296_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_296_1.var_.alphaOldValue10030, 1, (arg_296_1.time_ - 0) / var_299_6)
				end
			end

			if arg_296_1.time_ >= 0 + var_299_6 and arg_296_1.time_ < 0 + var_299_6 + arg_299_0 and arg_296_1.var_.characterEffect10030 then
				arg_296_1.var_.characterEffect10030.alpha = 1
			end

			local var_299_7 = 0
			local var_299_8 = 0.35

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_7 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_9 = arg_296_1:GetWordFromCfg(115301074)
				local var_299_10 = arg_296_1:FormatText(var_299_9.content)

				arg_296_1.text_.text = var_299_10

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_12 = 14 <= 0 and var_299_8 or var_299_8 * (utf8.len(var_299_10) / 14)

				if (14 <= 0 and var_299_8 or var_299_8 * (utf8.len(var_299_10) / 14)) > 0 and var_299_8 < var_299_12 then
					arg_296_1.talkMaxDuration = var_299_12

					if var_299_12 + var_299_7 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_12 + var_299_7
					end
				end

				arg_296_1.text_.text = var_299_10
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301074", "story_v_out_115301.awb") ~= 0 then
					local var_299_13 = manager.audio:GetVoiceLength("story_v_out_115301", "115301074", "story_v_out_115301.awb") / 1000

					if var_299_13 + var_299_7 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_13 + var_299_7
					end

					if var_299_9.prefab_name ~= "" and arg_296_1.actors_[var_299_9.prefab_name] ~= nil then
						local var_299_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_9.prefab_name].transform, "story_v_out_115301", "115301074", "story_v_out_115301.awb")

						arg_296_1:RecordAudio("115301074", var_299_14)
						arg_296_1:RecordAudio("115301074", var_299_14)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_115301", "115301074", "story_v_out_115301.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_115301", "115301074", "story_v_out_115301.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_15 = math.max(var_299_8, arg_296_1.talkMaxDuration)

			if var_299_7 <= arg_296_1.time_ and arg_296_1.time_ < var_299_7 + var_299_15 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_7) / var_299_15

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_7 + var_299_15 and arg_296_1.time_ < var_299_7 + var_299_15 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play115301075 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 115301075
		arg_300_1.duration_ = 6.9

		local var_300_0 = {
			ja = 4.3,
			ko = 4.8,
			zh = 6.9,
			en = 5.733
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play115301076(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(arg_300_1.actors_["10030"]) and arg_300_1.var_.actorSpriteComps10030 == nil then
				arg_300_1.var_.actorSpriteComps10030 = arg_300_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_303_0 = 0.2

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_0 and not isNil(arg_300_1.actors_["10030"]) then
				if arg_300_1.var_.actorSpriteComps10030 then
					for iter_303_0, iter_303_1 in pairs(arg_300_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_303_1 then
							if arg_300_1.isInRecall_ then
								iter_303_1.color = Color.New(Mathf.Lerp(iter_303_1.color.r, arg_300_1.hightColor2.r, (arg_300_1.time_ - 0) / var_303_0), Mathf.Lerp(iter_303_1.color.g, arg_300_1.hightColor2.g, (arg_300_1.time_ - 0) / var_303_0), (Mathf.Lerp(iter_303_1.color.b, arg_300_1.hightColor2.b, (arg_300_1.time_ - 0) / var_303_0)))
							else
								local var_303_1 = Mathf.Lerp(iter_303_1.color.r, 0.5, (arg_300_1.time_ - 0) / var_303_0)

								iter_303_1.color = Color.New(var_303_1, var_303_1, var_303_1)
							end
						end
					end
				end
			end

			if arg_300_1.time_ >= 0 + var_303_0 and arg_300_1.time_ < 0 + var_303_0 + arg_303_0 and not isNil(arg_300_1.actors_["10030"]) and arg_300_1.var_.actorSpriteComps10030 then
				for iter_303_2, iter_303_3 in pairs(arg_300_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_303_3 then
						iter_303_3.color = arg_300_1.isInRecall_ and (arg_300_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_300_1.var_.actorSpriteComps10030 = nil
			end

			local var_303_2 = arg_300_1.actors_["1038"]

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(var_303_2) and arg_300_1.var_.actorSpriteComps1038 == nil then
				arg_300_1.var_.actorSpriteComps1038 = var_303_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_303_3 = 0.2

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_3 and not isNil(var_303_2) then
				if arg_300_1.var_.actorSpriteComps1038 then
					for iter_303_4, iter_303_5 in pairs(arg_300_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_303_5 then
							if arg_300_1.isInRecall_ then
								iter_303_5.color = Color.New(Mathf.Lerp(iter_303_5.color.r, arg_300_1.hightColor1.r, (arg_300_1.time_ - 0) / var_303_3), Mathf.Lerp(iter_303_5.color.g, arg_300_1.hightColor1.g, (arg_300_1.time_ - 0) / var_303_3), (Mathf.Lerp(iter_303_5.color.b, arg_300_1.hightColor1.b, (arg_300_1.time_ - 0) / var_303_3)))
							else
								local var_303_4 = Mathf.Lerp(iter_303_5.color.r, 1, (arg_300_1.time_ - 0) / var_303_3)

								iter_303_5.color = Color.New(var_303_4, var_303_4, var_303_4)
							end
						end
					end
				end
			end

			if arg_300_1.time_ >= 0 + var_303_3 and arg_300_1.time_ < 0 + var_303_3 + arg_303_0 and not isNil(var_303_2) and arg_300_1.var_.actorSpriteComps1038 then
				for iter_303_6, iter_303_7 in pairs(arg_300_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_303_7 then
						iter_303_7.color = arg_300_1.isInRecall_ and (arg_300_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_300_1.var_.actorSpriteComps1038 = nil
			end

			local var_303_5 = 0
			local var_303_6 = 0.475

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_5 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_7 = arg_300_1:GetWordFromCfg(115301075)
				local var_303_8 = arg_300_1:FormatText(var_303_7.content)

				arg_300_1.text_.text = var_303_8

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_10 = 19 <= 0 and var_303_6 or var_303_6 * (utf8.len(var_303_8) / 19)

				if (19 <= 0 and var_303_6 or var_303_6 * (utf8.len(var_303_8) / 19)) > 0 and var_303_6 < var_303_10 then
					arg_300_1.talkMaxDuration = var_303_10

					if var_303_10 + var_303_5 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_10 + var_303_5
					end
				end

				arg_300_1.text_.text = var_303_8
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301075", "story_v_out_115301.awb") ~= 0 then
					local var_303_11 = manager.audio:GetVoiceLength("story_v_out_115301", "115301075", "story_v_out_115301.awb") / 1000

					if var_303_11 + var_303_5 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_11 + var_303_5
					end

					if var_303_7.prefab_name ~= "" and arg_300_1.actors_[var_303_7.prefab_name] ~= nil then
						local var_303_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_7.prefab_name].transform, "story_v_out_115301", "115301075", "story_v_out_115301.awb")

						arg_300_1:RecordAudio("115301075", var_303_12)
						arg_300_1:RecordAudio("115301075", var_303_12)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_115301", "115301075", "story_v_out_115301.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_115301", "115301075", "story_v_out_115301.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_13 = math.max(var_303_6, arg_300_1.talkMaxDuration)

			if var_303_5 <= arg_300_1.time_ and arg_300_1.time_ < var_303_5 + var_303_13 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_5) / var_303_13

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_5 + var_303_13 and arg_300_1.time_ < var_303_5 + var_303_13 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play115301076 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 115301076
		arg_304_1.duration_ = 11.23

		local var_304_0 = {
			ja = 11.233,
			ko = 7.566,
			zh = 10.6,
			en = 9.733
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play115301077(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.var_.moveOldPos1038 = arg_304_1.actors_["1038"].transform.localPosition
				arg_304_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_304_1:CheckSpriteTmpPos("1038", 2)

				for iter_307_0 = 0, arg_304_1.actors_["1038"].transform.childCount - 1 do
					local var_307_0 = arg_304_1.actors_["1038"].transform:GetChild(iter_307_0)

					if var_307_0.name == "split_1" or not string.find(var_307_0.name, "split") then
						var_307_0.gameObject:SetActive(true)
					else
						var_307_0.gameObject:SetActive(false)
					end
				end
			end

			local var_307_1 = 0.001

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_1 then
				arg_304_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_304_1.time_ - 0) / var_307_1)
			end

			if arg_304_1.time_ >= 0 + var_307_1 and arg_304_1.time_ < 0 + var_307_1 + arg_307_0 then
				arg_304_1.actors_["1038"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_307_2 = arg_304_1.actors_["1038"].transform

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.var_.moveOldPos1038 = var_307_2.localPosition
				var_307_2.localScale = Vector3.New(1, 1, 1)

				arg_304_1:CheckSpriteTmpPos("1038", 2)

				for iter_307_1 = 0, var_307_2.childCount - 1 do
					local var_307_3 = var_307_2:GetChild(iter_307_1)

					if var_307_3.name == "split_7" or not string.find(var_307_3.name, "split") then
						var_307_3.gameObject:SetActive(true)
					else
						var_307_3.gameObject:SetActive(false)
					end
				end
			end

			local var_307_4 = 0.001

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_4 then
				var_307_2.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_304_1.time_ - 0) / var_307_4)
			end

			if arg_304_1.time_ >= 0 + var_307_4 and arg_304_1.time_ < 0 + var_307_4 + arg_307_0 then
				var_307_2.localPosition = Vector3.New(-390, -400, 0)
			end

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				local var_307_5 = arg_304_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_307_5 then
					arg_304_1.var_.alphaOldValue1038 = var_307_5.alpha
					arg_304_1.var_.characterEffect1038 = var_307_5
				end

				arg_304_1.var_.alphaOldValue1038 = 0
			end

			local var_307_6 = 0.0166666666666667

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_6 then
				if arg_304_1.var_.characterEffect1038 then
					arg_304_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_304_1.var_.alphaOldValue1038, 1, (arg_304_1.time_ - 0) / var_307_6)
				end
			end

			if arg_304_1.time_ >= 0 + var_307_6 and arg_304_1.time_ < 0 + var_307_6 + arg_307_0 and arg_304_1.var_.characterEffect1038 then
				arg_304_1.var_.characterEffect1038.alpha = 1
			end

			local var_307_7 = arg_304_1.actors_["1038"]

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(var_307_7) and arg_304_1.var_.actorSpriteComps1038 == nil then
				arg_304_1.var_.actorSpriteComps1038 = var_307_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_307_8 = 0.0166666666666667

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_8 and not isNil(var_307_7) then
				if arg_304_1.var_.actorSpriteComps1038 then
					for iter_307_2, iter_307_3 in pairs(arg_304_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_307_3 then
							if arg_304_1.isInRecall_ then
								iter_307_3.color = Color.New(Mathf.Lerp(iter_307_3.color.r, arg_304_1.hightColor1.r, (arg_304_1.time_ - 0) / var_307_8), Mathf.Lerp(iter_307_3.color.g, arg_304_1.hightColor1.g, (arg_304_1.time_ - 0) / var_307_8), (Mathf.Lerp(iter_307_3.color.b, arg_304_1.hightColor1.b, (arg_304_1.time_ - 0) / var_307_8)))
							else
								local var_307_9 = Mathf.Lerp(iter_307_3.color.r, 1, (arg_304_1.time_ - 0) / var_307_8)

								iter_307_3.color = Color.New(var_307_9, var_307_9, var_307_9)
							end
						end
					end
				end
			end

			if arg_304_1.time_ >= 0 + var_307_8 and arg_304_1.time_ < 0 + var_307_8 + arg_307_0 and not isNil(var_307_7) and arg_304_1.var_.actorSpriteComps1038 then
				for iter_307_4, iter_307_5 in pairs(arg_304_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_307_5 then
						iter_307_5.color = arg_304_1.isInRecall_ and (arg_304_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_304_1.var_.actorSpriteComps1038 = nil
			end

			local var_307_10 = 0
			local var_307_11 = 1

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_10 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_12 = arg_304_1:GetWordFromCfg(115301076)
				local var_307_13 = arg_304_1:FormatText(var_307_12.content)

				arg_304_1.text_.text = var_307_13

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_15 = 40 <= 0 and var_307_11 or var_307_11 * (utf8.len(var_307_13) / 40)

				if (40 <= 0 and var_307_11 or var_307_11 * (utf8.len(var_307_13) / 40)) > 0 and var_307_11 < var_307_15 then
					arg_304_1.talkMaxDuration = var_307_15

					if var_307_15 + var_307_10 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_15 + var_307_10
					end
				end

				arg_304_1.text_.text = var_307_13
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301076", "story_v_out_115301.awb") ~= 0 then
					local var_307_16 = manager.audio:GetVoiceLength("story_v_out_115301", "115301076", "story_v_out_115301.awb") / 1000

					if var_307_16 + var_307_10 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_16 + var_307_10
					end

					if var_307_12.prefab_name ~= "" and arg_304_1.actors_[var_307_12.prefab_name] ~= nil then
						local var_307_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_12.prefab_name].transform, "story_v_out_115301", "115301076", "story_v_out_115301.awb")

						arg_304_1:RecordAudio("115301076", var_307_17)
						arg_304_1:RecordAudio("115301076", var_307_17)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_115301", "115301076", "story_v_out_115301.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_115301", "115301076", "story_v_out_115301.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_18 = math.max(var_307_11, arg_304_1.talkMaxDuration)

			if var_307_10 <= arg_304_1.time_ and arg_304_1.time_ < var_307_10 + var_307_18 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_10) / var_307_18

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_10 + var_307_18 and arg_304_1.time_ < var_307_10 + var_307_18 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_304_1:InitPlayNodeList()
	end,
	Play115301077 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 115301077
		arg_308_1.duration_ = 5.73

		local var_308_0 = {
			ja = 5.6,
			ko = 4.9,
			zh = 5.733,
			en = 5.266
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play115301078(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 0.55

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_1 = arg_308_1:GetWordFromCfg(115301077)
				local var_311_2 = arg_308_1:FormatText(var_311_1.content)

				arg_308_1.text_.text = var_311_2

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_4 = 22 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_2) / 22)

				if (22 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_2) / 22)) > 0 and var_311_0 < var_311_4 then
					arg_308_1.talkMaxDuration = var_311_4

					if var_311_4 + 0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_4 + 0
					end
				end

				arg_308_1.text_.text = var_311_2
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301077", "story_v_out_115301.awb") ~= 0 then
					local var_311_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301077", "story_v_out_115301.awb") / 1000

					if var_311_5 + 0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_5 + 0
					end

					if var_311_1.prefab_name ~= "" and arg_308_1.actors_[var_311_1.prefab_name] ~= nil then
						local var_311_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_1.prefab_name].transform, "story_v_out_115301", "115301077", "story_v_out_115301.awb")

						arg_308_1:RecordAudio("115301077", var_311_6)
						arg_308_1:RecordAudio("115301077", var_311_6)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_115301", "115301077", "story_v_out_115301.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_115301", "115301077", "story_v_out_115301.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_7 = math.max(var_311_0, arg_308_1.talkMaxDuration)

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_7 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - 0) / var_311_7

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= 0 + var_311_7 and arg_308_1.time_ < 0 + var_311_7 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play115301078 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 115301078
		arg_312_1.duration_ = 8

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play115301079(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if arg_312_1.bgs_.STblack == nil then
				local var_315_0 = Object.Instantiate(arg_312_1.paintGo_)

				var_315_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_315_0.name = "STblack"
				var_315_0.transform.parent = arg_312_1.stage_.transform
				var_315_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_312_1.bgs_.STblack = var_315_0
			end

			if 1 < arg_312_1.time_ and arg_312_1.time_ <= 1 + arg_315_0 then
				local var_315_1 = arg_312_1.bgs_.STblack

				arg_312_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_315_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_315_2 = var_315_1:GetComponent("SpriteRenderer")

				if var_315_2 and var_315_2.sprite then
					local var_315_3 = 2 * (var_315_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_315_1.transform.localScale = Vector3.New(var_315_3 / var_315_2.sprite.bounds.size.y < var_315_3 * manager.ui.mainCameraCom_.aspect / var_315_2.sprite.bounds.size.x and var_315_3 * manager.ui.mainCameraCom_.aspect / var_315_2.sprite.bounds.size.x or var_315_3 / var_315_2.sprite.bounds.size.y, var_315_3 / var_315_2.sprite.bounds.size.y < var_315_3 * manager.ui.mainCameraCom_.aspect / var_315_2.sprite.bounds.size.x and var_315_3 * manager.ui.mainCameraCom_.aspect / var_315_2.sprite.bounds.size.x or var_315_3 / var_315_2.sprite.bounds.size.y, 0)
				end

				for iter_315_0, iter_315_1 in pairs(arg_312_1.bgs_) do
					if iter_315_0 ~= "STblack" then
						iter_315_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_315_4 = 0

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_4 + arg_315_0 then
				arg_312_1.mask_.enabled = true
				arg_312_1.mask_.raycastTarget = false

				arg_312_1:SetGaussion(false)
			end

			local var_315_5 = 1

			if var_315_4 <= arg_312_1.time_ and arg_312_1.time_ < var_315_4 + var_315_5 then
				local var_315_6 = Color.New(0, 0, 0)

				var_315_6.a = Mathf.Lerp(0, 1, (arg_312_1.time_ - var_315_4) / var_315_5)
				arg_312_1.mask_.color = var_315_6
			end

			if arg_312_1.time_ >= var_315_4 + var_315_5 and arg_312_1.time_ < var_315_4 + var_315_5 + arg_315_0 then
				local var_315_7 = Color.New(0, 0, 0)

				var_315_7.a = 1
				arg_312_1.mask_.color = var_315_7
			end

			local var_315_8 = 1

			if 1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_8 + arg_315_0 then
				arg_312_1.mask_.enabled = true
				arg_312_1.mask_.raycastTarget = false

				arg_312_1:SetGaussion(false)
			end

			local var_315_9 = 2

			if var_315_8 <= arg_312_1.time_ and arg_312_1.time_ < var_315_8 + var_315_9 then
				local var_315_10 = Color.New(0, 0, 0)

				var_315_10.a = Mathf.Lerp(1, 0, (arg_312_1.time_ - var_315_8) / var_315_9)
				arg_312_1.mask_.color = var_315_10
			end

			if arg_312_1.time_ >= var_315_8 + var_315_9 and arg_312_1.time_ < var_315_8 + var_315_9 + arg_315_0 then
				local var_315_11 = Color.New(0, 0, 0)

				arg_312_1.mask_.enabled = false
				var_315_11.a = 0
				arg_312_1.mask_.color = var_315_11
			end

			local var_315_12 = arg_312_1.actors_["1038"].transform

			if 1 < arg_312_1.time_ and arg_312_1.time_ <= 1 + arg_315_0 then
				arg_312_1.var_.moveOldPos1038 = var_315_12.localPosition
				var_315_12.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("1038", 0)

				for iter_315_2 = 0, var_315_12.childCount - 1 do
					local var_315_13 = var_315_12:GetChild(iter_315_2)

					if var_315_13.name == "split_7" or not string.find(var_315_13.name, "split") then
						var_315_13.gameObject:SetActive(true)
					else
						var_315_13.gameObject:SetActive(false)
					end
				end
			end

			local var_315_14 = 0.001

			if 1 <= arg_312_1.time_ and arg_312_1.time_ < 1 + var_315_14 then
				var_315_12.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1038, Vector3.New(-2000, -400, 0), (arg_312_1.time_ - 1) / var_315_14)
			end

			if arg_312_1.time_ >= 1 + var_315_14 and arg_312_1.time_ < 1 + var_315_14 + arg_315_0 then
				var_315_12.localPosition = Vector3.New(-2000, -400, 0)
			end

			local var_315_15 = arg_312_1.actors_["10030"].transform

			if 1 < arg_312_1.time_ and arg_312_1.time_ <= 1 + arg_315_0 then
				arg_312_1.var_.moveOldPos10030 = var_315_15.localPosition
				var_315_15.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("10030", 0)

				for iter_315_3 = 0, var_315_15.childCount - 1 do
					local var_315_16 = var_315_15:GetChild(iter_315_3)

					if var_315_16.name == "split_3" or not string.find(var_315_16.name, "split") then
						var_315_16.gameObject:SetActive(true)
					else
						var_315_16.gameObject:SetActive(false)
					end
				end
			end

			local var_315_17 = 0.001

			if 1 <= arg_312_1.time_ and arg_312_1.time_ < 1 + var_315_17 then
				var_315_15.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos10030, Vector3.New(-2000, -390, 150), (arg_312_1.time_ - 1) / var_315_17)
			end

			if arg_312_1.time_ >= 1 + var_315_17 and arg_312_1.time_ < 1 + var_315_17 + arg_315_0 then
				var_315_15.localPosition = Vector3.New(-2000, -390, 150)
			end

			if arg_312_1.frameCnt_ <= 1 then
				arg_312_1.dialog_:SetActive(false)
			end

			local var_315_18 = 3
			local var_315_19 = 0.4

			if 3 < arg_312_1.time_ and arg_312_1.time_ <= var_315_18 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0

				arg_312_1.dialog_:SetActive(true)

				arg_312_1.dialogCg_.alpha = 0

				local var_315_20 = LeanTween.value(arg_312_1.dialog_, 0, 1, 0.3)

				var_315_20:setOnUpdate(LuaHelper.FloatAction(function(arg_316_0)
					arg_312_1.dialogCg_.alpha = arg_316_0
				end))
				var_315_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_312_1.dialog_)
					var_315_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_312_1.duration_ = arg_312_1.duration_ + 0.3

				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_21 = arg_312_1:FormatText(arg_312_1:GetWordFromCfg(115301078).content)

				arg_312_1.text_.text = var_315_21

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_23 = 16 <= 0 and var_315_19 or var_315_19 * (utf8.len(var_315_21) / 16)

				if (16 <= 0 and var_315_19 or var_315_19 * (utf8.len(var_315_21) / 16)) > 0 and var_315_19 < var_315_23 then
					arg_312_1.talkMaxDuration = var_315_23
					var_315_18 = var_315_18 + 0.3

					if var_315_23 + var_315_18 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_23 + var_315_18
					end
				end

				arg_312_1.text_.text = var_315_21
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_24 = var_315_18 + 0.3
			local var_315_25 = math.max(var_315_19, arg_312_1.talkMaxDuration)

			if var_315_18 + 0.3 <= arg_312_1.time_ and arg_312_1.time_ < var_315_24 + var_315_25 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_24) / var_315_25

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_24 + var_315_25 and arg_312_1.time_ < var_315_24 + var_315_25 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play115301079 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 115301079
		arg_318_1.duration_ = 6.33

		local var_318_0 = {
			ja = 6.333,
			ko = 1.333,
			zh = 2.3,
			en = 1.233
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play115301080(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0.075

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10030_split_3")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_1 = arg_318_1:GetWordFromCfg(115301079)
				local var_321_2 = arg_318_1:FormatText(var_321_1.content)

				arg_318_1.text_.text = var_321_2

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_4 = 3 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_2) / 3)

				if (3 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_2) / 3)) > 0 and var_321_0 < var_321_4 then
					arg_318_1.talkMaxDuration = var_321_4

					if var_321_4 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_4 + 0
					end
				end

				arg_318_1.text_.text = var_321_2
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301079", "story_v_out_115301.awb") ~= 0 then
					local var_321_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301079", "story_v_out_115301.awb") / 1000

					if var_321_5 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_5 + 0
					end

					if var_321_1.prefab_name ~= "" and arg_318_1.actors_[var_321_1.prefab_name] ~= nil then
						local var_321_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_1.prefab_name].transform, "story_v_out_115301", "115301079", "story_v_out_115301.awb")

						arg_318_1:RecordAudio("115301079", var_321_6)
						arg_318_1:RecordAudio("115301079", var_321_6)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_115301", "115301079", "story_v_out_115301.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_115301", "115301079", "story_v_out_115301.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_7 = math.max(var_321_0, arg_318_1.talkMaxDuration)

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_7 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - 0) / var_321_7

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= 0 + var_321_7 and arg_318_1.time_ < 0 + var_321_7 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play115301080 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 115301080
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play115301081(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0.525

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_1 = arg_322_1:FormatText(arg_322_1:GetWordFromCfg(115301080).content)

				arg_322_1.text_.text = var_325_1

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_3 = 21 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_1) / 21)

				if (21 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_1) / 21)) > 0 and var_325_0 < var_325_3 then
					arg_322_1.talkMaxDuration = var_325_3

					if var_325_3 + 0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_3 + 0
					end
				end

				arg_322_1.text_.text = var_325_1
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_4 = math.max(var_325_0, arg_322_1.talkMaxDuration)

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_4 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - 0) / var_325_4

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= 0 + var_325_4 and arg_322_1.time_ < 0 + var_325_4 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play115301081 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 115301081
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play115301082(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 1.05

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_1 = arg_326_1:FormatText(arg_326_1:GetWordFromCfg(115301081).content)

				arg_326_1.text_.text = var_329_1

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_3 = 42 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_1) / 42)

				if (42 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_1) / 42)) > 0 and var_329_0 < var_329_3 then
					arg_326_1.talkMaxDuration = var_329_3

					if var_329_3 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_3 + 0
					end
				end

				arg_326_1.text_.text = var_329_1
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_4 = math.max(var_329_0, arg_326_1.talkMaxDuration)

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_4 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - 0) / var_329_4

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= 0 + var_329_4 and arg_326_1.time_ < 0 + var_329_4 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play115301082 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 115301082
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play115301083(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0.625

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_1 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(115301082).content)

				arg_330_1.text_.text = var_333_1

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_3 = 25 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_1) / 25)

				if (25 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_1) / 25)) > 0 and var_333_0 < var_333_3 then
					arg_330_1.talkMaxDuration = var_333_3

					if var_333_3 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_3 + 0
					end
				end

				arg_330_1.text_.text = var_333_1
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_4 = math.max(var_333_0, arg_330_1.talkMaxDuration)

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_4 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - 0) / var_333_4

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= 0 + var_333_4 and arg_330_1.time_ < 0 + var_333_4 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play115301083 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 115301083
		arg_334_1.duration_ = 5.9

		local var_334_0 = {
			ja = 5.8,
			ko = 5.9,
			zh = 5.833,
			en = 5.5
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play115301084(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if arg_334_1.bgs_.RO0503 == nil then
				local var_337_0 = Object.Instantiate(arg_334_1.paintGo_)

				var_337_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "RO0503")
				var_337_0.name = "RO0503"
				var_337_0.transform.parent = arg_334_1.stage_.transform
				var_337_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_334_1.bgs_.RO0503 = var_337_0
			end

			if 2 < arg_334_1.time_ and arg_334_1.time_ <= 2 + arg_337_0 then
				local var_337_1 = arg_334_1.bgs_.RO0503

				arg_334_1.bgs_.RO0503.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_337_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_337_2 = var_337_1:GetComponent("SpriteRenderer")

				if var_337_2 and var_337_2.sprite then
					local var_337_3 = 2 * (var_337_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_337_1.transform.localScale = Vector3.New(var_337_3 / var_337_2.sprite.bounds.size.y < var_337_3 * manager.ui.mainCameraCom_.aspect / var_337_2.sprite.bounds.size.x and var_337_3 * manager.ui.mainCameraCom_.aspect / var_337_2.sprite.bounds.size.x or var_337_3 / var_337_2.sprite.bounds.size.y, var_337_3 / var_337_2.sprite.bounds.size.y < var_337_3 * manager.ui.mainCameraCom_.aspect / var_337_2.sprite.bounds.size.x and var_337_3 * manager.ui.mainCameraCom_.aspect / var_337_2.sprite.bounds.size.x or var_337_3 / var_337_2.sprite.bounds.size.y, 0)
				end

				for iter_337_0, iter_337_1 in pairs(arg_334_1.bgs_) do
					if iter_337_0 ~= "RO0503" then
						iter_337_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_337_4 = 0

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_4 + arg_337_0 then
				arg_334_1.mask_.enabled = true
				arg_334_1.mask_.raycastTarget = false

				arg_334_1:SetGaussion(false)
			end

			local var_337_5 = 2

			if var_337_4 <= arg_334_1.time_ and arg_334_1.time_ < var_337_4 + var_337_5 then
				local var_337_6 = Color.New(0, 0, 0)

				var_337_6.a = Mathf.Lerp(0, 1, (arg_334_1.time_ - var_337_4) / var_337_5)
				arg_334_1.mask_.color = var_337_6
			end

			if arg_334_1.time_ >= var_337_4 + var_337_5 and arg_334_1.time_ < var_337_4 + var_337_5 + arg_337_0 then
				local var_337_7 = Color.New(0, 0, 0)

				var_337_7.a = 1
				arg_334_1.mask_.color = var_337_7
			end

			local var_337_8 = 2

			if 2 < arg_334_1.time_ and arg_334_1.time_ <= var_337_8 + arg_337_0 then
				arg_334_1.mask_.enabled = true
				arg_334_1.mask_.raycastTarget = false

				arg_334_1:SetGaussion(false)
			end

			local var_337_9 = 2

			if var_337_8 <= arg_334_1.time_ and arg_334_1.time_ < var_337_8 + var_337_9 then
				local var_337_10 = Color.New(0, 0, 0)

				var_337_10.a = Mathf.Lerp(1, 0, (arg_334_1.time_ - var_337_8) / var_337_9)
				arg_334_1.mask_.color = var_337_10
			end

			if arg_334_1.time_ >= var_337_8 + var_337_9 and arg_334_1.time_ < var_337_8 + var_337_9 + arg_337_0 then
				local var_337_11 = Color.New(0, 0, 0)

				arg_334_1.mask_.enabled = false
				var_337_11.a = 0
				arg_334_1.mask_.color = var_337_11
			end

			if arg_334_1.frameCnt_ <= 1 then
				arg_334_1.dialog_:SetActive(false)
			end

			local var_337_12 = 4
			local var_337_13 = 0.075

			if 4 < arg_334_1.time_ and arg_334_1.time_ <= var_337_12 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0

				arg_334_1.dialog_:SetActive(true)

				arg_334_1.dialogCg_.alpha = 0

				local var_337_14 = LeanTween.value(arg_334_1.dialog_, 0, 1, 0.3)

				var_337_14:setOnUpdate(LuaHelper.FloatAction(function(arg_338_0)
					arg_334_1.dialogCg_.alpha = arg_338_0
				end))
				var_337_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_334_1.dialog_)
					var_337_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_334_1.duration_ = arg_334_1.duration_ + 0.3

				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_15 = arg_334_1:GetWordFromCfg(115301083)
				local var_337_16 = arg_334_1:FormatText(var_337_15.content)

				arg_334_1.text_.text = var_337_16

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_18 = 3 <= 0 and var_337_13 or var_337_13 * (utf8.len(var_337_16) / 3)

				if (3 <= 0 and var_337_13 or var_337_13 * (utf8.len(var_337_16) / 3)) > 0 and var_337_13 < var_337_18 then
					arg_334_1.talkMaxDuration = var_337_18
					var_337_12 = var_337_12 + 0.3

					if var_337_18 + var_337_12 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_18 + var_337_12
					end
				end

				arg_334_1.text_.text = var_337_16
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301083", "story_v_out_115301.awb") ~= 0 then
					local var_337_19 = manager.audio:GetVoiceLength("story_v_out_115301", "115301083", "story_v_out_115301.awb") / 1000

					if var_337_19 + var_337_12 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_19 + var_337_12
					end

					if var_337_15.prefab_name ~= "" and arg_334_1.actors_[var_337_15.prefab_name] ~= nil then
						local var_337_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_15.prefab_name].transform, "story_v_out_115301", "115301083", "story_v_out_115301.awb")

						arg_334_1:RecordAudio("115301083", var_337_20)
						arg_334_1:RecordAudio("115301083", var_337_20)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_115301", "115301083", "story_v_out_115301.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_115301", "115301083", "story_v_out_115301.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_21 = var_337_12 + 0.3
			local var_337_22 = math.max(var_337_13, arg_334_1.talkMaxDuration)

			if var_337_12 + 0.3 <= arg_334_1.time_ and arg_334_1.time_ < var_337_21 + var_337_22 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_21) / var_337_22

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_21 + var_337_22 and arg_334_1.time_ < var_337_21 + var_337_22 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play115301084 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 115301084
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play115301085(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0.875

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, false)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_1 = arg_340_1:FormatText(arg_340_1:GetWordFromCfg(115301084).content)

				arg_340_1.text_.text = var_343_1

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_3 = 35 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_1) / 35)

				if (35 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_1) / 35)) > 0 and var_343_0 < var_343_3 then
					arg_340_1.talkMaxDuration = var_343_3

					if var_343_3 + 0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_3 + 0
					end
				end

				arg_340_1.text_.text = var_343_1
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_4 = math.max(var_343_0, arg_340_1.talkMaxDuration)

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_4 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - 0) / var_343_4

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= 0 + var_343_4 and arg_340_1.time_ < 0 + var_343_4 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play115301085 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 115301085
		arg_344_1.duration_ = 3.63

		local var_344_0 = {
			ja = 3.633,
			ko = 3.166,
			zh = 2.866,
			en = 1.9
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play115301086(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0.275

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_1 = arg_344_1:GetWordFromCfg(115301085)
				local var_347_2 = arg_344_1:FormatText(var_347_1.content)

				arg_344_1.text_.text = var_347_2

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_4 = 11 <= 0 and var_347_0 or var_347_0 * (utf8.len(var_347_2) / 11)

				if (11 <= 0 and var_347_0 or var_347_0 * (utf8.len(var_347_2) / 11)) > 0 and var_347_0 < var_347_4 then
					arg_344_1.talkMaxDuration = var_347_4

					if var_347_4 + 0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_4 + 0
					end
				end

				arg_344_1.text_.text = var_347_2
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301085", "story_v_out_115301.awb") ~= 0 then
					local var_347_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301085", "story_v_out_115301.awb") / 1000

					if var_347_5 + 0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_5 + 0
					end

					if var_347_1.prefab_name ~= "" and arg_344_1.actors_[var_347_1.prefab_name] ~= nil then
						local var_347_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_1.prefab_name].transform, "story_v_out_115301", "115301085", "story_v_out_115301.awb")

						arg_344_1:RecordAudio("115301085", var_347_6)
						arg_344_1:RecordAudio("115301085", var_347_6)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_115301", "115301085", "story_v_out_115301.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_115301", "115301085", "story_v_out_115301.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_7 = math.max(var_347_0, arg_344_1.talkMaxDuration)

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_7 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - 0) / var_347_7

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= 0 + var_347_7 and arg_344_1.time_ < 0 + var_347_7 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play115301086 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 115301086
		arg_348_1.duration_ = 6.9

		local var_348_0 = {
			ja = 2.6,
			ko = 3.166,
			zh = 3.766,
			en = 6.9
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play115301087(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0.325

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[317].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_1 = arg_348_1:GetWordFromCfg(115301086)
				local var_351_2 = arg_348_1:FormatText(var_351_1.content)

				arg_348_1.text_.text = var_351_2

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_4 = 13 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_2) / 13)

				if (13 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_2) / 13)) > 0 and var_351_0 < var_351_4 then
					arg_348_1.talkMaxDuration = var_351_4

					if var_351_4 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_4 + 0
					end
				end

				arg_348_1.text_.text = var_351_2
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301086", "story_v_out_115301.awb") ~= 0 then
					local var_351_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301086", "story_v_out_115301.awb") / 1000

					if var_351_5 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_5 + 0
					end

					if var_351_1.prefab_name ~= "" and arg_348_1.actors_[var_351_1.prefab_name] ~= nil then
						local var_351_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_1.prefab_name].transform, "story_v_out_115301", "115301086", "story_v_out_115301.awb")

						arg_348_1:RecordAudio("115301086", var_351_6)
						arg_348_1:RecordAudio("115301086", var_351_6)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_115301", "115301086", "story_v_out_115301.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_115301", "115301086", "story_v_out_115301.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_7 = math.max(var_351_0, arg_348_1.talkMaxDuration)

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_7 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - 0) / var_351_7

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= 0 + var_351_7 and arg_348_1.time_ < 0 + var_351_7 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play115301087 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 115301087
		arg_352_1.duration_ = 5.77

		local var_352_0 = {
			ja = 5.766,
			ko = 4,
			zh = 4.1,
			en = 5.033
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play115301088(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = 0.375

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_1 = arg_352_1:GetWordFromCfg(115301087)
				local var_355_2 = arg_352_1:FormatText(var_355_1.content)

				arg_352_1.text_.text = var_355_2

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_4 = 15 <= 0 and var_355_0 or var_355_0 * (utf8.len(var_355_2) / 15)

				if (15 <= 0 and var_355_0 or var_355_0 * (utf8.len(var_355_2) / 15)) > 0 and var_355_0 < var_355_4 then
					arg_352_1.talkMaxDuration = var_355_4

					if var_355_4 + 0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_4 + 0
					end
				end

				arg_352_1.text_.text = var_355_2
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301087", "story_v_out_115301.awb") ~= 0 then
					local var_355_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301087", "story_v_out_115301.awb") / 1000

					if var_355_5 + 0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_5 + 0
					end

					if var_355_1.prefab_name ~= "" and arg_352_1.actors_[var_355_1.prefab_name] ~= nil then
						local var_355_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_1.prefab_name].transform, "story_v_out_115301", "115301087", "story_v_out_115301.awb")

						arg_352_1:RecordAudio("115301087", var_355_6)
						arg_352_1:RecordAudio("115301087", var_355_6)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_115301", "115301087", "story_v_out_115301.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_115301", "115301087", "story_v_out_115301.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_7 = math.max(var_355_0, arg_352_1.talkMaxDuration)

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_7 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - 0) / var_355_7

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= 0 + var_355_7 and arg_352_1.time_ < 0 + var_355_7 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play115301088 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 115301088
		arg_356_1.duration_ = 7.07

		local var_356_0 = {
			ja = 5.166,
			ko = 6.733,
			zh = 5.866,
			en = 7.066
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play115301089(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0.525

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[317].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_1 = arg_356_1:GetWordFromCfg(115301088)
				local var_359_2 = arg_356_1:FormatText(var_359_1.content)

				arg_356_1.text_.text = var_359_2

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_4 = 21 <= 0 and var_359_0 or var_359_0 * (utf8.len(var_359_2) / 21)

				if (21 <= 0 and var_359_0 or var_359_0 * (utf8.len(var_359_2) / 21)) > 0 and var_359_0 < var_359_4 then
					arg_356_1.talkMaxDuration = var_359_4

					if var_359_4 + 0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_4 + 0
					end
				end

				arg_356_1.text_.text = var_359_2
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301088", "story_v_out_115301.awb") ~= 0 then
					local var_359_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301088", "story_v_out_115301.awb") / 1000

					if var_359_5 + 0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_5 + 0
					end

					if var_359_1.prefab_name ~= "" and arg_356_1.actors_[var_359_1.prefab_name] ~= nil then
						local var_359_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_1.prefab_name].transform, "story_v_out_115301", "115301088", "story_v_out_115301.awb")

						arg_356_1:RecordAudio("115301088", var_359_6)
						arg_356_1:RecordAudio("115301088", var_359_6)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_115301", "115301088", "story_v_out_115301.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_115301", "115301088", "story_v_out_115301.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_7 = math.max(var_359_0, arg_356_1.talkMaxDuration)

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_7 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - 0) / var_359_7

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= 0 + var_359_7 and arg_356_1.time_ < 0 + var_359_7 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play115301089 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 115301089
		arg_360_1.duration_ = 15.5

		local var_360_0 = {
			ja = 9.466,
			ko = 11.533,
			zh = 11.833,
			en = 15.5
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play115301090(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 1.2

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[317].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_1 = arg_360_1:GetWordFromCfg(115301089)
				local var_363_2 = arg_360_1:FormatText(var_363_1.content)

				arg_360_1.text_.text = var_363_2

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_4 = 48 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_2) / 48)

				if (48 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_2) / 48)) > 0 and var_363_0 < var_363_4 then
					arg_360_1.talkMaxDuration = var_363_4

					if var_363_4 + 0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_4 + 0
					end
				end

				arg_360_1.text_.text = var_363_2
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301089", "story_v_out_115301.awb") ~= 0 then
					local var_363_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301089", "story_v_out_115301.awb") / 1000

					if var_363_5 + 0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_5 + 0
					end

					if var_363_1.prefab_name ~= "" and arg_360_1.actors_[var_363_1.prefab_name] ~= nil then
						local var_363_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_1.prefab_name].transform, "story_v_out_115301", "115301089", "story_v_out_115301.awb")

						arg_360_1:RecordAudio("115301089", var_363_6)
						arg_360_1:RecordAudio("115301089", var_363_6)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_115301", "115301089", "story_v_out_115301.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_115301", "115301089", "story_v_out_115301.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_7 = math.max(var_363_0, arg_360_1.talkMaxDuration)

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_7 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - 0) / var_363_7

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= 0 + var_363_7 and arg_360_1.time_ < 0 + var_363_7 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play115301090 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 115301090
		arg_364_1.duration_ = 5.63

		local var_364_0 = {
			ja = 5.633,
			ko = 2.9,
			zh = 2.633,
			en = 3.733
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play115301091(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0.3

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_1 = arg_364_1:GetWordFromCfg(115301090)
				local var_367_2 = arg_364_1:FormatText(var_367_1.content)

				arg_364_1.text_.text = var_367_2

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_4 = 12 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_2) / 12)

				if (12 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_2) / 12)) > 0 and var_367_0 < var_367_4 then
					arg_364_1.talkMaxDuration = var_367_4

					if var_367_4 + 0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_4 + 0
					end
				end

				arg_364_1.text_.text = var_367_2
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301090", "story_v_out_115301.awb") ~= 0 then
					local var_367_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301090", "story_v_out_115301.awb") / 1000

					if var_367_5 + 0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_5 + 0
					end

					if var_367_1.prefab_name ~= "" and arg_364_1.actors_[var_367_1.prefab_name] ~= nil then
						local var_367_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_1.prefab_name].transform, "story_v_out_115301", "115301090", "story_v_out_115301.awb")

						arg_364_1:RecordAudio("115301090", var_367_6)
						arg_364_1:RecordAudio("115301090", var_367_6)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_115301", "115301090", "story_v_out_115301.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_115301", "115301090", "story_v_out_115301.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_7 = math.max(var_367_0, arg_364_1.talkMaxDuration)

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_7 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - 0) / var_367_7

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= 0 + var_367_7 and arg_364_1.time_ < 0 + var_367_7 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play115301091 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 115301091
		arg_368_1.duration_ = 11.6

		local var_368_0 = {
			ja = 11.6,
			ko = 7.333,
			zh = 6.8,
			en = 8.9
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play115301092(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0.825

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[317].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_1 = arg_368_1:GetWordFromCfg(115301091)
				local var_371_2 = arg_368_1:FormatText(var_371_1.content)

				arg_368_1.text_.text = var_371_2

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_4 = 33 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_2) / 33)

				if (33 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_2) / 33)) > 0 and var_371_0 < var_371_4 then
					arg_368_1.talkMaxDuration = var_371_4

					if var_371_4 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_4 + 0
					end
				end

				arg_368_1.text_.text = var_371_2
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301091", "story_v_out_115301.awb") ~= 0 then
					local var_371_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301091", "story_v_out_115301.awb") / 1000

					if var_371_5 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_5 + 0
					end

					if var_371_1.prefab_name ~= "" and arg_368_1.actors_[var_371_1.prefab_name] ~= nil then
						local var_371_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_1.prefab_name].transform, "story_v_out_115301", "115301091", "story_v_out_115301.awb")

						arg_368_1:RecordAudio("115301091", var_371_6)
						arg_368_1:RecordAudio("115301091", var_371_6)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_115301", "115301091", "story_v_out_115301.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_115301", "115301091", "story_v_out_115301.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_7 = math.max(var_371_0, arg_368_1.talkMaxDuration)

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_7 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - 0) / var_371_7

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= 0 + var_371_7 and arg_368_1.time_ < 0 + var_371_7 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play115301092 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 115301092
		arg_372_1.duration_ = 7.43

		local var_372_0 = {
			ja = 7.433,
			ko = 5.566,
			zh = 4.1,
			en = 4.533
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play115301093(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0.475

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_1 = arg_372_1:GetWordFromCfg(115301092)
				local var_375_2 = arg_372_1:FormatText(var_375_1.content)

				arg_372_1.text_.text = var_375_2

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_4 = 19 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_2) / 19)

				if (19 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_2) / 19)) > 0 and var_375_0 < var_375_4 then
					arg_372_1.talkMaxDuration = var_375_4

					if var_375_4 + 0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_4 + 0
					end
				end

				arg_372_1.text_.text = var_375_2
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301092", "story_v_out_115301.awb") ~= 0 then
					local var_375_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301092", "story_v_out_115301.awb") / 1000

					if var_375_5 + 0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_5 + 0
					end

					if var_375_1.prefab_name ~= "" and arg_372_1.actors_[var_375_1.prefab_name] ~= nil then
						local var_375_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_1.prefab_name].transform, "story_v_out_115301", "115301092", "story_v_out_115301.awb")

						arg_372_1:RecordAudio("115301092", var_375_6)
						arg_372_1:RecordAudio("115301092", var_375_6)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_115301", "115301092", "story_v_out_115301.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_115301", "115301092", "story_v_out_115301.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_7 = math.max(var_375_0, arg_372_1.talkMaxDuration)

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_7 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - 0) / var_375_7

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= 0 + var_375_7 and arg_372_1.time_ < 0 + var_375_7 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play115301093 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 115301093
		arg_376_1.duration_ = 5.93

		local var_376_0 = {
			ja = 3.7,
			ko = 5.8,
			zh = 4.766,
			en = 5.933
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play115301094(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0.45

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[317].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_1 = arg_376_1:GetWordFromCfg(115301093)
				local var_379_2 = arg_376_1:FormatText(var_379_1.content)

				arg_376_1.text_.text = var_379_2

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_4 = 18 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_2) / 18)

				if (18 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_2) / 18)) > 0 and var_379_0 < var_379_4 then
					arg_376_1.talkMaxDuration = var_379_4

					if var_379_4 + 0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_4 + 0
					end
				end

				arg_376_1.text_.text = var_379_2
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301093", "story_v_out_115301.awb") ~= 0 then
					local var_379_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301093", "story_v_out_115301.awb") / 1000

					if var_379_5 + 0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_5 + 0
					end

					if var_379_1.prefab_name ~= "" and arg_376_1.actors_[var_379_1.prefab_name] ~= nil then
						local var_379_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_1.prefab_name].transform, "story_v_out_115301", "115301093", "story_v_out_115301.awb")

						arg_376_1:RecordAudio("115301093", var_379_6)
						arg_376_1:RecordAudio("115301093", var_379_6)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_115301", "115301093", "story_v_out_115301.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_115301", "115301093", "story_v_out_115301.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_7 = math.max(var_379_0, arg_376_1.talkMaxDuration)

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_7 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - 0) / var_379_7

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= 0 + var_379_7 and arg_376_1.time_ < 0 + var_379_7 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play115301094 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 115301094
		arg_380_1.duration_ = 7.47

		local var_380_0 = {
			ja = 7.466,
			ko = 6,
			zh = 5.7,
			en = 5.933
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play115301095(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0.65

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[317].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_1 = arg_380_1:GetWordFromCfg(115301094)
				local var_383_2 = arg_380_1:FormatText(var_383_1.content)

				arg_380_1.text_.text = var_383_2

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_4 = 26 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_2) / 26)

				if (26 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_2) / 26)) > 0 and var_383_0 < var_383_4 then
					arg_380_1.talkMaxDuration = var_383_4

					if var_383_4 + 0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_4 + 0
					end
				end

				arg_380_1.text_.text = var_383_2
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301094", "story_v_out_115301.awb") ~= 0 then
					local var_383_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301094", "story_v_out_115301.awb") / 1000

					if var_383_5 + 0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_5 + 0
					end

					if var_383_1.prefab_name ~= "" and arg_380_1.actors_[var_383_1.prefab_name] ~= nil then
						local var_383_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_1.prefab_name].transform, "story_v_out_115301", "115301094", "story_v_out_115301.awb")

						arg_380_1:RecordAudio("115301094", var_383_6)
						arg_380_1:RecordAudio("115301094", var_383_6)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_115301", "115301094", "story_v_out_115301.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_115301", "115301094", "story_v_out_115301.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_7 = math.max(var_383_0, arg_380_1.talkMaxDuration)

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_7 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - 0) / var_383_7

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= 0 + var_383_7 and arg_380_1.time_ < 0 + var_383_7 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play115301095 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 115301095
		arg_384_1.duration_ = 9

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play115301096(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 2 < arg_384_1.time_ and arg_384_1.time_ <= 2 + arg_387_0 then
				local var_387_0 = arg_384_1.bgs_.F01

				arg_384_1.bgs_.F01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_387_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_387_1 = var_387_0:GetComponent("SpriteRenderer")

				if var_387_1 and var_387_1.sprite then
					local var_387_2 = 2 * (var_387_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_387_0.transform.localScale = Vector3.New(var_387_2 / var_387_1.sprite.bounds.size.y < var_387_2 * manager.ui.mainCameraCom_.aspect / var_387_1.sprite.bounds.size.x and var_387_2 * manager.ui.mainCameraCom_.aspect / var_387_1.sprite.bounds.size.x or var_387_2 / var_387_1.sprite.bounds.size.y, var_387_2 / var_387_1.sprite.bounds.size.y < var_387_2 * manager.ui.mainCameraCom_.aspect / var_387_1.sprite.bounds.size.x and var_387_2 * manager.ui.mainCameraCom_.aspect / var_387_1.sprite.bounds.size.x or var_387_2 / var_387_1.sprite.bounds.size.y, 0)
				end

				for iter_387_0, iter_387_1 in pairs(arg_384_1.bgs_) do
					if iter_387_0 ~= "F01" then
						iter_387_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_387_3 = 0

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_3 + arg_387_0 then
				arg_384_1.mask_.enabled = true
				arg_384_1.mask_.raycastTarget = false

				arg_384_1:SetGaussion(false)
			end

			local var_387_4 = 2

			if var_387_3 <= arg_384_1.time_ and arg_384_1.time_ < var_387_3 + var_387_4 then
				local var_387_5 = Color.New(0, 0, 0)

				var_387_5.a = Mathf.Lerp(0, 1, (arg_384_1.time_ - var_387_3) / var_387_4)
				arg_384_1.mask_.color = var_387_5
			end

			if arg_384_1.time_ >= var_387_3 + var_387_4 and arg_384_1.time_ < var_387_3 + var_387_4 + arg_387_0 then
				local var_387_6 = Color.New(0, 0, 0)

				var_387_6.a = 1
				arg_384_1.mask_.color = var_387_6
			end

			local var_387_7 = 2

			if 2 < arg_384_1.time_ and arg_384_1.time_ <= var_387_7 + arg_387_0 then
				arg_384_1.mask_.enabled = true
				arg_384_1.mask_.raycastTarget = false

				arg_384_1:SetGaussion(false)
			end

			local var_387_8 = 2

			if var_387_7 <= arg_384_1.time_ and arg_384_1.time_ < var_387_7 + var_387_8 then
				local var_387_9 = Color.New(0, 0, 0)

				var_387_9.a = Mathf.Lerp(1, 0, (arg_384_1.time_ - var_387_7) / var_387_8)
				arg_384_1.mask_.color = var_387_9
			end

			if arg_384_1.time_ >= var_387_7 + var_387_8 and arg_384_1.time_ < var_387_7 + var_387_8 + arg_387_0 then
				local var_387_10 = Color.New(0, 0, 0)

				arg_384_1.mask_.enabled = false
				var_387_10.a = 0
				arg_384_1.mask_.color = var_387_10
			end

			if arg_384_1.frameCnt_ <= 1 then
				arg_384_1.dialog_:SetActive(false)
			end

			local var_387_11 = 4
			local var_387_12 = 0.875

			if 4 < arg_384_1.time_ and arg_384_1.time_ <= var_387_11 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0

				arg_384_1.dialog_:SetActive(true)

				arg_384_1.dialogCg_.alpha = 0

				local var_387_13 = LeanTween.value(arg_384_1.dialog_, 0, 1, 0.3)

				var_387_13:setOnUpdate(LuaHelper.FloatAction(function(arg_388_0)
					arg_384_1.dialogCg_.alpha = arg_388_0
				end))
				var_387_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_384_1.dialog_)
					var_387_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_384_1.duration_ = arg_384_1.duration_ + 0.3

				SetActive(arg_384_1.leftNameGo_, false)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_14 = arg_384_1:FormatText(arg_384_1:GetWordFromCfg(115301095).content)

				arg_384_1.text_.text = var_387_14

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_16 = 35 <= 0 and var_387_12 or var_387_12 * (utf8.len(var_387_14) / 35)

				if (35 <= 0 and var_387_12 or var_387_12 * (utf8.len(var_387_14) / 35)) > 0 and var_387_12 < var_387_16 then
					arg_384_1.talkMaxDuration = var_387_16
					var_387_11 = var_387_11 + 0.3

					if var_387_16 + var_387_11 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_16 + var_387_11
					end
				end

				arg_384_1.text_.text = var_387_14
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_17 = var_387_11 + 0.3
			local var_387_18 = math.max(var_387_12, arg_384_1.talkMaxDuration)

			if var_387_11 + 0.3 <= arg_384_1.time_ and arg_384_1.time_ < var_387_17 + var_387_18 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_17) / var_387_18

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_17 + var_387_18 and arg_384_1.time_ < var_387_17 + var_387_18 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play115301096 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 115301096
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play115301097(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 1.5

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, false)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_1 = arg_390_1:FormatText(arg_390_1:GetWordFromCfg(115301096).content)

				arg_390_1.text_.text = var_393_1

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_3 = 60 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_1) / 60)

				if (60 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_1) / 60)) > 0 and var_393_0 < var_393_3 then
					arg_390_1.talkMaxDuration = var_393_3

					if var_393_3 + 0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_3 + 0
					end
				end

				arg_390_1.text_.text = var_393_1
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_4 = math.max(var_393_0, arg_390_1.talkMaxDuration)

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_4 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - 0) / var_393_4

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= 0 + var_393_4 and arg_390_1.time_ < 0 + var_393_4 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play115301097 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 115301097
		arg_394_1.duration_ = 10.4

		local var_394_0 = {
			ja = 4.7,
			ko = 8.266,
			zh = 8.166,
			en = 10.4
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play115301098(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.var_.moveOldPos10030 = arg_394_1.actors_["10030"].transform.localPosition
				arg_394_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_394_1:CheckSpriteTmpPos("10030", 3)

				for iter_397_0 = 0, arg_394_1.actors_["10030"].transform.childCount - 1 do
					local var_397_0 = arg_394_1.actors_["10030"].transform:GetChild(iter_397_0)

					if var_397_0.name == "split_3" or not string.find(var_397_0.name, "split") then
						var_397_0.gameObject:SetActive(true)
					else
						var_397_0.gameObject:SetActive(false)
					end
				end
			end

			local var_397_1 = 0.001

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_1 then
				arg_394_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_394_1.time_ - 0) / var_397_1)
			end

			if arg_394_1.time_ >= 0 + var_397_1 and arg_394_1.time_ < 0 + var_397_1 + arg_397_0 then
				arg_394_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			local var_397_2 = arg_394_1.actors_["10030"]

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(var_397_2) and arg_394_1.var_.actorSpriteComps10030 == nil then
				arg_394_1.var_.actorSpriteComps10030 = var_397_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_397_3 = 0.2

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_3 and not isNil(var_397_2) then
				if arg_394_1.var_.actorSpriteComps10030 then
					for iter_397_1, iter_397_2 in pairs(arg_394_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_397_2 then
							if arg_394_1.isInRecall_ then
								iter_397_2.color = Color.New(Mathf.Lerp(iter_397_2.color.r, arg_394_1.hightColor1.r, (arg_394_1.time_ - 0) / var_397_3), Mathf.Lerp(iter_397_2.color.g, arg_394_1.hightColor1.g, (arg_394_1.time_ - 0) / var_397_3), (Mathf.Lerp(iter_397_2.color.b, arg_394_1.hightColor1.b, (arg_394_1.time_ - 0) / var_397_3)))
							else
								local var_397_4 = Mathf.Lerp(iter_397_2.color.r, 1, (arg_394_1.time_ - 0) / var_397_3)

								iter_397_2.color = Color.New(var_397_4, var_397_4, var_397_4)
							end
						end
					end
				end
			end

			if arg_394_1.time_ >= 0 + var_397_3 and arg_394_1.time_ < 0 + var_397_3 + arg_397_0 and not isNil(var_397_2) and arg_394_1.var_.actorSpriteComps10030 then
				for iter_397_3, iter_397_4 in pairs(arg_394_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_397_4 then
						iter_397_4.color = arg_394_1.isInRecall_ and (arg_394_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_394_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				local var_397_5 = arg_394_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_397_5 then
					arg_394_1.var_.alphaOldValue10030 = var_397_5.alpha
					arg_394_1.var_.characterEffect10030 = var_397_5
				end

				arg_394_1.var_.alphaOldValue10030 = 0
			end

			local var_397_6 = 0.333333333333333

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_6 then
				if arg_394_1.var_.characterEffect10030 then
					arg_394_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_394_1.var_.alphaOldValue10030, 1, (arg_394_1.time_ - 0) / var_397_6)
				end
			end

			if arg_394_1.time_ >= 0 + var_397_6 and arg_394_1.time_ < 0 + var_397_6 + arg_397_0 and arg_394_1.var_.characterEffect10030 then
				arg_394_1.var_.characterEffect10030.alpha = 1
			end

			local var_397_7 = 0
			local var_397_8 = 0.725

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_7 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_9 = arg_394_1:GetWordFromCfg(115301097)
				local var_397_10 = arg_394_1:FormatText(var_397_9.content)

				arg_394_1.text_.text = var_397_10

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_12 = 29 <= 0 and var_397_8 or var_397_8 * (utf8.len(var_397_10) / 29)

				if (29 <= 0 and var_397_8 or var_397_8 * (utf8.len(var_397_10) / 29)) > 0 and var_397_8 < var_397_12 then
					arg_394_1.talkMaxDuration = var_397_12

					if var_397_12 + var_397_7 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_12 + var_397_7
					end
				end

				arg_394_1.text_.text = var_397_10
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301097", "story_v_out_115301.awb") ~= 0 then
					local var_397_13 = manager.audio:GetVoiceLength("story_v_out_115301", "115301097", "story_v_out_115301.awb") / 1000

					if var_397_13 + var_397_7 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_13 + var_397_7
					end

					if var_397_9.prefab_name ~= "" and arg_394_1.actors_[var_397_9.prefab_name] ~= nil then
						local var_397_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_9.prefab_name].transform, "story_v_out_115301", "115301097", "story_v_out_115301.awb")

						arg_394_1:RecordAudio("115301097", var_397_14)
						arg_394_1:RecordAudio("115301097", var_397_14)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_115301", "115301097", "story_v_out_115301.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_115301", "115301097", "story_v_out_115301.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_15 = math.max(var_397_8, arg_394_1.talkMaxDuration)

			if var_397_7 <= arg_394_1.time_ and arg_394_1.time_ < var_397_7 + var_397_15 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_7) / var_397_15

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_7 + var_397_15 and arg_394_1.time_ < var_397_7 + var_397_15 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_394_1:InitPlayNodeList()
	end,
	Play115301098 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 115301098
		arg_398_1.duration_ = 14.3

		local var_398_0 = {
			ja = 14.3,
			ko = 8.466,
			zh = 7.233,
			en = 8.233
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play115301099(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0.675

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_1 = arg_398_1:GetWordFromCfg(115301098)
				local var_401_2 = arg_398_1:FormatText(var_401_1.content)

				arg_398_1.text_.text = var_401_2

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_4 = 27 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_2) / 27)

				if (27 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_2) / 27)) > 0 and var_401_0 < var_401_4 then
					arg_398_1.talkMaxDuration = var_401_4

					if var_401_4 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_4 + 0
					end
				end

				arg_398_1.text_.text = var_401_2
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301098", "story_v_out_115301.awb") ~= 0 then
					local var_401_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301098", "story_v_out_115301.awb") / 1000

					if var_401_5 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_5 + 0
					end

					if var_401_1.prefab_name ~= "" and arg_398_1.actors_[var_401_1.prefab_name] ~= nil then
						local var_401_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_1.prefab_name].transform, "story_v_out_115301", "115301098", "story_v_out_115301.awb")

						arg_398_1:RecordAudio("115301098", var_401_6)
						arg_398_1:RecordAudio("115301098", var_401_6)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_115301", "115301098", "story_v_out_115301.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_115301", "115301098", "story_v_out_115301.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_7 = math.max(var_401_0, arg_398_1.talkMaxDuration)

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_7 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - 0) / var_401_7

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= 0 + var_401_7 and arg_398_1.time_ < 0 + var_401_7 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play115301099 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 115301099
		arg_402_1.duration_ = 5

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play115301100(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				local var_405_0 = arg_402_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_405_0 then
					arg_402_1.var_.alphaOldValue10030 = var_405_0.alpha
					arg_402_1.var_.characterEffect10030 = var_405_0
				end

				arg_402_1.var_.alphaOldValue10030 = 1
			end

			local var_405_1 = 0.333333333333333

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_1 then
				if arg_402_1.var_.characterEffect10030 then
					arg_402_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_402_1.var_.alphaOldValue10030, 0, (arg_402_1.time_ - 0) / var_405_1)
				end
			end

			if arg_402_1.time_ >= 0 + var_405_1 and arg_402_1.time_ < 0 + var_405_1 + arg_405_0 and arg_402_1.var_.characterEffect10030 then
				arg_402_1.var_.characterEffect10030.alpha = 0
			end

			local var_405_2 = 0
			local var_405_3 = 0.925

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_2 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, false)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_4 = arg_402_1:FormatText(arg_402_1:GetWordFromCfg(115301099).content)

				arg_402_1.text_.text = var_405_4

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_6 = 37 <= 0 and var_405_3 or var_405_3 * (utf8.len(var_405_4) / 37)

				if (37 <= 0 and var_405_3 or var_405_3 * (utf8.len(var_405_4) / 37)) > 0 and var_405_3 < var_405_6 then
					arg_402_1.talkMaxDuration = var_405_6

					if var_405_6 + var_405_2 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_6 + var_405_2
					end
				end

				arg_402_1.text_.text = var_405_4
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_7 = math.max(var_405_3, arg_402_1.talkMaxDuration)

			if var_405_2 <= arg_402_1.time_ and arg_402_1.time_ < var_405_2 + var_405_7 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_2) / var_405_7

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_2 + var_405_7 and arg_402_1.time_ < var_405_2 + var_405_7 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play115301100 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 115301100
		arg_406_1.duration_ = 10.1

		local var_406_0 = {
			ja = 10.1,
			ko = 8.066,
			zh = 5.833,
			en = 5.466
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play115301101(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.var_.moveOldPos10030 = arg_406_1.actors_["10030"].transform.localPosition
				arg_406_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_406_1:CheckSpriteTmpPos("10030", 4)

				for iter_409_0 = 0, arg_406_1.actors_["10030"].transform.childCount - 1 do
					local var_409_0 = arg_406_1.actors_["10030"].transform:GetChild(iter_409_0)

					if var_409_0.name == "split_3" or not string.find(var_409_0.name, "split") then
						var_409_0.gameObject:SetActive(true)
					else
						var_409_0.gameObject:SetActive(false)
					end
				end
			end

			local var_409_1 = 0.001

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_1 then
				arg_406_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_406_1.time_ - 0) / var_409_1)
			end

			if arg_406_1.time_ >= 0 + var_409_1 and arg_406_1.time_ < 0 + var_409_1 + arg_409_0 then
				arg_406_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				local var_409_2 = arg_406_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_409_2 then
					arg_406_1.var_.alphaOldValue10030 = var_409_2.alpha
					arg_406_1.var_.characterEffect10030 = var_409_2
				end

				arg_406_1.var_.alphaOldValue10030 = 0
			end

			local var_409_3 = 0.333333333333333

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_3 then
				if arg_406_1.var_.characterEffect10030 then
					arg_406_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_406_1.var_.alphaOldValue10030, 1, (arg_406_1.time_ - 0) / var_409_3)
				end
			end

			if arg_406_1.time_ >= 0 + var_409_3 and arg_406_1.time_ < 0 + var_409_3 + arg_409_0 and arg_406_1.var_.characterEffect10030 then
				arg_406_1.var_.characterEffect10030.alpha = 1
			end

			local var_409_4 = 0
			local var_409_5 = 0.6

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_4 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_6 = arg_406_1:GetWordFromCfg(115301100)
				local var_409_7 = arg_406_1:FormatText(var_409_6.content)

				arg_406_1.text_.text = var_409_7

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_9 = 24 <= 0 and var_409_5 or var_409_5 * (utf8.len(var_409_7) / 24)

				if (24 <= 0 and var_409_5 or var_409_5 * (utf8.len(var_409_7) / 24)) > 0 and var_409_5 < var_409_9 then
					arg_406_1.talkMaxDuration = var_409_9

					if var_409_9 + var_409_4 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_9 + var_409_4
					end
				end

				arg_406_1.text_.text = var_409_7
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301100", "story_v_out_115301.awb") ~= 0 then
					local var_409_10 = manager.audio:GetVoiceLength("story_v_out_115301", "115301100", "story_v_out_115301.awb") / 1000

					if var_409_10 + var_409_4 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_10 + var_409_4
					end

					if var_409_6.prefab_name ~= "" and arg_406_1.actors_[var_409_6.prefab_name] ~= nil then
						local var_409_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_6.prefab_name].transform, "story_v_out_115301", "115301100", "story_v_out_115301.awb")

						arg_406_1:RecordAudio("115301100", var_409_11)
						arg_406_1:RecordAudio("115301100", var_409_11)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_115301", "115301100", "story_v_out_115301.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_115301", "115301100", "story_v_out_115301.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_12 = math.max(var_409_5, arg_406_1.talkMaxDuration)

			if var_409_4 <= arg_406_1.time_ and arg_406_1.time_ < var_409_4 + var_409_12 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_4) / var_409_12

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_4 + var_409_12 and arg_406_1.time_ < var_409_4 + var_409_12 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_406_1:InitPlayNodeList()
	end,
	Play115301101 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 115301101
		arg_410_1.duration_ = 9.93

		local var_410_0 = {
			ja = 8.566,
			ko = 6.8,
			zh = 9.933,
			en = 7.066
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play115301102(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.var_.moveOldPos1038 = arg_410_1.actors_["1038"].transform.localPosition
				arg_410_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_410_1:CheckSpriteTmpPos("1038", 2)

				for iter_413_0 = 0, arg_410_1.actors_["1038"].transform.childCount - 1 do
					local var_413_0 = arg_410_1.actors_["1038"].transform:GetChild(iter_413_0)

					if var_413_0.name == "split_1" or not string.find(var_413_0.name, "split") then
						var_413_0.gameObject:SetActive(true)
					else
						var_413_0.gameObject:SetActive(false)
					end
				end
			end

			local var_413_1 = 0.001

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_1 then
				arg_410_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_410_1.time_ - 0) / var_413_1)
			end

			if arg_410_1.time_ >= 0 + var_413_1 and arg_410_1.time_ < 0 + var_413_1 + arg_413_0 then
				arg_410_1.actors_["1038"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_413_2 = arg_410_1.actors_["10030"]

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 and not isNil(var_413_2) and arg_410_1.var_.actorSpriteComps10030 == nil then
				arg_410_1.var_.actorSpriteComps10030 = var_413_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_413_3 = 0.2

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_3 and not isNil(var_413_2) then
				if arg_410_1.var_.actorSpriteComps10030 then
					for iter_413_1, iter_413_2 in pairs(arg_410_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_413_2 then
							if arg_410_1.isInRecall_ then
								iter_413_2.color = Color.New(Mathf.Lerp(iter_413_2.color.r, arg_410_1.hightColor2.r, (arg_410_1.time_ - 0) / var_413_3), Mathf.Lerp(iter_413_2.color.g, arg_410_1.hightColor2.g, (arg_410_1.time_ - 0) / var_413_3), (Mathf.Lerp(iter_413_2.color.b, arg_410_1.hightColor2.b, (arg_410_1.time_ - 0) / var_413_3)))
							else
								local var_413_4 = Mathf.Lerp(iter_413_2.color.r, 0.5, (arg_410_1.time_ - 0) / var_413_3)

								iter_413_2.color = Color.New(var_413_4, var_413_4, var_413_4)
							end
						end
					end
				end
			end

			if arg_410_1.time_ >= 0 + var_413_3 and arg_410_1.time_ < 0 + var_413_3 + arg_413_0 and not isNil(var_413_2) and arg_410_1.var_.actorSpriteComps10030 then
				for iter_413_3, iter_413_4 in pairs(arg_410_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_413_4 then
						iter_413_4.color = arg_410_1.isInRecall_ and (arg_410_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_410_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				local var_413_5 = arg_410_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_413_5 then
					arg_410_1.var_.alphaOldValue1038 = var_413_5.alpha
					arg_410_1.var_.characterEffect1038 = var_413_5
				end

				arg_410_1.var_.alphaOldValue1038 = 0
			end

			local var_413_6 = 0.333333333333333

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_6 then
				if arg_410_1.var_.characterEffect1038 then
					arg_410_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_410_1.var_.alphaOldValue1038, 1, (arg_410_1.time_ - 0) / var_413_6)
				end
			end

			if arg_410_1.time_ >= 0 + var_413_6 and arg_410_1.time_ < 0 + var_413_6 + arg_413_0 and arg_410_1.var_.characterEffect1038 then
				arg_410_1.var_.characterEffect1038.alpha = 1
			end

			local var_413_7 = arg_410_1.actors_["1038"]

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 and not isNil(var_413_7) and arg_410_1.var_.actorSpriteComps1038 == nil then
				arg_410_1.var_.actorSpriteComps1038 = var_413_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_413_8 = 0.2

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_8 and not isNil(var_413_7) then
				if arg_410_1.var_.actorSpriteComps1038 then
					for iter_413_5, iter_413_6 in pairs(arg_410_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_413_6 then
							if arg_410_1.isInRecall_ then
								iter_413_6.color = Color.New(Mathf.Lerp(iter_413_6.color.r, arg_410_1.hightColor1.r, (arg_410_1.time_ - 0) / var_413_8), Mathf.Lerp(iter_413_6.color.g, arg_410_1.hightColor1.g, (arg_410_1.time_ - 0) / var_413_8), (Mathf.Lerp(iter_413_6.color.b, arg_410_1.hightColor1.b, (arg_410_1.time_ - 0) / var_413_8)))
							else
								local var_413_9 = Mathf.Lerp(iter_413_6.color.r, 1, (arg_410_1.time_ - 0) / var_413_8)

								iter_413_6.color = Color.New(var_413_9, var_413_9, var_413_9)
							end
						end
					end
				end
			end

			if arg_410_1.time_ >= 0 + var_413_8 and arg_410_1.time_ < 0 + var_413_8 + arg_413_0 and not isNil(var_413_7) and arg_410_1.var_.actorSpriteComps1038 then
				for iter_413_7, iter_413_8 in pairs(arg_410_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_413_8 then
						iter_413_8.color = arg_410_1.isInRecall_ and (arg_410_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_410_1.var_.actorSpriteComps1038 = nil
			end

			local var_413_10 = 0
			local var_413_11 = 0.725

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_10 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_12 = arg_410_1:GetWordFromCfg(115301101)
				local var_413_13 = arg_410_1:FormatText(var_413_12.content)

				arg_410_1.text_.text = var_413_13

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_15 = 29 <= 0 and var_413_11 or var_413_11 * (utf8.len(var_413_13) / 29)

				if (29 <= 0 and var_413_11 or var_413_11 * (utf8.len(var_413_13) / 29)) > 0 and var_413_11 < var_413_15 then
					arg_410_1.talkMaxDuration = var_413_15

					if var_413_15 + var_413_10 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_15 + var_413_10
					end
				end

				arg_410_1.text_.text = var_413_13
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301101", "story_v_out_115301.awb") ~= 0 then
					local var_413_16 = manager.audio:GetVoiceLength("story_v_out_115301", "115301101", "story_v_out_115301.awb") / 1000

					if var_413_16 + var_413_10 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_16 + var_413_10
					end

					if var_413_12.prefab_name ~= "" and arg_410_1.actors_[var_413_12.prefab_name] ~= nil then
						local var_413_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_12.prefab_name].transform, "story_v_out_115301", "115301101", "story_v_out_115301.awb")

						arg_410_1:RecordAudio("115301101", var_413_17)
						arg_410_1:RecordAudio("115301101", var_413_17)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_115301", "115301101", "story_v_out_115301.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_115301", "115301101", "story_v_out_115301.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_18 = math.max(var_413_11, arg_410_1.talkMaxDuration)

			if var_413_10 <= arg_410_1.time_ and arg_410_1.time_ < var_413_10 + var_413_18 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_10) / var_413_18

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_10 + var_413_18 and arg_410_1.time_ < var_413_10 + var_413_18 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_410_1:InitPlayNodeList()
	end,
	Play115301102 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 115301102
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play115301103(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 and not isNil(arg_414_1.actors_["1038"]) and arg_414_1.var_.actorSpriteComps1038 == nil then
				arg_414_1.var_.actorSpriteComps1038 = arg_414_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_417_0 = 0.2

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_0 and not isNil(arg_414_1.actors_["1038"]) then
				if arg_414_1.var_.actorSpriteComps1038 then
					for iter_417_0, iter_417_1 in pairs(arg_414_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_417_1 then
							if arg_414_1.isInRecall_ then
								iter_417_1.color = Color.New(Mathf.Lerp(iter_417_1.color.r, arg_414_1.hightColor2.r, (arg_414_1.time_ - 0) / var_417_0), Mathf.Lerp(iter_417_1.color.g, arg_414_1.hightColor2.g, (arg_414_1.time_ - 0) / var_417_0), (Mathf.Lerp(iter_417_1.color.b, arg_414_1.hightColor2.b, (arg_414_1.time_ - 0) / var_417_0)))
							else
								local var_417_1 = Mathf.Lerp(iter_417_1.color.r, 0.5, (arg_414_1.time_ - 0) / var_417_0)

								iter_417_1.color = Color.New(var_417_1, var_417_1, var_417_1)
							end
						end
					end
				end
			end

			if arg_414_1.time_ >= 0 + var_417_0 and arg_414_1.time_ < 0 + var_417_0 + arg_417_0 and not isNil(arg_414_1.actors_["1038"]) and arg_414_1.var_.actorSpriteComps1038 then
				for iter_417_2, iter_417_3 in pairs(arg_414_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_417_3 then
						iter_417_3.color = arg_414_1.isInRecall_ and (arg_414_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_414_1.var_.actorSpriteComps1038 = nil
			end

			local var_417_2 = 0
			local var_417_3 = 1

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_2 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, false)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_4 = arg_414_1:FormatText(arg_414_1:GetWordFromCfg(115301102).content)

				arg_414_1.text_.text = var_417_4

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_6 = 40 <= 0 and var_417_3 or var_417_3 * (utf8.len(var_417_4) / 40)

				if (40 <= 0 and var_417_3 or var_417_3 * (utf8.len(var_417_4) / 40)) > 0 and var_417_3 < var_417_6 then
					arg_414_1.talkMaxDuration = var_417_6

					if var_417_6 + var_417_2 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_6 + var_417_2
					end
				end

				arg_414_1.text_.text = var_417_4
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_7 = math.max(var_417_3, arg_414_1.talkMaxDuration)

			if var_417_2 <= arg_414_1.time_ and arg_414_1.time_ < var_417_2 + var_417_7 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_2) / var_417_7

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_2 + var_417_7 and arg_414_1.time_ < var_417_2 + var_417_7 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play115301103 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 115301103
		arg_418_1.duration_ = 19.8

		local var_418_0 = {
			ja = 12.733,
			ko = 13.8,
			zh = 13.8,
			en = 19.8
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play115301104(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(arg_418_1.actors_["1038"]) and arg_418_1.var_.actorSpriteComps1038 == nil then
				arg_418_1.var_.actorSpriteComps1038 = arg_418_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_421_0 = 0.2

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_0 and not isNil(arg_418_1.actors_["1038"]) then
				if arg_418_1.var_.actorSpriteComps1038 then
					for iter_421_0, iter_421_1 in pairs(arg_418_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_421_1 then
							if arg_418_1.isInRecall_ then
								iter_421_1.color = Color.New(Mathf.Lerp(iter_421_1.color.r, arg_418_1.hightColor1.r, (arg_418_1.time_ - 0) / var_421_0), Mathf.Lerp(iter_421_1.color.g, arg_418_1.hightColor1.g, (arg_418_1.time_ - 0) / var_421_0), (Mathf.Lerp(iter_421_1.color.b, arg_418_1.hightColor1.b, (arg_418_1.time_ - 0) / var_421_0)))
							else
								local var_421_1 = Mathf.Lerp(iter_421_1.color.r, 1, (arg_418_1.time_ - 0) / var_421_0)

								iter_421_1.color = Color.New(var_421_1, var_421_1, var_421_1)
							end
						end
					end
				end
			end

			if arg_418_1.time_ >= 0 + var_421_0 and arg_418_1.time_ < 0 + var_421_0 + arg_421_0 and not isNil(arg_418_1.actors_["1038"]) and arg_418_1.var_.actorSpriteComps1038 then
				for iter_421_2, iter_421_3 in pairs(arg_418_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_421_3 then
						iter_421_3.color = arg_418_1.isInRecall_ and (arg_418_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_418_1.var_.actorSpriteComps1038 = nil
			end

			local var_421_2 = 0
			local var_421_3 = 1.225

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_2 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_4 = arg_418_1:GetWordFromCfg(115301103)
				local var_421_5 = arg_418_1:FormatText(var_421_4.content)

				arg_418_1.text_.text = var_421_5

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_7 = 49 <= 0 and var_421_3 or var_421_3 * (utf8.len(var_421_5) / 49)

				if (49 <= 0 and var_421_3 or var_421_3 * (utf8.len(var_421_5) / 49)) > 0 and var_421_3 < var_421_7 then
					arg_418_1.talkMaxDuration = var_421_7

					if var_421_7 + var_421_2 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_7 + var_421_2
					end
				end

				arg_418_1.text_.text = var_421_5
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301103", "story_v_out_115301.awb") ~= 0 then
					local var_421_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301103", "story_v_out_115301.awb") / 1000

					if var_421_8 + var_421_2 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_8 + var_421_2
					end

					if var_421_4.prefab_name ~= "" and arg_418_1.actors_[var_421_4.prefab_name] ~= nil then
						local var_421_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_4.prefab_name].transform, "story_v_out_115301", "115301103", "story_v_out_115301.awb")

						arg_418_1:RecordAudio("115301103", var_421_9)
						arg_418_1:RecordAudio("115301103", var_421_9)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_115301", "115301103", "story_v_out_115301.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_115301", "115301103", "story_v_out_115301.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_10 = math.max(var_421_3, arg_418_1.talkMaxDuration)

			if var_421_2 <= arg_418_1.time_ and arg_418_1.time_ < var_421_2 + var_421_10 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_2) / var_421_10

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_2 + var_421_10 and arg_418_1.time_ < var_421_2 + var_421_10 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play115301104 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 115301104
		arg_422_1.duration_ = 13.8

		local var_422_0 = {
			ja = 12.8,
			ko = 9.666,
			zh = 11.2,
			en = 13.8
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play115301105(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = 1.075

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_1 = arg_422_1:GetWordFromCfg(115301104)
				local var_425_2 = arg_422_1:FormatText(var_425_1.content)

				arg_422_1.text_.text = var_425_2

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_4 = 43 <= 0 and var_425_0 or var_425_0 * (utf8.len(var_425_2) / 43)

				if (43 <= 0 and var_425_0 or var_425_0 * (utf8.len(var_425_2) / 43)) > 0 and var_425_0 < var_425_4 then
					arg_422_1.talkMaxDuration = var_425_4

					if var_425_4 + 0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_4 + 0
					end
				end

				arg_422_1.text_.text = var_425_2
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301104", "story_v_out_115301.awb") ~= 0 then
					local var_425_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301104", "story_v_out_115301.awb") / 1000

					if var_425_5 + 0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_5 + 0
					end

					if var_425_1.prefab_name ~= "" and arg_422_1.actors_[var_425_1.prefab_name] ~= nil then
						local var_425_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_1.prefab_name].transform, "story_v_out_115301", "115301104", "story_v_out_115301.awb")

						arg_422_1:RecordAudio("115301104", var_425_6)
						arg_422_1:RecordAudio("115301104", var_425_6)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_115301", "115301104", "story_v_out_115301.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_115301", "115301104", "story_v_out_115301.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_7 = math.max(var_425_0, arg_422_1.talkMaxDuration)

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_7 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - 0) / var_425_7

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= 0 + var_425_7 and arg_422_1.time_ < 0 + var_425_7 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play115301105 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 115301105
		arg_426_1.duration_ = 18.5

		local var_426_0 = {
			ja = 14.033,
			ko = 17.466,
			zh = 18.5,
			en = 18
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play115301106(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 1.55

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_1 = arg_426_1:GetWordFromCfg(115301105)
				local var_429_2 = arg_426_1:FormatText(var_429_1.content)

				arg_426_1.text_.text = var_429_2

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_4 = 62 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_2) / 62)

				if (62 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_2) / 62)) > 0 and var_429_0 < var_429_4 then
					arg_426_1.talkMaxDuration = var_429_4

					if var_429_4 + 0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_4 + 0
					end
				end

				arg_426_1.text_.text = var_429_2
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301105", "story_v_out_115301.awb") ~= 0 then
					local var_429_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301105", "story_v_out_115301.awb") / 1000

					if var_429_5 + 0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_5 + 0
					end

					if var_429_1.prefab_name ~= "" and arg_426_1.actors_[var_429_1.prefab_name] ~= nil then
						local var_429_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_1.prefab_name].transform, "story_v_out_115301", "115301105", "story_v_out_115301.awb")

						arg_426_1:RecordAudio("115301105", var_429_6)
						arg_426_1:RecordAudio("115301105", var_429_6)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_115301", "115301105", "story_v_out_115301.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_115301", "115301105", "story_v_out_115301.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_7 = math.max(var_429_0, arg_426_1.talkMaxDuration)

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_7 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - 0) / var_429_7

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= 0 + var_429_7 and arg_426_1.time_ < 0 + var_429_7 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play115301106 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 115301106
		arg_430_1.duration_ = 16.5

		local var_430_0 = {
			ja = 14.9,
			ko = 16.5,
			zh = 16.433,
			en = 13.3
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play115301107(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = 1.625

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_1 = arg_430_1:GetWordFromCfg(115301106)
				local var_433_2 = arg_430_1:FormatText(var_433_1.content)

				arg_430_1.text_.text = var_433_2

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_4 = 65 <= 0 and var_433_0 or var_433_0 * (utf8.len(var_433_2) / 65)

				if (65 <= 0 and var_433_0 or var_433_0 * (utf8.len(var_433_2) / 65)) > 0 and var_433_0 < var_433_4 then
					arg_430_1.talkMaxDuration = var_433_4

					if var_433_4 + 0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_4 + 0
					end
				end

				arg_430_1.text_.text = var_433_2
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301106", "story_v_out_115301.awb") ~= 0 then
					local var_433_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301106", "story_v_out_115301.awb") / 1000

					if var_433_5 + 0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_5 + 0
					end

					if var_433_1.prefab_name ~= "" and arg_430_1.actors_[var_433_1.prefab_name] ~= nil then
						local var_433_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_1.prefab_name].transform, "story_v_out_115301", "115301106", "story_v_out_115301.awb")

						arg_430_1:RecordAudio("115301106", var_433_6)
						arg_430_1:RecordAudio("115301106", var_433_6)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_115301", "115301106", "story_v_out_115301.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_115301", "115301106", "story_v_out_115301.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_7 = math.max(var_433_0, arg_430_1.talkMaxDuration)

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_7 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - 0) / var_433_7

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= 0 + var_433_7 and arg_430_1.time_ < 0 + var_433_7 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play115301107 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 115301107
		arg_434_1.duration_ = 7.23

		local var_434_0 = {
			ja = 7.233,
			ko = 5.2,
			zh = 6.166,
			en = 5.733
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play115301108(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0.625

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_1 = arg_434_1:GetWordFromCfg(115301107)
				local var_437_2 = arg_434_1:FormatText(var_437_1.content)

				arg_434_1.text_.text = var_437_2

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_4 = 25 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_2) / 25)

				if (25 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_2) / 25)) > 0 and var_437_0 < var_437_4 then
					arg_434_1.talkMaxDuration = var_437_4

					if var_437_4 + 0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_4 + 0
					end
				end

				arg_434_1.text_.text = var_437_2
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301107", "story_v_out_115301.awb") ~= 0 then
					local var_437_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301107", "story_v_out_115301.awb") / 1000

					if var_437_5 + 0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_5 + 0
					end

					if var_437_1.prefab_name ~= "" and arg_434_1.actors_[var_437_1.prefab_name] ~= nil then
						local var_437_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_1.prefab_name].transform, "story_v_out_115301", "115301107", "story_v_out_115301.awb")

						arg_434_1:RecordAudio("115301107", var_437_6)
						arg_434_1:RecordAudio("115301107", var_437_6)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_115301", "115301107", "story_v_out_115301.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_115301", "115301107", "story_v_out_115301.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_7 = math.max(var_437_0, arg_434_1.talkMaxDuration)

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_7 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - 0) / var_437_7

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= 0 + var_437_7 and arg_434_1.time_ < 0 + var_437_7 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play115301108 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 115301108
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play115301109(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 and not isNil(arg_438_1.actors_["1038"]) and arg_438_1.var_.actorSpriteComps1038 == nil then
				arg_438_1.var_.actorSpriteComps1038 = arg_438_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_441_0 = 0.2

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_0 and not isNil(arg_438_1.actors_["1038"]) then
				if arg_438_1.var_.actorSpriteComps1038 then
					for iter_441_0, iter_441_1 in pairs(arg_438_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_441_1 then
							if arg_438_1.isInRecall_ then
								iter_441_1.color = Color.New(Mathf.Lerp(iter_441_1.color.r, arg_438_1.hightColor2.r, (arg_438_1.time_ - 0) / var_441_0), Mathf.Lerp(iter_441_1.color.g, arg_438_1.hightColor2.g, (arg_438_1.time_ - 0) / var_441_0), (Mathf.Lerp(iter_441_1.color.b, arg_438_1.hightColor2.b, (arg_438_1.time_ - 0) / var_441_0)))
							else
								local var_441_1 = Mathf.Lerp(iter_441_1.color.r, 0.5, (arg_438_1.time_ - 0) / var_441_0)

								iter_441_1.color = Color.New(var_441_1, var_441_1, var_441_1)
							end
						end
					end
				end
			end

			if arg_438_1.time_ >= 0 + var_441_0 and arg_438_1.time_ < 0 + var_441_0 + arg_441_0 and not isNil(arg_438_1.actors_["1038"]) and arg_438_1.var_.actorSpriteComps1038 then
				for iter_441_2, iter_441_3 in pairs(arg_438_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_441_3 then
						iter_441_3.color = arg_438_1.isInRecall_ and (arg_438_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_438_1.var_.actorSpriteComps1038 = nil
			end

			local var_441_2 = 0
			local var_441_3 = 0.975

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_2 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, false)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_4 = arg_438_1:FormatText(arg_438_1:GetWordFromCfg(115301108).content)

				arg_438_1.text_.text = var_441_4

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_6 = 39 <= 0 and var_441_3 or var_441_3 * (utf8.len(var_441_4) / 39)

				if (39 <= 0 and var_441_3 or var_441_3 * (utf8.len(var_441_4) / 39)) > 0 and var_441_3 < var_441_6 then
					arg_438_1.talkMaxDuration = var_441_6

					if var_441_6 + var_441_2 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_6 + var_441_2
					end
				end

				arg_438_1.text_.text = var_441_4
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_7 = math.max(var_441_3, arg_438_1.talkMaxDuration)

			if var_441_2 <= arg_438_1.time_ and arg_438_1.time_ < var_441_2 + var_441_7 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_2) / var_441_7

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_2 + var_441_7 and arg_438_1.time_ < var_441_2 + var_441_7 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play115301109 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 115301109
		arg_442_1.duration_ = 6.4

		local var_442_0 = {
			ja = 6.4,
			ko = 4.633,
			zh = 6.133,
			en = 4.066
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play115301110(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 and not isNil(arg_442_1.actors_["1038"]) and arg_442_1.var_.actorSpriteComps1038 == nil then
				arg_442_1.var_.actorSpriteComps1038 = arg_442_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_445_0 = 0.2

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_0 and not isNil(arg_442_1.actors_["1038"]) then
				if arg_442_1.var_.actorSpriteComps1038 then
					for iter_445_0, iter_445_1 in pairs(arg_442_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_445_1 then
							if arg_442_1.isInRecall_ then
								iter_445_1.color = Color.New(Mathf.Lerp(iter_445_1.color.r, arg_442_1.hightColor1.r, (arg_442_1.time_ - 0) / var_445_0), Mathf.Lerp(iter_445_1.color.g, arg_442_1.hightColor1.g, (arg_442_1.time_ - 0) / var_445_0), (Mathf.Lerp(iter_445_1.color.b, arg_442_1.hightColor1.b, (arg_442_1.time_ - 0) / var_445_0)))
							else
								local var_445_1 = Mathf.Lerp(iter_445_1.color.r, 1, (arg_442_1.time_ - 0) / var_445_0)

								iter_445_1.color = Color.New(var_445_1, var_445_1, var_445_1)
							end
						end
					end
				end
			end

			if arg_442_1.time_ >= 0 + var_445_0 and arg_442_1.time_ < 0 + var_445_0 + arg_445_0 and not isNil(arg_442_1.actors_["1038"]) and arg_442_1.var_.actorSpriteComps1038 then
				for iter_445_2, iter_445_3 in pairs(arg_442_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_445_3 then
						iter_445_3.color = arg_442_1.isInRecall_ and (arg_442_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_442_1.var_.actorSpriteComps1038 = nil
			end

			local var_445_2 = 0
			local var_445_3 = 0.525

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_2 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_4 = arg_442_1:GetWordFromCfg(115301109)
				local var_445_5 = arg_442_1:FormatText(var_445_4.content)

				arg_442_1.text_.text = var_445_5

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_7 = 21 <= 0 and var_445_3 or var_445_3 * (utf8.len(var_445_5) / 21)

				if (21 <= 0 and var_445_3 or var_445_3 * (utf8.len(var_445_5) / 21)) > 0 and var_445_3 < var_445_7 then
					arg_442_1.talkMaxDuration = var_445_7

					if var_445_7 + var_445_2 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_7 + var_445_2
					end
				end

				arg_442_1.text_.text = var_445_5
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301109", "story_v_out_115301.awb") ~= 0 then
					local var_445_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301109", "story_v_out_115301.awb") / 1000

					if var_445_8 + var_445_2 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_8 + var_445_2
					end

					if var_445_4.prefab_name ~= "" and arg_442_1.actors_[var_445_4.prefab_name] ~= nil then
						local var_445_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_4.prefab_name].transform, "story_v_out_115301", "115301109", "story_v_out_115301.awb")

						arg_442_1:RecordAudio("115301109", var_445_9)
						arg_442_1:RecordAudio("115301109", var_445_9)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_115301", "115301109", "story_v_out_115301.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_115301", "115301109", "story_v_out_115301.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_10 = math.max(var_445_3, arg_442_1.talkMaxDuration)

			if var_445_2 <= arg_442_1.time_ and arg_442_1.time_ < var_445_2 + var_445_10 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_2) / var_445_10

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_2 + var_445_10 and arg_442_1.time_ < var_445_2 + var_445_10 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play115301110 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 115301110
		arg_446_1.duration_ = 5

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play115301111(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				local var_449_0 = arg_446_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_449_0 then
					arg_446_1.var_.alphaOldValue1038 = var_449_0.alpha
					arg_446_1.var_.characterEffect1038 = var_449_0
				end

				arg_446_1.var_.alphaOldValue1038 = 1
			end

			local var_449_1 = 0.333333333333333

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_1 then
				if arg_446_1.var_.characterEffect1038 then
					arg_446_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_446_1.var_.alphaOldValue1038, 0, (arg_446_1.time_ - 0) / var_449_1)
				end
			end

			if arg_446_1.time_ >= 0 + var_449_1 and arg_446_1.time_ < 0 + var_449_1 + arg_449_0 and arg_446_1.var_.characterEffect1038 then
				arg_446_1.var_.characterEffect1038.alpha = 0
			end

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				local var_449_2 = arg_446_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_449_2 then
					arg_446_1.var_.alphaOldValue10030 = var_449_2.alpha
					arg_446_1.var_.characterEffect10030 = var_449_2
				end

				arg_446_1.var_.alphaOldValue10030 = 1
			end

			local var_449_3 = 0.333333333333333

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_3 then
				if arg_446_1.var_.characterEffect10030 then
					arg_446_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_446_1.var_.alphaOldValue10030, 0, (arg_446_1.time_ - 0) / var_449_3)
				end
			end

			if arg_446_1.time_ >= 0 + var_449_3 and arg_446_1.time_ < 0 + var_449_3 + arg_449_0 and arg_446_1.var_.characterEffect10030 then
				arg_446_1.var_.characterEffect10030.alpha = 0
			end

			local var_449_4 = 0
			local var_449_5 = 1.175

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_4 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, false)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_6 = arg_446_1:FormatText(arg_446_1:GetWordFromCfg(115301110).content)

				arg_446_1.text_.text = var_449_6

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_8 = 47 <= 0 and var_449_5 or var_449_5 * (utf8.len(var_449_6) / 47)

				if (47 <= 0 and var_449_5 or var_449_5 * (utf8.len(var_449_6) / 47)) > 0 and var_449_5 < var_449_8 then
					arg_446_1.talkMaxDuration = var_449_8

					if var_449_8 + var_449_4 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_8 + var_449_4
					end
				end

				arg_446_1.text_.text = var_449_6
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_9 = math.max(var_449_5, arg_446_1.talkMaxDuration)

			if var_449_4 <= arg_446_1.time_ and arg_446_1.time_ < var_449_4 + var_449_9 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_4) / var_449_9

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_4 + var_449_9 and arg_446_1.time_ < var_449_4 + var_449_9 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play115301111 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 115301111
		arg_450_1.duration_ = 5

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play115301112(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = 0.975

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, false)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_1 = arg_450_1:FormatText(arg_450_1:GetWordFromCfg(115301111).content)

				arg_450_1.text_.text = var_453_1

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_3 = 39 <= 0 and var_453_0 or var_453_0 * (utf8.len(var_453_1) / 39)

				if (39 <= 0 and var_453_0 or var_453_0 * (utf8.len(var_453_1) / 39)) > 0 and var_453_0 < var_453_3 then
					arg_450_1.talkMaxDuration = var_453_3

					if var_453_3 + 0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_3 + 0
					end
				end

				arg_450_1.text_.text = var_453_1
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)
				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_4 = math.max(var_453_0, arg_450_1.talkMaxDuration)

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_4 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - 0) / var_453_4

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= 0 + var_453_4 and arg_450_1.time_ < 0 + var_453_4 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play115301112 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 115301112
		arg_454_1.duration_ = 11.07

		local var_454_0 = {
			ja = 11.066,
			ko = 5.1,
			zh = 6,
			en = 4.666
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play115301113(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1.var_.moveOldPos10030 = arg_454_1.actors_["10030"].transform.localPosition
				arg_454_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_454_1:CheckSpriteTmpPos("10030", 3)

				for iter_457_0 = 0, arg_454_1.actors_["10030"].transform.childCount - 1 do
					local var_457_0 = arg_454_1.actors_["10030"].transform:GetChild(iter_457_0)

					if var_457_0.name == "split_3" or not string.find(var_457_0.name, "split") then
						var_457_0.gameObject:SetActive(true)
					else
						var_457_0.gameObject:SetActive(false)
					end
				end
			end

			local var_457_1 = 0.001

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_1 then
				arg_454_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_454_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_454_1.time_ - 0) / var_457_1)
			end

			if arg_454_1.time_ >= 0 + var_457_1 and arg_454_1.time_ < 0 + var_457_1 + arg_457_0 then
				arg_454_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			local var_457_2 = arg_454_1.actors_["10030"]

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 and not isNil(var_457_2) and arg_454_1.var_.actorSpriteComps10030 == nil then
				arg_454_1.var_.actorSpriteComps10030 = var_457_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_457_3 = 0.2

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_3 and not isNil(var_457_2) then
				if arg_454_1.var_.actorSpriteComps10030 then
					for iter_457_1, iter_457_2 in pairs(arg_454_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_457_2 then
							if arg_454_1.isInRecall_ then
								iter_457_2.color = Color.New(Mathf.Lerp(iter_457_2.color.r, arg_454_1.hightColor1.r, (arg_454_1.time_ - 0) / var_457_3), Mathf.Lerp(iter_457_2.color.g, arg_454_1.hightColor1.g, (arg_454_1.time_ - 0) / var_457_3), (Mathf.Lerp(iter_457_2.color.b, arg_454_1.hightColor1.b, (arg_454_1.time_ - 0) / var_457_3)))
							else
								local var_457_4 = Mathf.Lerp(iter_457_2.color.r, 1, (arg_454_1.time_ - 0) / var_457_3)

								iter_457_2.color = Color.New(var_457_4, var_457_4, var_457_4)
							end
						end
					end
				end
			end

			if arg_454_1.time_ >= 0 + var_457_3 and arg_454_1.time_ < 0 + var_457_3 + arg_457_0 and not isNil(var_457_2) and arg_454_1.var_.actorSpriteComps10030 then
				for iter_457_3, iter_457_4 in pairs(arg_454_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_457_4 then
						iter_457_4.color = arg_454_1.isInRecall_ and (arg_454_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_454_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				local var_457_5 = arg_454_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_457_5 then
					arg_454_1.var_.alphaOldValue10030 = var_457_5.alpha
					arg_454_1.var_.characterEffect10030 = var_457_5
				end

				arg_454_1.var_.alphaOldValue10030 = 0
			end

			local var_457_6 = 0.333333333333333

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_6 then
				if arg_454_1.var_.characterEffect10030 then
					arg_454_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_454_1.var_.alphaOldValue10030, 1, (arg_454_1.time_ - 0) / var_457_6)
				end
			end

			if arg_454_1.time_ >= 0 + var_457_6 and arg_454_1.time_ < 0 + var_457_6 + arg_457_0 and arg_454_1.var_.characterEffect10030 then
				arg_454_1.var_.characterEffect10030.alpha = 1
			end

			local var_457_7 = 0
			local var_457_8 = 0.3

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_7 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_9 = arg_454_1:GetWordFromCfg(115301112)
				local var_457_10 = arg_454_1:FormatText(var_457_9.content)

				arg_454_1.text_.text = var_457_10

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_12 = 12 <= 0 and var_457_8 or var_457_8 * (utf8.len(var_457_10) / 12)

				if (12 <= 0 and var_457_8 or var_457_8 * (utf8.len(var_457_10) / 12)) > 0 and var_457_8 < var_457_12 then
					arg_454_1.talkMaxDuration = var_457_12

					if var_457_12 + var_457_7 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_12 + var_457_7
					end
				end

				arg_454_1.text_.text = var_457_10
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301112", "story_v_out_115301.awb") ~= 0 then
					local var_457_13 = manager.audio:GetVoiceLength("story_v_out_115301", "115301112", "story_v_out_115301.awb") / 1000

					if var_457_13 + var_457_7 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_13 + var_457_7
					end

					if var_457_9.prefab_name ~= "" and arg_454_1.actors_[var_457_9.prefab_name] ~= nil then
						local var_457_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_9.prefab_name].transform, "story_v_out_115301", "115301112", "story_v_out_115301.awb")

						arg_454_1:RecordAudio("115301112", var_457_14)
						arg_454_1:RecordAudio("115301112", var_457_14)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_115301", "115301112", "story_v_out_115301.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_115301", "115301112", "story_v_out_115301.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_15 = math.max(var_457_8, arg_454_1.talkMaxDuration)

			if var_457_7 <= arg_454_1.time_ and arg_454_1.time_ < var_457_7 + var_457_15 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_7) / var_457_15

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_7 + var_457_15 and arg_454_1.time_ < var_457_7 + var_457_15 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_454_1:InitPlayNodeList()
	end,
	Play115301113 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 115301113
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play115301114(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				local var_461_0 = arg_458_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_461_0 then
					arg_458_1.var_.alphaOldValue10030 = var_461_0.alpha
					arg_458_1.var_.characterEffect10030 = var_461_0
				end

				arg_458_1.var_.alphaOldValue10030 = 1
			end

			local var_461_1 = 0.333333333333333

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_1 then
				if arg_458_1.var_.characterEffect10030 then
					arg_458_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_458_1.var_.alphaOldValue10030, 0, (arg_458_1.time_ - 0) / var_461_1)
				end
			end

			if arg_458_1.time_ >= 0 + var_461_1 and arg_458_1.time_ < 0 + var_461_1 + arg_461_0 and arg_458_1.var_.characterEffect10030 then
				arg_458_1.var_.characterEffect10030.alpha = 0
			end

			local var_461_2 = 0
			local var_461_3 = 0.725

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_2 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, false)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_4 = arg_458_1:FormatText(arg_458_1:GetWordFromCfg(115301113).content)

				arg_458_1.text_.text = var_461_4

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_6 = 29 <= 0 and var_461_3 or var_461_3 * (utf8.len(var_461_4) / 29)

				if (29 <= 0 and var_461_3 or var_461_3 * (utf8.len(var_461_4) / 29)) > 0 and var_461_3 < var_461_6 then
					arg_458_1.talkMaxDuration = var_461_6

					if var_461_6 + var_461_2 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_6 + var_461_2
					end
				end

				arg_458_1.text_.text = var_461_4
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_7 = math.max(var_461_3, arg_458_1.talkMaxDuration)

			if var_461_2 <= arg_458_1.time_ and arg_458_1.time_ < var_461_2 + var_461_7 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_2) / var_461_7

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_2 + var_461_7 and arg_458_1.time_ < var_461_2 + var_461_7 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play115301114 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 115301114
		arg_462_1.duration_ = 14.83

		local var_462_0 = {
			ja = 14.833,
			ko = 11.566,
			zh = 7.533,
			en = 10.2
		}
		local var_462_1 = manager.audio:GetLocalizationFlag()

		if var_462_0[var_462_1] ~= nil then
			arg_462_1.duration_ = var_462_0[var_462_1]
		end

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play115301115(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1.var_.moveOldPos10030 = arg_462_1.actors_["10030"].transform.localPosition
				arg_462_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_462_1:CheckSpriteTmpPos("10030", 3)

				for iter_465_0 = 0, arg_462_1.actors_["10030"].transform.childCount - 1 do
					local var_465_0 = arg_462_1.actors_["10030"].transform:GetChild(iter_465_0)

					if var_465_0.name == "split_3" or not string.find(var_465_0.name, "split") then
						var_465_0.gameObject:SetActive(true)
					else
						var_465_0.gameObject:SetActive(false)
					end
				end
			end

			local var_465_1 = 0.001

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_1 then
				arg_462_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_462_1.time_ - 0) / var_465_1)
			end

			if arg_462_1.time_ >= 0 + var_465_1 and arg_462_1.time_ < 0 + var_465_1 + arg_465_0 then
				arg_462_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				local var_465_2 = arg_462_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_465_2 then
					arg_462_1.var_.alphaOldValue10030 = var_465_2.alpha
					arg_462_1.var_.characterEffect10030 = var_465_2
				end

				arg_462_1.var_.alphaOldValue10030 = 0
			end

			local var_465_3 = 0.333333333333333

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_3 then
				if arg_462_1.var_.characterEffect10030 then
					arg_462_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_462_1.var_.alphaOldValue10030, 1, (arg_462_1.time_ - 0) / var_465_3)
				end
			end

			if arg_462_1.time_ >= 0 + var_465_3 and arg_462_1.time_ < 0 + var_465_3 + arg_465_0 and arg_462_1.var_.characterEffect10030 then
				arg_462_1.var_.characterEffect10030.alpha = 1
			end

			local var_465_4 = 0
			local var_465_5 = 0.825

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_4 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				arg_462_1.leftNameTxt_.text = arg_462_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_6 = arg_462_1:GetWordFromCfg(115301114)
				local var_465_7 = arg_462_1:FormatText(var_465_6.content)

				arg_462_1.text_.text = var_465_7

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_9 = 33 <= 0 and var_465_5 or var_465_5 * (utf8.len(var_465_7) / 33)

				if (33 <= 0 and var_465_5 or var_465_5 * (utf8.len(var_465_7) / 33)) > 0 and var_465_5 < var_465_9 then
					arg_462_1.talkMaxDuration = var_465_9

					if var_465_9 + var_465_4 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_9 + var_465_4
					end
				end

				arg_462_1.text_.text = var_465_7
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301114", "story_v_out_115301.awb") ~= 0 then
					local var_465_10 = manager.audio:GetVoiceLength("story_v_out_115301", "115301114", "story_v_out_115301.awb") / 1000

					if var_465_10 + var_465_4 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_10 + var_465_4
					end

					if var_465_6.prefab_name ~= "" and arg_462_1.actors_[var_465_6.prefab_name] ~= nil then
						local var_465_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_6.prefab_name].transform, "story_v_out_115301", "115301114", "story_v_out_115301.awb")

						arg_462_1:RecordAudio("115301114", var_465_11)
						arg_462_1:RecordAudio("115301114", var_465_11)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_out_115301", "115301114", "story_v_out_115301.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_out_115301", "115301114", "story_v_out_115301.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_12 = math.max(var_465_5, arg_462_1.talkMaxDuration)

			if var_465_4 <= arg_462_1.time_ and arg_462_1.time_ < var_465_4 + var_465_12 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_4) / var_465_12

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_4 + var_465_12 and arg_462_1.time_ < var_465_4 + var_465_12 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_462_1:InitPlayNodeList()
	end,
	Play115301115 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 115301115
		arg_466_1.duration_ = 12.23

		local var_466_0 = {
			ja = 6.066,
			ko = 9.933,
			zh = 8.966,
			en = 12.233
		}
		local var_466_1 = manager.audio:GetLocalizationFlag()

		if var_466_0[var_466_1] ~= nil then
			arg_466_1.duration_ = var_466_0[var_466_1]
		end

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play115301116(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = 1

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				arg_466_1.leftNameTxt_.text = arg_466_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_1 = arg_466_1:GetWordFromCfg(115301115)
				local var_469_2 = arg_466_1:FormatText(var_469_1.content)

				arg_466_1.text_.text = var_469_2

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_4 = 40 <= 0 and var_469_0 or var_469_0 * (utf8.len(var_469_2) / 40)

				if (40 <= 0 and var_469_0 or var_469_0 * (utf8.len(var_469_2) / 40)) > 0 and var_469_0 < var_469_4 then
					arg_466_1.talkMaxDuration = var_469_4

					if var_469_4 + 0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_4 + 0
					end
				end

				arg_466_1.text_.text = var_469_2
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301115", "story_v_out_115301.awb") ~= 0 then
					local var_469_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301115", "story_v_out_115301.awb") / 1000

					if var_469_5 + 0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_5 + 0
					end

					if var_469_1.prefab_name ~= "" and arg_466_1.actors_[var_469_1.prefab_name] ~= nil then
						local var_469_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_1.prefab_name].transform, "story_v_out_115301", "115301115", "story_v_out_115301.awb")

						arg_466_1:RecordAudio("115301115", var_469_6)
						arg_466_1:RecordAudio("115301115", var_469_6)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_115301", "115301115", "story_v_out_115301.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_115301", "115301115", "story_v_out_115301.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_7 = math.max(var_469_0, arg_466_1.talkMaxDuration)

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_7 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - 0) / var_469_7

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= 0 + var_469_7 and arg_466_1.time_ < 0 + var_469_7 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play115301116 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 115301116
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play115301117(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				local var_473_0 = arg_470_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_473_0 then
					arg_470_1.var_.alphaOldValue10030 = var_473_0.alpha
					arg_470_1.var_.characterEffect10030 = var_473_0
				end

				arg_470_1.var_.alphaOldValue10030 = 1
			end

			local var_473_1 = 0.333333333333333

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_1 then
				if arg_470_1.var_.characterEffect10030 then
					arg_470_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_470_1.var_.alphaOldValue10030, 0, (arg_470_1.time_ - 0) / var_473_1)
				end
			end

			if arg_470_1.time_ >= 0 + var_473_1 and arg_470_1.time_ < 0 + var_473_1 + arg_473_0 and arg_470_1.var_.characterEffect10030 then
				arg_470_1.var_.characterEffect10030.alpha = 0
			end

			local var_473_2 = 0
			local var_473_3 = 1.25

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_2 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, false)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_4 = arg_470_1:FormatText(arg_470_1:GetWordFromCfg(115301116).content)

				arg_470_1.text_.text = var_473_4

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_6 = 50 <= 0 and var_473_3 or var_473_3 * (utf8.len(var_473_4) / 50)

				if (50 <= 0 and var_473_3 or var_473_3 * (utf8.len(var_473_4) / 50)) > 0 and var_473_3 < var_473_6 then
					arg_470_1.talkMaxDuration = var_473_6

					if var_473_6 + var_473_2 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_6 + var_473_2
					end
				end

				arg_470_1.text_.text = var_473_4
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_7 = math.max(var_473_3, arg_470_1.talkMaxDuration)

			if var_473_2 <= arg_470_1.time_ and arg_470_1.time_ < var_473_2 + var_473_7 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_2) / var_473_7

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_2 + var_473_7 and arg_470_1.time_ < var_473_2 + var_473_7 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play115301117 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 115301117
		arg_474_1.duration_ = 3.23

		local var_474_0 = {
			ja = 3.166,
			ko = 3.233,
			zh = 3.1,
			en = 3.033
		}
		local var_474_1 = manager.audio:GetLocalizationFlag()

		if var_474_0[var_474_1] ~= nil then
			arg_474_1.duration_ = var_474_0[var_474_1]
		end

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play115301118(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1.var_.moveOldPos10030 = arg_474_1.actors_["10030"].transform.localPosition
				arg_474_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_474_1:CheckSpriteTmpPos("10030", 4)

				for iter_477_0 = 0, arg_474_1.actors_["10030"].transform.childCount - 1 do
					local var_477_0 = arg_474_1.actors_["10030"].transform:GetChild(iter_477_0)

					if var_477_0.name == "split_2" or not string.find(var_477_0.name, "split") then
						var_477_0.gameObject:SetActive(true)
					else
						var_477_0.gameObject:SetActive(false)
					end
				end
			end

			local var_477_1 = 0.001

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_1 then
				arg_474_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_474_1.time_ - 0) / var_477_1)
			end

			if arg_474_1.time_ >= 0 + var_477_1 and arg_474_1.time_ < 0 + var_477_1 + arg_477_0 then
				arg_474_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				local var_477_2 = arg_474_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_477_2 then
					arg_474_1.var_.alphaOldValue10030 = var_477_2.alpha
					arg_474_1.var_.characterEffect10030 = var_477_2
				end

				arg_474_1.var_.alphaOldValue10030 = 0
			end

			local var_477_3 = 0.333333333333333

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_3 then
				if arg_474_1.var_.characterEffect10030 then
					arg_474_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_474_1.var_.alphaOldValue10030, 1, (arg_474_1.time_ - 0) / var_477_3)
				end
			end

			if arg_474_1.time_ >= 0 + var_477_3 and arg_474_1.time_ < 0 + var_477_3 + arg_477_0 and arg_474_1.var_.characterEffect10030 then
				arg_474_1.var_.characterEffect10030.alpha = 1
			end

			local var_477_4 = 0
			local var_477_5 = 0.275

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_4 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				arg_474_1.leftNameTxt_.text = arg_474_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_6 = arg_474_1:GetWordFromCfg(115301117)
				local var_477_7 = arg_474_1:FormatText(var_477_6.content)

				arg_474_1.text_.text = var_477_7

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_9 = 11 <= 0 and var_477_5 or var_477_5 * (utf8.len(var_477_7) / 11)

				if (11 <= 0 and var_477_5 or var_477_5 * (utf8.len(var_477_7) / 11)) > 0 and var_477_5 < var_477_9 then
					arg_474_1.talkMaxDuration = var_477_9

					if var_477_9 + var_477_4 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_9 + var_477_4
					end
				end

				arg_474_1.text_.text = var_477_7
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301117", "story_v_out_115301.awb") ~= 0 then
					local var_477_10 = manager.audio:GetVoiceLength("story_v_out_115301", "115301117", "story_v_out_115301.awb") / 1000

					if var_477_10 + var_477_4 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_10 + var_477_4
					end

					if var_477_6.prefab_name ~= "" and arg_474_1.actors_[var_477_6.prefab_name] ~= nil then
						local var_477_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_6.prefab_name].transform, "story_v_out_115301", "115301117", "story_v_out_115301.awb")

						arg_474_1:RecordAudio("115301117", var_477_11)
						arg_474_1:RecordAudio("115301117", var_477_11)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_out_115301", "115301117", "story_v_out_115301.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_out_115301", "115301117", "story_v_out_115301.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_12 = math.max(var_477_5, arg_474_1.talkMaxDuration)

			if var_477_4 <= arg_474_1.time_ and arg_474_1.time_ < var_477_4 + var_477_12 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_4) / var_477_12

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_4 + var_477_12 and arg_474_1.time_ < var_477_4 + var_477_12 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_474_1:InitPlayNodeList()
	end,
	Play115301118 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 115301118
		arg_478_1.duration_ = 2.2

		local var_478_0 = {
			ja = 2.133,
			ko = 1.333,
			zh = 2.2,
			en = 1.4
		}
		local var_478_1 = manager.audio:GetLocalizationFlag()

		if var_478_0[var_478_1] ~= nil then
			arg_478_1.duration_ = var_478_0[var_478_1]
		end

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play115301119(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1.var_.moveOldPos1038 = arg_478_1.actors_["1038"].transform.localPosition
				arg_478_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_478_1:CheckSpriteTmpPos("1038", 2)

				for iter_481_0 = 0, arg_478_1.actors_["1038"].transform.childCount - 1 do
					local var_481_0 = arg_478_1.actors_["1038"].transform:GetChild(iter_481_0)

					if var_481_0.name == "split_1" or not string.find(var_481_0.name, "split") then
						var_481_0.gameObject:SetActive(true)
					else
						var_481_0.gameObject:SetActive(false)
					end
				end
			end

			local var_481_1 = 0.001

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_1 then
				arg_478_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_478_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_478_1.time_ - 0) / var_481_1)
			end

			if arg_478_1.time_ >= 0 + var_481_1 and arg_478_1.time_ < 0 + var_481_1 + arg_481_0 then
				arg_478_1.actors_["1038"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_481_2 = arg_478_1.actors_["10030"]

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 and not isNil(var_481_2) and arg_478_1.var_.actorSpriteComps10030 == nil then
				arg_478_1.var_.actorSpriteComps10030 = var_481_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_481_3 = 0.2

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_3 and not isNil(var_481_2) then
				if arg_478_1.var_.actorSpriteComps10030 then
					for iter_481_1, iter_481_2 in pairs(arg_478_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_481_2 then
							if arg_478_1.isInRecall_ then
								iter_481_2.color = Color.New(Mathf.Lerp(iter_481_2.color.r, arg_478_1.hightColor2.r, (arg_478_1.time_ - 0) / var_481_3), Mathf.Lerp(iter_481_2.color.g, arg_478_1.hightColor2.g, (arg_478_1.time_ - 0) / var_481_3), (Mathf.Lerp(iter_481_2.color.b, arg_478_1.hightColor2.b, (arg_478_1.time_ - 0) / var_481_3)))
							else
								local var_481_4 = Mathf.Lerp(iter_481_2.color.r, 0.5, (arg_478_1.time_ - 0) / var_481_3)

								iter_481_2.color = Color.New(var_481_4, var_481_4, var_481_4)
							end
						end
					end
				end
			end

			if arg_478_1.time_ >= 0 + var_481_3 and arg_478_1.time_ < 0 + var_481_3 + arg_481_0 and not isNil(var_481_2) and arg_478_1.var_.actorSpriteComps10030 then
				for iter_481_3, iter_481_4 in pairs(arg_478_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_481_4 then
						iter_481_4.color = arg_478_1.isInRecall_ and (arg_478_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_478_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				local var_481_5 = arg_478_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_481_5 then
					arg_478_1.var_.alphaOldValue1038 = var_481_5.alpha
					arg_478_1.var_.characterEffect1038 = var_481_5
				end

				arg_478_1.var_.alphaOldValue1038 = 0
			end

			local var_481_6 = 0.333333333333333

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_6 then
				if arg_478_1.var_.characterEffect1038 then
					arg_478_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_478_1.var_.alphaOldValue1038, 1, (arg_478_1.time_ - 0) / var_481_6)
				end
			end

			if arg_478_1.time_ >= 0 + var_481_6 and arg_478_1.time_ < 0 + var_481_6 + arg_481_0 and arg_478_1.var_.characterEffect1038 then
				arg_478_1.var_.characterEffect1038.alpha = 1
			end

			local var_481_7 = arg_478_1.actors_["1038"]

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 and not isNil(var_481_7) and arg_478_1.var_.actorSpriteComps1038 == nil then
				arg_478_1.var_.actorSpriteComps1038 = var_481_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_481_8 = 0.2

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_8 and not isNil(var_481_7) then
				if arg_478_1.var_.actorSpriteComps1038 then
					for iter_481_5, iter_481_6 in pairs(arg_478_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_481_6 then
							if arg_478_1.isInRecall_ then
								iter_481_6.color = Color.New(Mathf.Lerp(iter_481_6.color.r, arg_478_1.hightColor1.r, (arg_478_1.time_ - 0) / var_481_8), Mathf.Lerp(iter_481_6.color.g, arg_478_1.hightColor1.g, (arg_478_1.time_ - 0) / var_481_8), (Mathf.Lerp(iter_481_6.color.b, arg_478_1.hightColor1.b, (arg_478_1.time_ - 0) / var_481_8)))
							else
								local var_481_9 = Mathf.Lerp(iter_481_6.color.r, 1, (arg_478_1.time_ - 0) / var_481_8)

								iter_481_6.color = Color.New(var_481_9, var_481_9, var_481_9)
							end
						end
					end
				end
			end

			if arg_478_1.time_ >= 0 + var_481_8 and arg_478_1.time_ < 0 + var_481_8 + arg_481_0 and not isNil(var_481_7) and arg_478_1.var_.actorSpriteComps1038 then
				for iter_481_7, iter_481_8 in pairs(arg_478_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_481_8 then
						iter_481_8.color = arg_478_1.isInRecall_ and (arg_478_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_478_1.var_.actorSpriteComps1038 = nil
			end

			local var_481_10 = 0
			local var_481_11 = 0.075

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_10 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				arg_478_1.leftNameTxt_.text = arg_478_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_12 = arg_478_1:GetWordFromCfg(115301118)
				local var_481_13 = arg_478_1:FormatText(var_481_12.content)

				arg_478_1.text_.text = var_481_13

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_15 = 3 <= 0 and var_481_11 or var_481_11 * (utf8.len(var_481_13) / 3)

				if (3 <= 0 and var_481_11 or var_481_11 * (utf8.len(var_481_13) / 3)) > 0 and var_481_11 < var_481_15 then
					arg_478_1.talkMaxDuration = var_481_15

					if var_481_15 + var_481_10 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_15 + var_481_10
					end
				end

				arg_478_1.text_.text = var_481_13
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301118", "story_v_out_115301.awb") ~= 0 then
					local var_481_16 = manager.audio:GetVoiceLength("story_v_out_115301", "115301118", "story_v_out_115301.awb") / 1000

					if var_481_16 + var_481_10 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_16 + var_481_10
					end

					if var_481_12.prefab_name ~= "" and arg_478_1.actors_[var_481_12.prefab_name] ~= nil then
						local var_481_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_12.prefab_name].transform, "story_v_out_115301", "115301118", "story_v_out_115301.awb")

						arg_478_1:RecordAudio("115301118", var_481_17)
						arg_478_1:RecordAudio("115301118", var_481_17)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_out_115301", "115301118", "story_v_out_115301.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_out_115301", "115301118", "story_v_out_115301.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_18 = math.max(var_481_11, arg_478_1.talkMaxDuration)

			if var_481_10 <= arg_478_1.time_ and arg_478_1.time_ < var_481_10 + var_481_18 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_10) / var_481_18

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_10 + var_481_18 and arg_478_1.time_ < var_481_10 + var_481_18 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_478_1:InitPlayNodeList()
	end,
	Play115301119 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 115301119
		arg_482_1.duration_ = 4

		local var_482_0 = {
			ja = 2.866,
			ko = 3.866,
			zh = 2.933,
			en = 4
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play115301120(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 and not isNil(arg_482_1.actors_["10030"]) and arg_482_1.var_.actorSpriteComps10030 == nil then
				arg_482_1.var_.actorSpriteComps10030 = arg_482_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_485_0 = 0.2

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_0 and not isNil(arg_482_1.actors_["10030"]) then
				if arg_482_1.var_.actorSpriteComps10030 then
					for iter_485_0, iter_485_1 in pairs(arg_482_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_485_1 then
							if arg_482_1.isInRecall_ then
								iter_485_1.color = Color.New(Mathf.Lerp(iter_485_1.color.r, arg_482_1.hightColor1.r, (arg_482_1.time_ - 0) / var_485_0), Mathf.Lerp(iter_485_1.color.g, arg_482_1.hightColor1.g, (arg_482_1.time_ - 0) / var_485_0), (Mathf.Lerp(iter_485_1.color.b, arg_482_1.hightColor1.b, (arg_482_1.time_ - 0) / var_485_0)))
							else
								local var_485_1 = Mathf.Lerp(iter_485_1.color.r, 1, (arg_482_1.time_ - 0) / var_485_0)

								iter_485_1.color = Color.New(var_485_1, var_485_1, var_485_1)
							end
						end
					end
				end
			end

			if arg_482_1.time_ >= 0 + var_485_0 and arg_482_1.time_ < 0 + var_485_0 + arg_485_0 and not isNil(arg_482_1.actors_["10030"]) and arg_482_1.var_.actorSpriteComps10030 then
				for iter_485_2, iter_485_3 in pairs(arg_482_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_485_3 then
						iter_485_3.color = arg_482_1.isInRecall_ and (arg_482_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_482_1.var_.actorSpriteComps10030 = nil
			end

			local var_485_2 = arg_482_1.actors_["1038"]

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 and not isNil(var_485_2) and arg_482_1.var_.actorSpriteComps1038 == nil then
				arg_482_1.var_.actorSpriteComps1038 = var_485_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_485_3 = 0.2

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_3 and not isNil(var_485_2) then
				if arg_482_1.var_.actorSpriteComps1038 then
					for iter_485_4, iter_485_5 in pairs(arg_482_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_485_5 then
							if arg_482_1.isInRecall_ then
								iter_485_5.color = Color.New(Mathf.Lerp(iter_485_5.color.r, arg_482_1.hightColor2.r, (arg_482_1.time_ - 0) / var_485_3), Mathf.Lerp(iter_485_5.color.g, arg_482_1.hightColor2.g, (arg_482_1.time_ - 0) / var_485_3), (Mathf.Lerp(iter_485_5.color.b, arg_482_1.hightColor2.b, (arg_482_1.time_ - 0) / var_485_3)))
							else
								local var_485_4 = Mathf.Lerp(iter_485_5.color.r, 0.5, (arg_482_1.time_ - 0) / var_485_3)

								iter_485_5.color = Color.New(var_485_4, var_485_4, var_485_4)
							end
						end
					end
				end
			end

			if arg_482_1.time_ >= 0 + var_485_3 and arg_482_1.time_ < 0 + var_485_3 + arg_485_0 and not isNil(var_485_2) and arg_482_1.var_.actorSpriteComps1038 then
				for iter_485_6, iter_485_7 in pairs(arg_482_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_485_7 then
						iter_485_7.color = arg_482_1.isInRecall_ and (arg_482_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_482_1.var_.actorSpriteComps1038 = nil
			end

			local var_485_5 = 0
			local var_485_6 = 0.25

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_5 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				arg_482_1.leftNameTxt_.text = arg_482_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_7 = arg_482_1:GetWordFromCfg(115301119)
				local var_485_8 = arg_482_1:FormatText(var_485_7.content)

				arg_482_1.text_.text = var_485_8

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_10 = 10 <= 0 and var_485_6 or var_485_6 * (utf8.len(var_485_8) / 10)

				if (10 <= 0 and var_485_6 or var_485_6 * (utf8.len(var_485_8) / 10)) > 0 and var_485_6 < var_485_10 then
					arg_482_1.talkMaxDuration = var_485_10

					if var_485_10 + var_485_5 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_10 + var_485_5
					end
				end

				arg_482_1.text_.text = var_485_8
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301119", "story_v_out_115301.awb") ~= 0 then
					local var_485_11 = manager.audio:GetVoiceLength("story_v_out_115301", "115301119", "story_v_out_115301.awb") / 1000

					if var_485_11 + var_485_5 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_11 + var_485_5
					end

					if var_485_7.prefab_name ~= "" and arg_482_1.actors_[var_485_7.prefab_name] ~= nil then
						local var_485_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_7.prefab_name].transform, "story_v_out_115301", "115301119", "story_v_out_115301.awb")

						arg_482_1:RecordAudio("115301119", var_485_12)
						arg_482_1:RecordAudio("115301119", var_485_12)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_115301", "115301119", "story_v_out_115301.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_115301", "115301119", "story_v_out_115301.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_13 = math.max(var_485_6, arg_482_1.talkMaxDuration)

			if var_485_5 <= arg_482_1.time_ and arg_482_1.time_ < var_485_5 + var_485_13 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_5) / var_485_13

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_5 + var_485_13 and arg_482_1.time_ < var_485_5 + var_485_13 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play115301120 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 115301120
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play115301121(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 and not isNil(arg_486_1.actors_["10030"]) and arg_486_1.var_.actorSpriteComps10030 == nil then
				arg_486_1.var_.actorSpriteComps10030 = arg_486_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_489_0 = 0.2

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_0 and not isNil(arg_486_1.actors_["10030"]) then
				if arg_486_1.var_.actorSpriteComps10030 then
					for iter_489_0, iter_489_1 in pairs(arg_486_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_489_1 then
							if arg_486_1.isInRecall_ then
								iter_489_1.color = Color.New(Mathf.Lerp(iter_489_1.color.r, arg_486_1.hightColor2.r, (arg_486_1.time_ - 0) / var_489_0), Mathf.Lerp(iter_489_1.color.g, arg_486_1.hightColor2.g, (arg_486_1.time_ - 0) / var_489_0), (Mathf.Lerp(iter_489_1.color.b, arg_486_1.hightColor2.b, (arg_486_1.time_ - 0) / var_489_0)))
							else
								local var_489_1 = Mathf.Lerp(iter_489_1.color.r, 0.5, (arg_486_1.time_ - 0) / var_489_0)

								iter_489_1.color = Color.New(var_489_1, var_489_1, var_489_1)
							end
						end
					end
				end
			end

			if arg_486_1.time_ >= 0 + var_489_0 and arg_486_1.time_ < 0 + var_489_0 + arg_489_0 and not isNil(arg_486_1.actors_["10030"]) and arg_486_1.var_.actorSpriteComps10030 then
				for iter_489_2, iter_489_3 in pairs(arg_486_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_489_3 then
						iter_489_3.color = arg_486_1.isInRecall_ and (arg_486_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_486_1.var_.actorSpriteComps10030 = nil
			end

			local var_489_2 = arg_486_1.actors_["1038"]

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 and not isNil(var_489_2) and arg_486_1.var_.actorSpriteComps1038 == nil then
				arg_486_1.var_.actorSpriteComps1038 = var_489_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_489_3 = 0.2

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_3 and not isNil(var_489_2) then
				if arg_486_1.var_.actorSpriteComps1038 then
					for iter_489_4, iter_489_5 in pairs(arg_486_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_489_5 then
							if arg_486_1.isInRecall_ then
								iter_489_5.color = Color.New(Mathf.Lerp(iter_489_5.color.r, arg_486_1.hightColor2.r, (arg_486_1.time_ - 0) / var_489_3), Mathf.Lerp(iter_489_5.color.g, arg_486_1.hightColor2.g, (arg_486_1.time_ - 0) / var_489_3), (Mathf.Lerp(iter_489_5.color.b, arg_486_1.hightColor2.b, (arg_486_1.time_ - 0) / var_489_3)))
							else
								local var_489_4 = Mathf.Lerp(iter_489_5.color.r, 0.5, (arg_486_1.time_ - 0) / var_489_3)

								iter_489_5.color = Color.New(var_489_4, var_489_4, var_489_4)
							end
						end
					end
				end
			end

			if arg_486_1.time_ >= 0 + var_489_3 and arg_486_1.time_ < 0 + var_489_3 + arg_489_0 and not isNil(var_489_2) and arg_486_1.var_.actorSpriteComps1038 then
				for iter_489_6, iter_489_7 in pairs(arg_486_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_489_7 then
						iter_489_7.color = arg_486_1.isInRecall_ and (arg_486_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_486_1.var_.actorSpriteComps1038 = nil
			end

			local var_489_5 = 0
			local var_489_6 = 0.65

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_5 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, false)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_7 = arg_486_1:FormatText(arg_486_1:GetWordFromCfg(115301120).content)

				arg_486_1.text_.text = var_489_7

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_9 = 26 <= 0 and var_489_6 or var_489_6 * (utf8.len(var_489_7) / 26)

				if (26 <= 0 and var_489_6 or var_489_6 * (utf8.len(var_489_7) / 26)) > 0 and var_489_6 < var_489_9 then
					arg_486_1.talkMaxDuration = var_489_9

					if var_489_9 + var_489_5 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_9 + var_489_5
					end
				end

				arg_486_1.text_.text = var_489_7
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_10 = math.max(var_489_6, arg_486_1.talkMaxDuration)

			if var_489_5 <= arg_486_1.time_ and arg_486_1.time_ < var_489_5 + var_489_10 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_5) / var_489_10

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_5 + var_489_10 and arg_486_1.time_ < var_489_5 + var_489_10 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play115301121 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 115301121
		arg_490_1.duration_ = 8.9

		local var_490_0 = {
			ja = 8.9,
			ko = 7.166,
			zh = 7.566,
			en = 5.766
		}
		local var_490_1 = manager.audio:GetLocalizationFlag()

		if var_490_0[var_490_1] ~= nil then
			arg_490_1.duration_ = var_490_0[var_490_1]
		end

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play115301122(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 and not isNil(arg_490_1.actors_["1038"]) and arg_490_1.var_.actorSpriteComps1038 == nil then
				arg_490_1.var_.actorSpriteComps1038 = arg_490_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_493_0 = 0.2

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_0 and not isNil(arg_490_1.actors_["1038"]) then
				if arg_490_1.var_.actorSpriteComps1038 then
					for iter_493_0, iter_493_1 in pairs(arg_490_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_493_1 then
							if arg_490_1.isInRecall_ then
								iter_493_1.color = Color.New(Mathf.Lerp(iter_493_1.color.r, arg_490_1.hightColor1.r, (arg_490_1.time_ - 0) / var_493_0), Mathf.Lerp(iter_493_1.color.g, arg_490_1.hightColor1.g, (arg_490_1.time_ - 0) / var_493_0), (Mathf.Lerp(iter_493_1.color.b, arg_490_1.hightColor1.b, (arg_490_1.time_ - 0) / var_493_0)))
							else
								local var_493_1 = Mathf.Lerp(iter_493_1.color.r, 1, (arg_490_1.time_ - 0) / var_493_0)

								iter_493_1.color = Color.New(var_493_1, var_493_1, var_493_1)
							end
						end
					end
				end
			end

			if arg_490_1.time_ >= 0 + var_493_0 and arg_490_1.time_ < 0 + var_493_0 + arg_493_0 and not isNil(arg_490_1.actors_["1038"]) and arg_490_1.var_.actorSpriteComps1038 then
				for iter_493_2, iter_493_3 in pairs(arg_490_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_493_3 then
						iter_493_3.color = arg_490_1.isInRecall_ and (arg_490_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_490_1.var_.actorSpriteComps1038 = nil
			end

			local var_493_2 = arg_490_1.actors_["1038"].transform

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1.var_.moveOldPos1038 = var_493_2.localPosition
				var_493_2.localScale = Vector3.New(1, 1, 1)

				arg_490_1:CheckSpriteTmpPos("1038", 2)

				for iter_493_4 = 0, var_493_2.childCount - 1 do
					local var_493_3 = var_493_2:GetChild(iter_493_4)

					if var_493_3.name == "split_9" or not string.find(var_493_3.name, "split") then
						var_493_3.gameObject:SetActive(true)
					else
						var_493_3.gameObject:SetActive(false)
					end
				end
			end

			local var_493_4 = 0.001

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_4 then
				var_493_2.localPosition = Vector3.Lerp(arg_490_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_490_1.time_ - 0) / var_493_4)
			end

			if arg_490_1.time_ >= 0 + var_493_4 and arg_490_1.time_ < 0 + var_493_4 + arg_493_0 then
				var_493_2.localPosition = Vector3.New(-390, -400, 0)
			end

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				local var_493_5 = arg_490_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_493_5 then
					arg_490_1.var_.alphaOldValue1038 = var_493_5.alpha
					arg_490_1.var_.characterEffect1038 = var_493_5
				end

				arg_490_1.var_.alphaOldValue1038 = 0
			end

			local var_493_6 = 0.0166666666666667

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_6 then
				if arg_490_1.var_.characterEffect1038 then
					arg_490_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_490_1.var_.alphaOldValue1038, 1, (arg_490_1.time_ - 0) / var_493_6)
				end
			end

			if arg_490_1.time_ >= 0 + var_493_6 and arg_490_1.time_ < 0 + var_493_6 + arg_493_0 and arg_490_1.var_.characterEffect1038 then
				arg_490_1.var_.characterEffect1038.alpha = 1
			end

			local var_493_7 = 0
			local var_493_8 = 0.7

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_7 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				arg_490_1.leftNameTxt_.text = arg_490_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_9 = arg_490_1:GetWordFromCfg(115301121)
				local var_493_10 = arg_490_1:FormatText(var_493_9.content)

				arg_490_1.text_.text = var_493_10

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_12 = 28 <= 0 and var_493_8 or var_493_8 * (utf8.len(var_493_10) / 28)

				if (28 <= 0 and var_493_8 or var_493_8 * (utf8.len(var_493_10) / 28)) > 0 and var_493_8 < var_493_12 then
					arg_490_1.talkMaxDuration = var_493_12

					if var_493_12 + var_493_7 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_12 + var_493_7
					end
				end

				arg_490_1.text_.text = var_493_10
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301121", "story_v_out_115301.awb") ~= 0 then
					local var_493_13 = manager.audio:GetVoiceLength("story_v_out_115301", "115301121", "story_v_out_115301.awb") / 1000

					if var_493_13 + var_493_7 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_13 + var_493_7
					end

					if var_493_9.prefab_name ~= "" and arg_490_1.actors_[var_493_9.prefab_name] ~= nil then
						local var_493_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_9.prefab_name].transform, "story_v_out_115301", "115301121", "story_v_out_115301.awb")

						arg_490_1:RecordAudio("115301121", var_493_14)
						arg_490_1:RecordAudio("115301121", var_493_14)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_out_115301", "115301121", "story_v_out_115301.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_out_115301", "115301121", "story_v_out_115301.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_15 = math.max(var_493_8, arg_490_1.talkMaxDuration)

			if var_493_7 <= arg_490_1.time_ and arg_490_1.time_ < var_493_7 + var_493_15 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_7) / var_493_15

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_7 + var_493_15 and arg_490_1.time_ < var_493_7 + var_493_15 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_490_1:InitPlayNodeList()
	end,
	Play115301122 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 115301122
		arg_494_1.duration_ = 4.27

		local var_494_0 = {
			ja = 4.266,
			ko = 3.466,
			zh = 3.3,
			en = 3.433
		}
		local var_494_1 = manager.audio:GetLocalizationFlag()

		if var_494_0[var_494_1] ~= nil then
			arg_494_1.duration_ = var_494_0[var_494_1]
		end

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play115301123(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 and not isNil(arg_494_1.actors_["1038"]) and arg_494_1.var_.actorSpriteComps1038 == nil then
				arg_494_1.var_.actorSpriteComps1038 = arg_494_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_497_0 = 0.2

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_0 and not isNil(arg_494_1.actors_["1038"]) then
				if arg_494_1.var_.actorSpriteComps1038 then
					for iter_497_0, iter_497_1 in pairs(arg_494_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_497_1 then
							if arg_494_1.isInRecall_ then
								iter_497_1.color = Color.New(Mathf.Lerp(iter_497_1.color.r, arg_494_1.hightColor2.r, (arg_494_1.time_ - 0) / var_497_0), Mathf.Lerp(iter_497_1.color.g, arg_494_1.hightColor2.g, (arg_494_1.time_ - 0) / var_497_0), (Mathf.Lerp(iter_497_1.color.b, arg_494_1.hightColor2.b, (arg_494_1.time_ - 0) / var_497_0)))
							else
								local var_497_1 = Mathf.Lerp(iter_497_1.color.r, 0.5, (arg_494_1.time_ - 0) / var_497_0)

								iter_497_1.color = Color.New(var_497_1, var_497_1, var_497_1)
							end
						end
					end
				end
			end

			if arg_494_1.time_ >= 0 + var_497_0 and arg_494_1.time_ < 0 + var_497_0 + arg_497_0 and not isNil(arg_494_1.actors_["1038"]) and arg_494_1.var_.actorSpriteComps1038 then
				for iter_497_2, iter_497_3 in pairs(arg_494_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_497_3 then
						iter_497_3.color = arg_494_1.isInRecall_ and (arg_494_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_494_1.var_.actorSpriteComps1038 = nil
			end

			local var_497_2 = arg_494_1.actors_["10030"]

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 and not isNil(var_497_2) and arg_494_1.var_.actorSpriteComps10030 == nil then
				arg_494_1.var_.actorSpriteComps10030 = var_497_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_497_3 = 0.2

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_3 and not isNil(var_497_2) then
				if arg_494_1.var_.actorSpriteComps10030 then
					for iter_497_4, iter_497_5 in pairs(arg_494_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_497_5 then
							if arg_494_1.isInRecall_ then
								iter_497_5.color = Color.New(Mathf.Lerp(iter_497_5.color.r, arg_494_1.hightColor1.r, (arg_494_1.time_ - 0) / var_497_3), Mathf.Lerp(iter_497_5.color.g, arg_494_1.hightColor1.g, (arg_494_1.time_ - 0) / var_497_3), (Mathf.Lerp(iter_497_5.color.b, arg_494_1.hightColor1.b, (arg_494_1.time_ - 0) / var_497_3)))
							else
								local var_497_4 = Mathf.Lerp(iter_497_5.color.r, 1, (arg_494_1.time_ - 0) / var_497_3)

								iter_497_5.color = Color.New(var_497_4, var_497_4, var_497_4)
							end
						end
					end
				end
			end

			if arg_494_1.time_ >= 0 + var_497_3 and arg_494_1.time_ < 0 + var_497_3 + arg_497_0 and not isNil(var_497_2) and arg_494_1.var_.actorSpriteComps10030 then
				for iter_497_6, iter_497_7 in pairs(arg_494_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_497_7 then
						iter_497_7.color = arg_494_1.isInRecall_ and (arg_494_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_494_1.var_.actorSpriteComps10030 = nil
			end

			local var_497_5 = 0
			local var_497_6 = 0.3

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_5 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				arg_494_1.leftNameTxt_.text = arg_494_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_7 = arg_494_1:GetWordFromCfg(115301122)
				local var_497_8 = arg_494_1:FormatText(var_497_7.content)

				arg_494_1.text_.text = var_497_8

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_10 = 12 <= 0 and var_497_6 or var_497_6 * (utf8.len(var_497_8) / 12)

				if (12 <= 0 and var_497_6 or var_497_6 * (utf8.len(var_497_8) / 12)) > 0 and var_497_6 < var_497_10 then
					arg_494_1.talkMaxDuration = var_497_10

					if var_497_10 + var_497_5 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_10 + var_497_5
					end
				end

				arg_494_1.text_.text = var_497_8
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301122", "story_v_out_115301.awb") ~= 0 then
					local var_497_11 = manager.audio:GetVoiceLength("story_v_out_115301", "115301122", "story_v_out_115301.awb") / 1000

					if var_497_11 + var_497_5 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_11 + var_497_5
					end

					if var_497_7.prefab_name ~= "" and arg_494_1.actors_[var_497_7.prefab_name] ~= nil then
						local var_497_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_7.prefab_name].transform, "story_v_out_115301", "115301122", "story_v_out_115301.awb")

						arg_494_1:RecordAudio("115301122", var_497_12)
						arg_494_1:RecordAudio("115301122", var_497_12)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_out_115301", "115301122", "story_v_out_115301.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_out_115301", "115301122", "story_v_out_115301.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_13 = math.max(var_497_6, arg_494_1.talkMaxDuration)

			if var_497_5 <= arg_494_1.time_ and arg_494_1.time_ < var_497_5 + var_497_13 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_5) / var_497_13

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_5 + var_497_13 and arg_494_1.time_ < var_497_5 + var_497_13 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play115301123 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 115301123
		arg_498_1.duration_ = 3.73

		local var_498_0 = {
			ja = 3.733,
			ko = 3.3,
			zh = 3.466,
			en = 3.1
		}
		local var_498_1 = manager.audio:GetLocalizationFlag()

		if var_498_0[var_498_1] ~= nil then
			arg_498_1.duration_ = var_498_0[var_498_1]
		end

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play115301124(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = 0.4

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				arg_498_1.leftNameTxt_.text = arg_498_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_1 = arg_498_1:GetWordFromCfg(115301123)
				local var_501_2 = arg_498_1:FormatText(var_501_1.content)

				arg_498_1.text_.text = var_501_2

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_4 = 16 <= 0 and var_501_0 or var_501_0 * (utf8.len(var_501_2) / 16)

				if (16 <= 0 and var_501_0 or var_501_0 * (utf8.len(var_501_2) / 16)) > 0 and var_501_0 < var_501_4 then
					arg_498_1.talkMaxDuration = var_501_4

					if var_501_4 + 0 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_4 + 0
					end
				end

				arg_498_1.text_.text = var_501_2
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301123", "story_v_out_115301.awb") ~= 0 then
					local var_501_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301123", "story_v_out_115301.awb") / 1000

					if var_501_5 + 0 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_5 + 0
					end

					if var_501_1.prefab_name ~= "" and arg_498_1.actors_[var_501_1.prefab_name] ~= nil then
						local var_501_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_1.prefab_name].transform, "story_v_out_115301", "115301123", "story_v_out_115301.awb")

						arg_498_1:RecordAudio("115301123", var_501_6)
						arg_498_1:RecordAudio("115301123", var_501_6)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_out_115301", "115301123", "story_v_out_115301.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_out_115301", "115301123", "story_v_out_115301.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_7 = math.max(var_501_0, arg_498_1.talkMaxDuration)

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_7 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - 0) / var_501_7

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= 0 + var_501_7 and arg_498_1.time_ < 0 + var_501_7 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play115301124 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 115301124
		arg_502_1.duration_ = 5

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play115301125(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				local var_505_0 = arg_502_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_505_0 then
					arg_502_1.var_.alphaOldValue10030 = var_505_0.alpha
					arg_502_1.var_.characterEffect10030 = var_505_0
				end

				arg_502_1.var_.alphaOldValue10030 = 1
			end

			local var_505_1 = 0.333333333333333

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_1 then
				if arg_502_1.var_.characterEffect10030 then
					arg_502_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_502_1.var_.alphaOldValue10030, 0, (arg_502_1.time_ - 0) / var_505_1)
				end
			end

			if arg_502_1.time_ >= 0 + var_505_1 and arg_502_1.time_ < 0 + var_505_1 + arg_505_0 and arg_502_1.var_.characterEffect10030 then
				arg_502_1.var_.characterEffect10030.alpha = 0
			end

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				local var_505_2 = arg_502_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_505_2 then
					arg_502_1.var_.alphaOldValue1038 = var_505_2.alpha
					arg_502_1.var_.characterEffect1038 = var_505_2
				end

				arg_502_1.var_.alphaOldValue1038 = 1
			end

			local var_505_3 = 0.333333333333333

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_3 then
				if arg_502_1.var_.characterEffect1038 then
					arg_502_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_502_1.var_.alphaOldValue1038, 0, (arg_502_1.time_ - 0) / var_505_3)
				end
			end

			if arg_502_1.time_ >= 0 + var_505_3 and arg_502_1.time_ < 0 + var_505_3 + arg_505_0 and arg_502_1.var_.characterEffect1038 then
				arg_502_1.var_.characterEffect1038.alpha = 0
			end

			local var_505_4 = 0
			local var_505_5 = 0.45

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_4 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, false)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_6 = arg_502_1:FormatText(arg_502_1:GetWordFromCfg(115301124).content)

				arg_502_1.text_.text = var_505_6

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_8 = 18 <= 0 and var_505_5 or var_505_5 * (utf8.len(var_505_6) / 18)

				if (18 <= 0 and var_505_5 or var_505_5 * (utf8.len(var_505_6) / 18)) > 0 and var_505_5 < var_505_8 then
					arg_502_1.talkMaxDuration = var_505_8

					if var_505_8 + var_505_4 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_8 + var_505_4
					end
				end

				arg_502_1.text_.text = var_505_6
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)
				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_9 = math.max(var_505_5, arg_502_1.talkMaxDuration)

			if var_505_4 <= arg_502_1.time_ and arg_502_1.time_ < var_505_4 + var_505_9 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_4) / var_505_9

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_4 + var_505_9 and arg_502_1.time_ < var_505_4 + var_505_9 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play115301125 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 115301125
		arg_506_1.duration_ = 4.47

		local var_506_0 = {
			ja = 2.7,
			ko = 3.733,
			zh = 4.466,
			en = 4.2
		}
		local var_506_1 = manager.audio:GetLocalizationFlag()

		if var_506_0[var_506_1] ~= nil then
			arg_506_1.duration_ = var_506_0[var_506_1]
		end

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play115301126(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = 0.35

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				arg_506_1.leftNameTxt_.text = arg_506_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, true)
				arg_506_1.iconController_:SetSelectedState("hero")

				arg_506_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038_split_9")

				arg_506_1.callingController_:SetSelectedState("normal")

				arg_506_1.keyicon_.color = Color.New(1, 1, 1)
				arg_506_1.icon_.color = Color.New(1, 1, 1)

				local var_509_1 = arg_506_1:GetWordFromCfg(115301125)
				local var_509_2 = arg_506_1:FormatText(var_509_1.content)

				arg_506_1.text_.text = var_509_2

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_4 = 14 <= 0 and var_509_0 or var_509_0 * (utf8.len(var_509_2) / 14)

				if (14 <= 0 and var_509_0 or var_509_0 * (utf8.len(var_509_2) / 14)) > 0 and var_509_0 < var_509_4 then
					arg_506_1.talkMaxDuration = var_509_4

					if var_509_4 + 0 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_4 + 0
					end
				end

				arg_506_1.text_.text = var_509_2
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301125", "story_v_out_115301.awb") ~= 0 then
					local var_509_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301125", "story_v_out_115301.awb") / 1000

					if var_509_5 + 0 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_5 + 0
					end

					if var_509_1.prefab_name ~= "" and arg_506_1.actors_[var_509_1.prefab_name] ~= nil then
						local var_509_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_506_1.actors_[var_509_1.prefab_name].transform, "story_v_out_115301", "115301125", "story_v_out_115301.awb")

						arg_506_1:RecordAudio("115301125", var_509_6)
						arg_506_1:RecordAudio("115301125", var_509_6)
					else
						arg_506_1:AudioAction("play", "voice", "story_v_out_115301", "115301125", "story_v_out_115301.awb")
					end

					arg_506_1:RecordHistoryTalkVoice("story_v_out_115301", "115301125", "story_v_out_115301.awb")
				end

				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_7 = math.max(var_509_0, arg_506_1.talkMaxDuration)

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_7 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - 0) / var_509_7

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= 0 + var_509_7 and arg_506_1.time_ < 0 + var_509_7 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play115301126 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 115301126
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play115301127(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = 0.575

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, false)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_1 = arg_510_1:FormatText(arg_510_1:GetWordFromCfg(115301126).content)

				arg_510_1.text_.text = var_513_1

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_3 = 23 <= 0 and var_513_0 or var_513_0 * (utf8.len(var_513_1) / 23)

				if (23 <= 0 and var_513_0 or var_513_0 * (utf8.len(var_513_1) / 23)) > 0 and var_513_0 < var_513_3 then
					arg_510_1.talkMaxDuration = var_513_3

					if var_513_3 + 0 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_3 + 0
					end
				end

				arg_510_1.text_.text = var_513_1
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_4 = math.max(var_513_0, arg_510_1.talkMaxDuration)

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_4 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - 0) / var_513_4

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= 0 + var_513_4 and arg_510_1.time_ < 0 + var_513_4 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play115301127 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 115301127
		arg_514_1.duration_ = 4.57

		local var_514_0 = {
			ja = 2.433,
			ko = 2.833,
			zh = 4.566,
			en = 2.533
		}
		local var_514_1 = manager.audio:GetLocalizationFlag()

		if var_514_0[var_514_1] ~= nil then
			arg_514_1.duration_ = var_514_0[var_514_1]
		end

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play115301128(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1.var_.moveOldPos1038 = arg_514_1.actors_["1038"].transform.localPosition
				arg_514_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_514_1:CheckSpriteTmpPos("1038", 2)

				for iter_517_0 = 0, arg_514_1.actors_["1038"].transform.childCount - 1 do
					local var_517_0 = arg_514_1.actors_["1038"].transform:GetChild(iter_517_0)

					if var_517_0.name == "split_1" or not string.find(var_517_0.name, "split") then
						var_517_0.gameObject:SetActive(true)
					else
						var_517_0.gameObject:SetActive(false)
					end
				end
			end

			local var_517_1 = 0.001

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_1 then
				arg_514_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_514_1.time_ - 0) / var_517_1)
			end

			if arg_514_1.time_ >= 0 + var_517_1 and arg_514_1.time_ < 0 + var_517_1 + arg_517_0 then
				arg_514_1.actors_["1038"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_517_2 = arg_514_1.actors_["1038"]

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 and not isNil(var_517_2) and arg_514_1.var_.actorSpriteComps1038 == nil then
				arg_514_1.var_.actorSpriteComps1038 = var_517_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_517_3 = 0.2

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_3 and not isNil(var_517_2) then
				if arg_514_1.var_.actorSpriteComps1038 then
					for iter_517_1, iter_517_2 in pairs(arg_514_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_517_2 then
							if arg_514_1.isInRecall_ then
								iter_517_2.color = Color.New(Mathf.Lerp(iter_517_2.color.r, arg_514_1.hightColor1.r, (arg_514_1.time_ - 0) / var_517_3), Mathf.Lerp(iter_517_2.color.g, arg_514_1.hightColor1.g, (arg_514_1.time_ - 0) / var_517_3), (Mathf.Lerp(iter_517_2.color.b, arg_514_1.hightColor1.b, (arg_514_1.time_ - 0) / var_517_3)))
							else
								local var_517_4 = Mathf.Lerp(iter_517_2.color.r, 1, (arg_514_1.time_ - 0) / var_517_3)

								iter_517_2.color = Color.New(var_517_4, var_517_4, var_517_4)
							end
						end
					end
				end
			end

			if arg_514_1.time_ >= 0 + var_517_3 and arg_514_1.time_ < 0 + var_517_3 + arg_517_0 and not isNil(var_517_2) and arg_514_1.var_.actorSpriteComps1038 then
				for iter_517_3, iter_517_4 in pairs(arg_514_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_517_4 then
						iter_517_4.color = arg_514_1.isInRecall_ and (arg_514_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_514_1.var_.actorSpriteComps1038 = nil
			end

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				local var_517_5 = arg_514_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_517_5 then
					arg_514_1.var_.alphaOldValue1038 = var_517_5.alpha
					arg_514_1.var_.characterEffect1038 = var_517_5
				end

				arg_514_1.var_.alphaOldValue1038 = 0
			end

			local var_517_6 = 0.333333333333333

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_6 then
				if arg_514_1.var_.characterEffect1038 then
					arg_514_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_514_1.var_.alphaOldValue1038, 1, (arg_514_1.time_ - 0) / var_517_6)
				end
			end

			if arg_514_1.time_ >= 0 + var_517_6 and arg_514_1.time_ < 0 + var_517_6 + arg_517_0 and arg_514_1.var_.characterEffect1038 then
				arg_514_1.var_.characterEffect1038.alpha = 1
			end

			local var_517_7 = 0
			local var_517_8 = 0.4

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_7 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				arg_514_1.leftNameTxt_.text = arg_514_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_9 = arg_514_1:GetWordFromCfg(115301127)
				local var_517_10 = arg_514_1:FormatText(var_517_9.content)

				arg_514_1.text_.text = var_517_10

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_12 = 16 <= 0 and var_517_8 or var_517_8 * (utf8.len(var_517_10) / 16)

				if (16 <= 0 and var_517_8 or var_517_8 * (utf8.len(var_517_10) / 16)) > 0 and var_517_8 < var_517_12 then
					arg_514_1.talkMaxDuration = var_517_12

					if var_517_12 + var_517_7 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_12 + var_517_7
					end
				end

				arg_514_1.text_.text = var_517_10
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301127", "story_v_out_115301.awb") ~= 0 then
					local var_517_13 = manager.audio:GetVoiceLength("story_v_out_115301", "115301127", "story_v_out_115301.awb") / 1000

					if var_517_13 + var_517_7 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_13 + var_517_7
					end

					if var_517_9.prefab_name ~= "" and arg_514_1.actors_[var_517_9.prefab_name] ~= nil then
						local var_517_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_9.prefab_name].transform, "story_v_out_115301", "115301127", "story_v_out_115301.awb")

						arg_514_1:RecordAudio("115301127", var_517_14)
						arg_514_1:RecordAudio("115301127", var_517_14)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_out_115301", "115301127", "story_v_out_115301.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_out_115301", "115301127", "story_v_out_115301.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_15 = math.max(var_517_8, arg_514_1.talkMaxDuration)

			if var_517_7 <= arg_514_1.time_ and arg_514_1.time_ < var_517_7 + var_517_15 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_7) / var_517_15

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_7 + var_517_15 and arg_514_1.time_ < var_517_7 + var_517_15 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_514_1:InitPlayNodeList()
	end,
	Play115301128 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 115301128
		arg_518_1.duration_ = 7.23

		local var_518_0 = {
			ja = 5.3,
			ko = 6.7,
			zh = 5.433,
			en = 7.233
		}
		local var_518_1 = manager.audio:GetLocalizationFlag()

		if var_518_0[var_518_1] ~= nil then
			arg_518_1.duration_ = var_518_0[var_518_1]
		end

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play115301129(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1.var_.moveOldPos10030 = arg_518_1.actors_["10030"].transform.localPosition
				arg_518_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_518_1:CheckSpriteTmpPos("10030", 4)

				for iter_521_0 = 0, arg_518_1.actors_["10030"].transform.childCount - 1 do
					local var_521_0 = arg_518_1.actors_["10030"].transform:GetChild(iter_521_0)

					if var_521_0.name == "split_1" or not string.find(var_521_0.name, "split") then
						var_521_0.gameObject:SetActive(true)
					else
						var_521_0.gameObject:SetActive(false)
					end
				end
			end

			local var_521_1 = 0.001

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_1 then
				arg_518_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_518_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_518_1.time_ - 0) / var_521_1)
			end

			if arg_518_1.time_ >= 0 + var_521_1 and arg_518_1.time_ < 0 + var_521_1 + arg_521_0 then
				arg_518_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			local var_521_2 = arg_518_1.actors_["1038"]

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 and not isNil(var_521_2) and arg_518_1.var_.actorSpriteComps1038 == nil then
				arg_518_1.var_.actorSpriteComps1038 = var_521_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_521_3 = 0.2

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_3 and not isNil(var_521_2) then
				if arg_518_1.var_.actorSpriteComps1038 then
					for iter_521_1, iter_521_2 in pairs(arg_518_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_521_2 then
							if arg_518_1.isInRecall_ then
								iter_521_2.color = Color.New(Mathf.Lerp(iter_521_2.color.r, arg_518_1.hightColor2.r, (arg_518_1.time_ - 0) / var_521_3), Mathf.Lerp(iter_521_2.color.g, arg_518_1.hightColor2.g, (arg_518_1.time_ - 0) / var_521_3), (Mathf.Lerp(iter_521_2.color.b, arg_518_1.hightColor2.b, (arg_518_1.time_ - 0) / var_521_3)))
							else
								local var_521_4 = Mathf.Lerp(iter_521_2.color.r, 0.5, (arg_518_1.time_ - 0) / var_521_3)

								iter_521_2.color = Color.New(var_521_4, var_521_4, var_521_4)
							end
						end
					end
				end
			end

			if arg_518_1.time_ >= 0 + var_521_3 and arg_518_1.time_ < 0 + var_521_3 + arg_521_0 and not isNil(var_521_2) and arg_518_1.var_.actorSpriteComps1038 then
				for iter_521_3, iter_521_4 in pairs(arg_518_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_521_4 then
						iter_521_4.color = arg_518_1.isInRecall_ and (arg_518_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_518_1.var_.actorSpriteComps1038 = nil
			end

			local var_521_5 = arg_518_1.actors_["10030"]

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 and not isNil(var_521_5) and arg_518_1.var_.actorSpriteComps10030 == nil then
				arg_518_1.var_.actorSpriteComps10030 = var_521_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_521_6 = 0.2

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_6 and not isNil(var_521_5) then
				if arg_518_1.var_.actorSpriteComps10030 then
					for iter_521_5, iter_521_6 in pairs(arg_518_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_521_6 then
							if arg_518_1.isInRecall_ then
								iter_521_6.color = Color.New(Mathf.Lerp(iter_521_6.color.r, arg_518_1.hightColor1.r, (arg_518_1.time_ - 0) / var_521_6), Mathf.Lerp(iter_521_6.color.g, arg_518_1.hightColor1.g, (arg_518_1.time_ - 0) / var_521_6), (Mathf.Lerp(iter_521_6.color.b, arg_518_1.hightColor1.b, (arg_518_1.time_ - 0) / var_521_6)))
							else
								local var_521_7 = Mathf.Lerp(iter_521_6.color.r, 1, (arg_518_1.time_ - 0) / var_521_6)

								iter_521_6.color = Color.New(var_521_7, var_521_7, var_521_7)
							end
						end
					end
				end
			end

			if arg_518_1.time_ >= 0 + var_521_6 and arg_518_1.time_ < 0 + var_521_6 + arg_521_0 and not isNil(var_521_5) and arg_518_1.var_.actorSpriteComps10030 then
				for iter_521_7, iter_521_8 in pairs(arg_518_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_521_8 then
						iter_521_8.color = arg_518_1.isInRecall_ and (arg_518_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_518_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				local var_521_8 = arg_518_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_521_8 then
					arg_518_1.var_.alphaOldValue10030 = var_521_8.alpha
					arg_518_1.var_.characterEffect10030 = var_521_8
				end

				arg_518_1.var_.alphaOldValue10030 = 0
			end

			local var_521_9 = 0.333333333333333

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_9 then
				if arg_518_1.var_.characterEffect10030 then
					arg_518_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_518_1.var_.alphaOldValue10030, 1, (arg_518_1.time_ - 0) / var_521_9)
				end
			end

			if arg_518_1.time_ >= 0 + var_521_9 and arg_518_1.time_ < 0 + var_521_9 + arg_521_0 and arg_518_1.var_.characterEffect10030 then
				arg_518_1.var_.characterEffect10030.alpha = 1
			end

			local var_521_10 = 0
			local var_521_11 = 0.525

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_10 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				arg_518_1.leftNameTxt_.text = arg_518_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_12 = arg_518_1:GetWordFromCfg(115301128)
				local var_521_13 = arg_518_1:FormatText(var_521_12.content)

				arg_518_1.text_.text = var_521_13

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_15 = 21 <= 0 and var_521_11 or var_521_11 * (utf8.len(var_521_13) / 21)

				if (21 <= 0 and var_521_11 or var_521_11 * (utf8.len(var_521_13) / 21)) > 0 and var_521_11 < var_521_15 then
					arg_518_1.talkMaxDuration = var_521_15

					if var_521_15 + var_521_10 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_15 + var_521_10
					end
				end

				arg_518_1.text_.text = var_521_13
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301128", "story_v_out_115301.awb") ~= 0 then
					local var_521_16 = manager.audio:GetVoiceLength("story_v_out_115301", "115301128", "story_v_out_115301.awb") / 1000

					if var_521_16 + var_521_10 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_16 + var_521_10
					end

					if var_521_12.prefab_name ~= "" and arg_518_1.actors_[var_521_12.prefab_name] ~= nil then
						local var_521_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_12.prefab_name].transform, "story_v_out_115301", "115301128", "story_v_out_115301.awb")

						arg_518_1:RecordAudio("115301128", var_521_17)
						arg_518_1:RecordAudio("115301128", var_521_17)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_out_115301", "115301128", "story_v_out_115301.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_out_115301", "115301128", "story_v_out_115301.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_18 = math.max(var_521_11, arg_518_1.talkMaxDuration)

			if var_521_10 <= arg_518_1.time_ and arg_518_1.time_ < var_521_10 + var_521_18 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_10) / var_521_18

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_10 + var_521_18 and arg_518_1.time_ < var_521_10 + var_521_18 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_518_1:InitPlayNodeList()
	end,
	Play115301129 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 115301129
		arg_522_1.duration_ = 11.07

		local var_522_0 = {
			ja = 6.666,
			ko = 6.6,
			zh = 8.1,
			en = 11.066
		}
		local var_522_1 = manager.audio:GetLocalizationFlag()

		if var_522_0[var_522_1] ~= nil then
			arg_522_1.duration_ = var_522_0[var_522_1]
		end

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play115301130(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 and not isNil(arg_522_1.actors_["10030"]) and arg_522_1.var_.actorSpriteComps10030 == nil then
				arg_522_1.var_.actorSpriteComps10030 = arg_522_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_525_0 = 0.2

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_0 and not isNil(arg_522_1.actors_["10030"]) then
				if arg_522_1.var_.actorSpriteComps10030 then
					for iter_525_0, iter_525_1 in pairs(arg_522_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_525_1 then
							if arg_522_1.isInRecall_ then
								iter_525_1.color = Color.New(Mathf.Lerp(iter_525_1.color.r, arg_522_1.hightColor2.r, (arg_522_1.time_ - 0) / var_525_0), Mathf.Lerp(iter_525_1.color.g, arg_522_1.hightColor2.g, (arg_522_1.time_ - 0) / var_525_0), (Mathf.Lerp(iter_525_1.color.b, arg_522_1.hightColor2.b, (arg_522_1.time_ - 0) / var_525_0)))
							else
								local var_525_1 = Mathf.Lerp(iter_525_1.color.r, 0.5, (arg_522_1.time_ - 0) / var_525_0)

								iter_525_1.color = Color.New(var_525_1, var_525_1, var_525_1)
							end
						end
					end
				end
			end

			if arg_522_1.time_ >= 0 + var_525_0 and arg_522_1.time_ < 0 + var_525_0 + arg_525_0 and not isNil(arg_522_1.actors_["10030"]) and arg_522_1.var_.actorSpriteComps10030 then
				for iter_525_2, iter_525_3 in pairs(arg_522_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_525_3 then
						iter_525_3.color = arg_522_1.isInRecall_ and (arg_522_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_522_1.var_.actorSpriteComps10030 = nil
			end

			local var_525_2 = arg_522_1.actors_["1038"]

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 and not isNil(var_525_2) and arg_522_1.var_.actorSpriteComps1038 == nil then
				arg_522_1.var_.actorSpriteComps1038 = var_525_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_525_3 = 0.2

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_3 and not isNil(var_525_2) then
				if arg_522_1.var_.actorSpriteComps1038 then
					for iter_525_4, iter_525_5 in pairs(arg_522_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_525_5 then
							if arg_522_1.isInRecall_ then
								iter_525_5.color = Color.New(Mathf.Lerp(iter_525_5.color.r, arg_522_1.hightColor1.r, (arg_522_1.time_ - 0) / var_525_3), Mathf.Lerp(iter_525_5.color.g, arg_522_1.hightColor1.g, (arg_522_1.time_ - 0) / var_525_3), (Mathf.Lerp(iter_525_5.color.b, arg_522_1.hightColor1.b, (arg_522_1.time_ - 0) / var_525_3)))
							else
								local var_525_4 = Mathf.Lerp(iter_525_5.color.r, 1, (arg_522_1.time_ - 0) / var_525_3)

								iter_525_5.color = Color.New(var_525_4, var_525_4, var_525_4)
							end
						end
					end
				end
			end

			if arg_522_1.time_ >= 0 + var_525_3 and arg_522_1.time_ < 0 + var_525_3 + arg_525_0 and not isNil(var_525_2) and arg_522_1.var_.actorSpriteComps1038 then
				for iter_525_6, iter_525_7 in pairs(arg_522_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_525_7 then
						iter_525_7.color = arg_522_1.isInRecall_ and (arg_522_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_522_1.var_.actorSpriteComps1038 = nil
			end

			local var_525_5 = 0
			local var_525_6 = 0.75

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_5 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				arg_522_1.leftNameTxt_.text = arg_522_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_7 = arg_522_1:GetWordFromCfg(115301129)
				local var_525_8 = arg_522_1:FormatText(var_525_7.content)

				arg_522_1.text_.text = var_525_8

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_10 = 29 <= 0 and var_525_6 or var_525_6 * (utf8.len(var_525_8) / 29)

				if (29 <= 0 and var_525_6 or var_525_6 * (utf8.len(var_525_8) / 29)) > 0 and var_525_6 < var_525_10 then
					arg_522_1.talkMaxDuration = var_525_10

					if var_525_10 + var_525_5 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_10 + var_525_5
					end
				end

				arg_522_1.text_.text = var_525_8
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301129", "story_v_out_115301.awb") ~= 0 then
					local var_525_11 = manager.audio:GetVoiceLength("story_v_out_115301", "115301129", "story_v_out_115301.awb") / 1000

					if var_525_11 + var_525_5 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_11 + var_525_5
					end

					if var_525_7.prefab_name ~= "" and arg_522_1.actors_[var_525_7.prefab_name] ~= nil then
						local var_525_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_7.prefab_name].transform, "story_v_out_115301", "115301129", "story_v_out_115301.awb")

						arg_522_1:RecordAudio("115301129", var_525_12)
						arg_522_1:RecordAudio("115301129", var_525_12)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_out_115301", "115301129", "story_v_out_115301.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_out_115301", "115301129", "story_v_out_115301.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_13 = math.max(var_525_6, arg_522_1.talkMaxDuration)

			if var_525_5 <= arg_522_1.time_ and arg_522_1.time_ < var_525_5 + var_525_13 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_5) / var_525_13

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_5 + var_525_13 and arg_522_1.time_ < var_525_5 + var_525_13 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play115301130 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 115301130
		arg_526_1.duration_ = 5

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play115301131(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 and not isNil(arg_526_1.actors_["1038"]) and arg_526_1.var_.actorSpriteComps1038 == nil then
				arg_526_1.var_.actorSpriteComps1038 = arg_526_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_529_0 = 0.2

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_0 and not isNil(arg_526_1.actors_["1038"]) then
				if arg_526_1.var_.actorSpriteComps1038 then
					for iter_529_0, iter_529_1 in pairs(arg_526_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_529_1 then
							if arg_526_1.isInRecall_ then
								iter_529_1.color = Color.New(Mathf.Lerp(iter_529_1.color.r, arg_526_1.hightColor2.r, (arg_526_1.time_ - 0) / var_529_0), Mathf.Lerp(iter_529_1.color.g, arg_526_1.hightColor2.g, (arg_526_1.time_ - 0) / var_529_0), (Mathf.Lerp(iter_529_1.color.b, arg_526_1.hightColor2.b, (arg_526_1.time_ - 0) / var_529_0)))
							else
								local var_529_1 = Mathf.Lerp(iter_529_1.color.r, 0.5, (arg_526_1.time_ - 0) / var_529_0)

								iter_529_1.color = Color.New(var_529_1, var_529_1, var_529_1)
							end
						end
					end
				end
			end

			if arg_526_1.time_ >= 0 + var_529_0 and arg_526_1.time_ < 0 + var_529_0 + arg_529_0 and not isNil(arg_526_1.actors_["1038"]) and arg_526_1.var_.actorSpriteComps1038 then
				for iter_529_2, iter_529_3 in pairs(arg_526_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_529_3 then
						iter_529_3.color = arg_526_1.isInRecall_ and (arg_526_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_526_1.var_.actorSpriteComps1038 = nil
			end

			local var_529_2 = 0
			local var_529_3 = 0.825

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= var_529_2 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, false)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_4 = arg_526_1:FormatText(arg_526_1:GetWordFromCfg(115301130).content)

				arg_526_1.text_.text = var_529_4

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_6 = 33 <= 0 and var_529_3 or var_529_3 * (utf8.len(var_529_4) / 33)

				if (33 <= 0 and var_529_3 or var_529_3 * (utf8.len(var_529_4) / 33)) > 0 and var_529_3 < var_529_6 then
					arg_526_1.talkMaxDuration = var_529_6

					if var_529_6 + var_529_2 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_6 + var_529_2
					end
				end

				arg_526_1.text_.text = var_529_4
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)
				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_7 = math.max(var_529_3, arg_526_1.talkMaxDuration)

			if var_529_2 <= arg_526_1.time_ and arg_526_1.time_ < var_529_2 + var_529_7 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_2) / var_529_7

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_2 + var_529_7 and arg_526_1.time_ < var_529_2 + var_529_7 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {}

		arg_526_1:InitPlayNodeList()
	end,
	Play115301131 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 115301131
		arg_530_1.duration_ = 4.3

		local var_530_0 = {
			ja = 4.3,
			ko = 2.5,
			zh = 3.333,
			en = 3.1
		}
		local var_530_1 = manager.audio:GetLocalizationFlag()

		if var_530_0[var_530_1] ~= nil then
			arg_530_1.duration_ = var_530_0[var_530_1]
		end

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play115301132(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 and not isNil(arg_530_1.actors_["10030"]) and arg_530_1.var_.actorSpriteComps10030 == nil then
				arg_530_1.var_.actorSpriteComps10030 = arg_530_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_533_0 = 0.2

			if 0 <= arg_530_1.time_ and arg_530_1.time_ < 0 + var_533_0 and not isNil(arg_530_1.actors_["10030"]) then
				if arg_530_1.var_.actorSpriteComps10030 then
					for iter_533_0, iter_533_1 in pairs(arg_530_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_533_1 then
							if arg_530_1.isInRecall_ then
								iter_533_1.color = Color.New(Mathf.Lerp(iter_533_1.color.r, arg_530_1.hightColor1.r, (arg_530_1.time_ - 0) / var_533_0), Mathf.Lerp(iter_533_1.color.g, arg_530_1.hightColor1.g, (arg_530_1.time_ - 0) / var_533_0), (Mathf.Lerp(iter_533_1.color.b, arg_530_1.hightColor1.b, (arg_530_1.time_ - 0) / var_533_0)))
							else
								local var_533_1 = Mathf.Lerp(iter_533_1.color.r, 1, (arg_530_1.time_ - 0) / var_533_0)

								iter_533_1.color = Color.New(var_533_1, var_533_1, var_533_1)
							end
						end
					end
				end
			end

			if arg_530_1.time_ >= 0 + var_533_0 and arg_530_1.time_ < 0 + var_533_0 + arg_533_0 and not isNil(arg_530_1.actors_["10030"]) and arg_530_1.var_.actorSpriteComps10030 then
				for iter_533_2, iter_533_3 in pairs(arg_530_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_533_3 then
						iter_533_3.color = arg_530_1.isInRecall_ and (arg_530_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_530_1.var_.actorSpriteComps10030 = nil
			end

			local var_533_2 = 0
			local var_533_3 = 0.275

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= var_533_2 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				arg_530_1.leftNameTxt_.text = arg_530_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_4 = arg_530_1:GetWordFromCfg(115301131)
				local var_533_5 = arg_530_1:FormatText(var_533_4.content)

				arg_530_1.text_.text = var_533_5

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_7 = 11 <= 0 and var_533_3 or var_533_3 * (utf8.len(var_533_5) / 11)

				if (11 <= 0 and var_533_3 or var_533_3 * (utf8.len(var_533_5) / 11)) > 0 and var_533_3 < var_533_7 then
					arg_530_1.talkMaxDuration = var_533_7

					if var_533_7 + var_533_2 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_7 + var_533_2
					end
				end

				arg_530_1.text_.text = var_533_5
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301131", "story_v_out_115301.awb") ~= 0 then
					local var_533_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301131", "story_v_out_115301.awb") / 1000

					if var_533_8 + var_533_2 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_8 + var_533_2
					end

					if var_533_4.prefab_name ~= "" and arg_530_1.actors_[var_533_4.prefab_name] ~= nil then
						local var_533_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_530_1.actors_[var_533_4.prefab_name].transform, "story_v_out_115301", "115301131", "story_v_out_115301.awb")

						arg_530_1:RecordAudio("115301131", var_533_9)
						arg_530_1:RecordAudio("115301131", var_533_9)
					else
						arg_530_1:AudioAction("play", "voice", "story_v_out_115301", "115301131", "story_v_out_115301.awb")
					end

					arg_530_1:RecordHistoryTalkVoice("story_v_out_115301", "115301131", "story_v_out_115301.awb")
				end

				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_10 = math.max(var_533_3, arg_530_1.talkMaxDuration)

			if var_533_2 <= arg_530_1.time_ and arg_530_1.time_ < var_533_2 + var_533_10 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_2) / var_533_10

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_2 + var_533_10 and arg_530_1.time_ < var_533_2 + var_533_10 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play115301132 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 115301132
		arg_534_1.duration_ = 9.9

		local var_534_0 = {
			ja = 9.9,
			ko = 4.466,
			zh = 5.1,
			en = 4.766
		}
		local var_534_1 = manager.audio:GetLocalizationFlag()

		if var_534_0[var_534_1] ~= nil then
			arg_534_1.duration_ = var_534_0[var_534_1]
		end

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play115301133(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 and not isNil(arg_534_1.actors_["10030"]) and arg_534_1.var_.actorSpriteComps10030 == nil then
				arg_534_1.var_.actorSpriteComps10030 = arg_534_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_537_0 = 0.2

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_0 and not isNil(arg_534_1.actors_["10030"]) then
				if arg_534_1.var_.actorSpriteComps10030 then
					for iter_537_0, iter_537_1 in pairs(arg_534_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_537_1 then
							if arg_534_1.isInRecall_ then
								iter_537_1.color = Color.New(Mathf.Lerp(iter_537_1.color.r, arg_534_1.hightColor2.r, (arg_534_1.time_ - 0) / var_537_0), Mathf.Lerp(iter_537_1.color.g, arg_534_1.hightColor2.g, (arg_534_1.time_ - 0) / var_537_0), (Mathf.Lerp(iter_537_1.color.b, arg_534_1.hightColor2.b, (arg_534_1.time_ - 0) / var_537_0)))
							else
								local var_537_1 = Mathf.Lerp(iter_537_1.color.r, 0.5, (arg_534_1.time_ - 0) / var_537_0)

								iter_537_1.color = Color.New(var_537_1, var_537_1, var_537_1)
							end
						end
					end
				end
			end

			if arg_534_1.time_ >= 0 + var_537_0 and arg_534_1.time_ < 0 + var_537_0 + arg_537_0 and not isNil(arg_534_1.actors_["10030"]) and arg_534_1.var_.actorSpriteComps10030 then
				for iter_537_2, iter_537_3 in pairs(arg_534_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_537_3 then
						iter_537_3.color = arg_534_1.isInRecall_ and (arg_534_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_534_1.var_.actorSpriteComps10030 = nil
			end

			local var_537_2 = arg_534_1.actors_["1038"].transform

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 then
				arg_534_1.var_.moveOldPos1038 = var_537_2.localPosition
				var_537_2.localScale = Vector3.New(1, 1, 1)

				arg_534_1:CheckSpriteTmpPos("1038", 2)

				for iter_537_4 = 0, var_537_2.childCount - 1 do
					local var_537_3 = var_537_2:GetChild(iter_537_4)

					if var_537_3.name == "split_7" or not string.find(var_537_3.name, "split") then
						var_537_3.gameObject:SetActive(true)
					else
						var_537_3.gameObject:SetActive(false)
					end
				end
			end

			local var_537_4 = 0.001

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_4 then
				var_537_2.localPosition = Vector3.Lerp(arg_534_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_534_1.time_ - 0) / var_537_4)
			end

			if arg_534_1.time_ >= 0 + var_537_4 and arg_534_1.time_ < 0 + var_537_4 + arg_537_0 then
				var_537_2.localPosition = Vector3.New(-390, -400, 0)
			end

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 then
				local var_537_5 = arg_534_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_537_5 then
					arg_534_1.var_.alphaOldValue1038 = var_537_5.alpha
					arg_534_1.var_.characterEffect1038 = var_537_5
				end

				arg_534_1.var_.alphaOldValue1038 = 0
			end

			local var_537_6 = 0.0166666666666667

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_6 then
				if arg_534_1.var_.characterEffect1038 then
					arg_534_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_534_1.var_.alphaOldValue1038, 1, (arg_534_1.time_ - 0) / var_537_6)
				end
			end

			if arg_534_1.time_ >= 0 + var_537_6 and arg_534_1.time_ < 0 + var_537_6 + arg_537_0 and arg_534_1.var_.characterEffect1038 then
				arg_534_1.var_.characterEffect1038.alpha = 1
			end

			local var_537_7 = 0
			local var_537_8 = 0.5

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= var_537_7 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, true)

				arg_534_1.leftNameTxt_.text = arg_534_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_9 = arg_534_1:GetWordFromCfg(115301132)
				local var_537_10 = arg_534_1:FormatText(var_537_9.content)

				arg_534_1.text_.text = var_537_10

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_12 = 20 <= 0 and var_537_8 or var_537_8 * (utf8.len(var_537_10) / 20)

				if (20 <= 0 and var_537_8 or var_537_8 * (utf8.len(var_537_10) / 20)) > 0 and var_537_8 < var_537_12 then
					arg_534_1.talkMaxDuration = var_537_12

					if var_537_12 + var_537_7 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_12 + var_537_7
					end
				end

				arg_534_1.text_.text = var_537_10
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301132", "story_v_out_115301.awb") ~= 0 then
					local var_537_13 = manager.audio:GetVoiceLength("story_v_out_115301", "115301132", "story_v_out_115301.awb") / 1000

					if var_537_13 + var_537_7 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_13 + var_537_7
					end

					if var_537_9.prefab_name ~= "" and arg_534_1.actors_[var_537_9.prefab_name] ~= nil then
						local var_537_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_534_1.actors_[var_537_9.prefab_name].transform, "story_v_out_115301", "115301132", "story_v_out_115301.awb")

						arg_534_1:RecordAudio("115301132", var_537_14)
						arg_534_1:RecordAudio("115301132", var_537_14)
					else
						arg_534_1:AudioAction("play", "voice", "story_v_out_115301", "115301132", "story_v_out_115301.awb")
					end

					arg_534_1:RecordHistoryTalkVoice("story_v_out_115301", "115301132", "story_v_out_115301.awb")
				end

				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_15 = math.max(var_537_8, arg_534_1.talkMaxDuration)

			if var_537_7 <= arg_534_1.time_ and arg_534_1.time_ < var_537_7 + var_537_15 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_7) / var_537_15

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_7 + var_537_15 and arg_534_1.time_ < var_537_7 + var_537_15 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_534_1:InitPlayNodeList()
	end,
	Play115301133 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 115301133
		arg_538_1.duration_ = 4

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play115301134(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			if 1 < arg_538_1.time_ and arg_538_1.time_ <= 1 + arg_541_0 then
				local var_541_0 = arg_538_1.bgs_.STblack

				arg_538_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_541_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_541_1 = var_541_0:GetComponent("SpriteRenderer")

				if var_541_1 and var_541_1.sprite then
					local var_541_2 = 2 * (var_541_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_541_0.transform.localScale = Vector3.New(var_541_2 / var_541_1.sprite.bounds.size.y < var_541_2 * manager.ui.mainCameraCom_.aspect / var_541_1.sprite.bounds.size.x and var_541_2 * manager.ui.mainCameraCom_.aspect / var_541_1.sprite.bounds.size.x or var_541_2 / var_541_1.sprite.bounds.size.y, var_541_2 / var_541_1.sprite.bounds.size.y < var_541_2 * manager.ui.mainCameraCom_.aspect / var_541_1.sprite.bounds.size.x and var_541_2 * manager.ui.mainCameraCom_.aspect / var_541_1.sprite.bounds.size.x or var_541_2 / var_541_1.sprite.bounds.size.y, 0)
				end

				for iter_541_0, iter_541_1 in pairs(arg_538_1.bgs_) do
					if iter_541_0 ~= "STblack" then
						iter_541_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_541_3 = 0

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= var_541_3 + arg_541_0 then
				arg_538_1.mask_.enabled = true
				arg_538_1.mask_.raycastTarget = true

				arg_538_1:SetGaussion(false)
			end

			local var_541_4 = 1

			if var_541_3 <= arg_538_1.time_ and arg_538_1.time_ < var_541_3 + var_541_4 then
				local var_541_5 = Color.New(0, 0, 0)

				var_541_5.a = Mathf.Lerp(0, 1, (arg_538_1.time_ - var_541_3) / var_541_4)
				arg_538_1.mask_.color = var_541_5
			end

			if arg_538_1.time_ >= var_541_3 + var_541_4 and arg_538_1.time_ < var_541_3 + var_541_4 + arg_541_0 then
				local var_541_6 = Color.New(0, 0, 0)

				var_541_6.a = 1
				arg_538_1.mask_.color = var_541_6
			end

			local var_541_7 = 1

			if 1 < arg_538_1.time_ and arg_538_1.time_ <= var_541_7 + arg_541_0 then
				arg_538_1.mask_.enabled = true
				arg_538_1.mask_.raycastTarget = false

				arg_538_1:SetGaussion(false)
			end

			local var_541_8 = 0.0333333333333333

			if var_541_7 <= arg_538_1.time_ and arg_538_1.time_ < var_541_7 + var_541_8 then
				local var_541_9 = Color.New(0, 0, 0)

				var_541_9.a = Mathf.Lerp(1, 0, (arg_538_1.time_ - var_541_7) / var_541_8)
				arg_538_1.mask_.color = var_541_9
			end

			if arg_538_1.time_ >= var_541_7 + var_541_8 and arg_538_1.time_ < var_541_7 + var_541_8 + arg_541_0 then
				local var_541_10 = Color.New(0, 0, 0)

				arg_538_1.mask_.enabled = false
				var_541_10.a = 0
				arg_538_1.mask_.color = var_541_10
			end

			if 1 < arg_538_1.time_ and arg_538_1.time_ <= 1 + arg_541_0 then
				arg_538_1.fswbg_:SetActive(true)
				arg_538_1.dialog_:SetActive(false)

				arg_538_1.fswtw_.percent = 0
				arg_538_1.fswt_.text = arg_538_1:FormatText(arg_538_1:GetWordFromCfg(115301133).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.fswt_)

				arg_538_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_538_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_538_1.fswtw_:SetDirty()

				arg_538_1.typewritterCharCountI18N = 0

				SetActive(arg_538_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_538_1:ShowNextGo(false)
			end

			local var_541_11 = 1.01666666666667

			if 1.01666666666667 < arg_538_1.time_ and arg_538_1.time_ <= var_541_11 + arg_541_0 then
				arg_538_1.var_.oldValueTypewriter = arg_538_1.fswtw_.percent

				SetActive(arg_538_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_538_1:ShowNextGo(false)
			end

			local var_541_12 = 14
			local var_541_13 = 0.933333333333333
			local var_541_14, var_541_15 = arg_538_1:GetPercentByPara(arg_538_1:FormatText(arg_538_1:GetWordFromCfg(115301133).content), 1)

			if var_541_11 < arg_538_1.time_ and arg_538_1.time_ <= var_541_11 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0

				local var_541_16 = var_541_12 <= 0 and var_541_13 or var_541_13 * ((var_541_15 - arg_538_1.typewritterCharCountI18N) / var_541_12)

				if (var_541_12 <= 0 and var_541_13 or var_541_13 * ((var_541_15 - arg_538_1.typewritterCharCountI18N) / var_541_12)) > 0 and var_541_13 < var_541_16 then
					arg_538_1.talkMaxDuration = var_541_16

					if var_541_16 + var_541_11 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_16 + var_541_11
					end
				end
			end

			local var_541_17 = math.max(0.933333333333333, arg_538_1.talkMaxDuration)

			if var_541_11 <= arg_538_1.time_ and arg_538_1.time_ < var_541_11 + var_541_17 then
				arg_538_1.fswtw_.percent = Mathf.Lerp(arg_538_1.var_.oldValueTypewriter, var_541_14, (arg_538_1.time_ - var_541_11) / var_541_17)
				arg_538_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_538_1.fswtw_:SetDirty()
			end

			if arg_538_1.time_ >= var_541_11 + var_541_17 and arg_538_1.time_ < var_541_11 + var_541_17 + arg_541_0 then
				arg_538_1.fswtw_.percent = var_541_14

				arg_538_1.fswtw_:SetDirty()
				arg_538_1:ShowNextGo(true)

				arg_538_1.typewritterCharCountI18N = var_541_15
			end

			local var_541_18 = arg_538_1.actors_["10030"].transform

			if 1 < arg_538_1.time_ and arg_538_1.time_ <= 1 + arg_541_0 then
				arg_538_1.var_.moveOldPos10030 = var_541_18.localPosition
				var_541_18.localScale = Vector3.New(1, 1, 1)

				arg_538_1:CheckSpriteTmpPos("10030", 0)

				for iter_541_2 = 0, var_541_18.childCount - 1 do
					local var_541_19 = var_541_18:GetChild(iter_541_2)

					if var_541_19.name == "split_1" or not string.find(var_541_19.name, "split") then
						var_541_19.gameObject:SetActive(true)
					else
						var_541_19.gameObject:SetActive(false)
					end
				end
			end

			local var_541_20 = 0.001

			if 1 <= arg_538_1.time_ and arg_538_1.time_ < 1 + var_541_20 then
				var_541_18.localPosition = Vector3.Lerp(arg_538_1.var_.moveOldPos10030, Vector3.New(-1500, -350, -180), (arg_538_1.time_ - 1) / var_541_20)
			end

			if arg_538_1.time_ >= 1 + var_541_20 and arg_538_1.time_ < 1 + var_541_20 + arg_541_0 then
				var_541_18.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_541_21 = arg_538_1.actors_["1038"].transform

			if 1 < arg_538_1.time_ and arg_538_1.time_ <= 1 + arg_541_0 then
				arg_538_1.var_.moveOldPos1038 = var_541_21.localPosition
				var_541_21.localScale = Vector3.New(1, 1, 1)

				arg_538_1:CheckSpriteTmpPos("1038", 0)

				for iter_541_3 = 0, var_541_21.childCount - 1 do
					local var_541_22 = var_541_21:GetChild(iter_541_3)

					if var_541_22.name == "split_7" or not string.find(var_541_22.name, "split") then
						var_541_22.gameObject:SetActive(true)
					else
						var_541_22.gameObject:SetActive(false)
					end
				end
			end

			local var_541_23 = 0.001

			if 1 <= arg_538_1.time_ and arg_538_1.time_ < 1 + var_541_23 then
				var_541_21.localPosition = Vector3.Lerp(arg_538_1.var_.moveOldPos1038, Vector3.New(-1500, -350, -180), (arg_538_1.time_ - 1) / var_541_23)
			end

			if arg_538_1.time_ >= 1 + var_541_23 and arg_538_1.time_ < 1 + var_541_23 + arg_541_0 then
				var_541_21.localPosition = Vector3.New(-1500, -350, -180)
			end
		end

		arg_538_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_538_1:InitPlayNodeList()
	end,
	Play115301134 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 115301134
		arg_542_1.duration_ = 1

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play115301135(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 then
				arg_542_1.var_.oldValueTypewriter = arg_542_1.fswtw_.percent

				SetActive(arg_542_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_542_1:ShowNextGo(false)
			end

			local var_545_0 = 26
			local var_545_1 = 0.8
			local var_545_2, var_545_3 = arg_542_1:GetPercentByPara(arg_542_1:FormatText(arg_542_1:GetWordFromCfg(115301133).content), 2)

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0

				local var_545_4 = var_545_0 <= 0 and var_545_1 or var_545_1 * ((var_545_3 - arg_542_1.typewritterCharCountI18N) / var_545_0)

				if (var_545_0 <= 0 and var_545_1 or var_545_1 * ((var_545_3 - arg_542_1.typewritterCharCountI18N) / var_545_0)) > 0 and var_545_1 < var_545_4 then
					arg_542_1.talkMaxDuration = var_545_4

					if var_545_4 + 0 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_4 + 0
					end
				end
			end

			local var_545_5 = math.max(0.8, arg_542_1.talkMaxDuration)

			if 0 <= arg_542_1.time_ and arg_542_1.time_ < 0 + var_545_5 then
				arg_542_1.fswtw_.percent = Mathf.Lerp(arg_542_1.var_.oldValueTypewriter, var_545_2, (arg_542_1.time_ - 0) / var_545_5)
				arg_542_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_542_1.fswtw_:SetDirty()
			end

			if arg_542_1.time_ >= 0 + var_545_5 and arg_542_1.time_ < 0 + var_545_5 + arg_545_0 then
				arg_542_1.fswtw_.percent = var_545_2

				arg_542_1.fswtw_:SetDirty()
				arg_542_1:ShowNextGo(true)

				arg_542_1.typewritterCharCountI18N = var_545_3
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play115301135 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 115301135
		arg_546_1.duration_ = 1

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play115301136(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			if 0 < arg_546_1.time_ and arg_546_1.time_ <= 0 + arg_549_0 then
				arg_546_1.var_.oldValueTypewriter = arg_546_1.fswtw_.percent

				SetActive(arg_546_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_546_1:ShowNextGo(false)
			end

			local var_549_0 = 12
			local var_549_1 = 0.8
			local var_549_2, var_549_3 = arg_546_1:GetPercentByPara(arg_546_1:FormatText(arg_546_1:GetWordFromCfg(115301133).content), 3)

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= 0 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0

				local var_549_4 = var_549_0 <= 0 and var_549_1 or var_549_1 * ((var_549_3 - arg_546_1.typewritterCharCountI18N) / var_549_0)

				if (var_549_0 <= 0 and var_549_1 or var_549_1 * ((var_549_3 - arg_546_1.typewritterCharCountI18N) / var_549_0)) > 0 and var_549_1 < var_549_4 then
					arg_546_1.talkMaxDuration = var_549_4

					if var_549_4 + 0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_4 + 0
					end
				end
			end

			local var_549_5 = math.max(0.8, arg_546_1.talkMaxDuration)

			if 0 <= arg_546_1.time_ and arg_546_1.time_ < 0 + var_549_5 then
				arg_546_1.fswtw_.percent = Mathf.Lerp(arg_546_1.var_.oldValueTypewriter, var_549_2, (arg_546_1.time_ - 0) / var_549_5)
				arg_546_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_546_1.fswtw_:SetDirty()
			end

			if arg_546_1.time_ >= 0 + var_549_5 and arg_546_1.time_ < 0 + var_549_5 + arg_549_0 then
				arg_546_1.fswtw_.percent = var_549_2

				arg_546_1.fswtw_:SetDirty()
				arg_546_1:ShowNextGo(true)

				arg_546_1.typewritterCharCountI18N = var_549_3
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play115301136 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 115301136
		arg_550_1.duration_ = 1

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play115301137(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 then
				arg_550_1.var_.oldValueTypewriter = arg_550_1.fswtw_.percent

				SetActive(arg_550_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_550_1:ShowNextGo(false)
			end

			local var_553_0 = 13
			local var_553_1 = 0.866666666666667
			local var_553_2, var_553_3 = arg_550_1:GetPercentByPara(arg_550_1:FormatText(arg_550_1:GetWordFromCfg(115301133).content), 4)

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0

				local var_553_4 = var_553_0 <= 0 and var_553_1 or var_553_1 * ((var_553_3 - arg_550_1.typewritterCharCountI18N) / var_553_0)

				if (var_553_0 <= 0 and var_553_1 or var_553_1 * ((var_553_3 - arg_550_1.typewritterCharCountI18N) / var_553_0)) > 0 and var_553_1 < var_553_4 then
					arg_550_1.talkMaxDuration = var_553_4

					if var_553_4 + 0 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_4 + 0
					end
				end
			end

			local var_553_5 = math.max(0.866666666666667, arg_550_1.talkMaxDuration)

			if 0 <= arg_550_1.time_ and arg_550_1.time_ < 0 + var_553_5 then
				arg_550_1.fswtw_.percent = Mathf.Lerp(arg_550_1.var_.oldValueTypewriter, var_553_2, (arg_550_1.time_ - 0) / var_553_5)
				arg_550_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_550_1.fswtw_:SetDirty()
			end

			if arg_550_1.time_ >= 0 + var_553_5 and arg_550_1.time_ < 0 + var_553_5 + arg_553_0 then
				arg_550_1.fswtw_.percent = var_553_2

				arg_550_1.fswtw_:SetDirty()
				arg_550_1:ShowNextGo(true)

				arg_550_1.typewritterCharCountI18N = var_553_3
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play115301137 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 115301137
		arg_554_1.duration_ = 1.07

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play115301138(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 then
				arg_554_1.var_.oldValueTypewriter = arg_554_1.fswtw_.percent

				SetActive(arg_554_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_554_1:ShowNextGo(false)
			end

			local var_557_0 = 16
			local var_557_1 = 1.06666666666667
			local var_557_2, var_557_3 = arg_554_1:GetPercentByPara(arg_554_1:FormatText(arg_554_1:GetWordFromCfg(115301133).content), 5)

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0

				local var_557_4 = var_557_0 <= 0 and var_557_1 or var_557_1 * ((var_557_3 - arg_554_1.typewritterCharCountI18N) / var_557_0)

				if (var_557_0 <= 0 and var_557_1 or var_557_1 * ((var_557_3 - arg_554_1.typewritterCharCountI18N) / var_557_0)) > 0 and var_557_1 < var_557_4 then
					arg_554_1.talkMaxDuration = var_557_4

					if var_557_4 + 0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_4 + 0
					end
				end
			end

			local var_557_5 = math.max(1.06666666666667, arg_554_1.talkMaxDuration)

			if 0 <= arg_554_1.time_ and arg_554_1.time_ < 0 + var_557_5 then
				arg_554_1.fswtw_.percent = Mathf.Lerp(arg_554_1.var_.oldValueTypewriter, var_557_2, (arg_554_1.time_ - 0) / var_557_5)
				arg_554_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_554_1.fswtw_:SetDirty()
			end

			if arg_554_1.time_ >= 0 + var_557_5 and arg_554_1.time_ < 0 + var_557_5 + arg_557_0 then
				arg_554_1.fswtw_.percent = var_557_2

				arg_554_1.fswtw_:SetDirty()
				arg_554_1:ShowNextGo(true)

				arg_554_1.typewritterCharCountI18N = var_557_3
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play115301138 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 115301138
		arg_558_1.duration_ = 1.07

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play115301139(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 then
				arg_558_1.var_.oldValueTypewriter = arg_558_1.fswtw_.percent

				SetActive(arg_558_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_558_1:ShowNextGo(false)
			end

			local var_561_0 = 16
			local var_561_1 = 1.06666666666667
			local var_561_2, var_561_3 = arg_558_1:GetPercentByPara(arg_558_1:FormatText(arg_558_1:GetWordFromCfg(115301133).content), 6)

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0

				local var_561_4 = var_561_0 <= 0 and var_561_1 or var_561_1 * ((var_561_3 - arg_558_1.typewritterCharCountI18N) / var_561_0)

				if (var_561_0 <= 0 and var_561_1 or var_561_1 * ((var_561_3 - arg_558_1.typewritterCharCountI18N) / var_561_0)) > 0 and var_561_1 < var_561_4 then
					arg_558_1.talkMaxDuration = var_561_4

					if var_561_4 + 0 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_4 + 0
					end
				end
			end

			local var_561_5 = math.max(1.06666666666667, arg_558_1.talkMaxDuration)

			if 0 <= arg_558_1.time_ and arg_558_1.time_ < 0 + var_561_5 then
				arg_558_1.fswtw_.percent = Mathf.Lerp(arg_558_1.var_.oldValueTypewriter, var_561_2, (arg_558_1.time_ - 0) / var_561_5)
				arg_558_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_558_1.fswtw_:SetDirty()
			end

			if arg_558_1.time_ >= 0 + var_561_5 and arg_558_1.time_ < 0 + var_561_5 + arg_561_0 then
				arg_558_1.fswtw_.percent = var_561_2

				arg_558_1.fswtw_:SetDirty()
				arg_558_1:ShowNextGo(true)

				arg_558_1.typewritterCharCountI18N = var_561_3
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	Play115301139 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 115301139
		arg_562_1.duration_ = 1.4

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play115301140(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1.var_.oldValueTypewriter = arg_562_1.fswtw_.percent

				SetActive(arg_562_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_562_1:ShowNextGo(false)
			end

			local var_565_0 = 21
			local var_565_1 = 1.4
			local var_565_2, var_565_3 = arg_562_1:GetPercentByPara(arg_562_1:FormatText(arg_562_1:GetWordFromCfg(115301133).content), 7)

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0

				local var_565_4 = var_565_0 <= 0 and var_565_1 or var_565_1 * ((var_565_3 - arg_562_1.typewritterCharCountI18N) / var_565_0)

				if (var_565_0 <= 0 and var_565_1 or var_565_1 * ((var_565_3 - arg_562_1.typewritterCharCountI18N) / var_565_0)) > 0 and var_565_1 < var_565_4 then
					arg_562_1.talkMaxDuration = var_565_4

					if var_565_4 + 0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_4 + 0
					end
				end
			end

			local var_565_5 = math.max(1.4, arg_562_1.talkMaxDuration)

			if 0 <= arg_562_1.time_ and arg_562_1.time_ < 0 + var_565_5 then
				arg_562_1.fswtw_.percent = Mathf.Lerp(arg_562_1.var_.oldValueTypewriter, var_565_2, (arg_562_1.time_ - 0) / var_565_5)
				arg_562_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_562_1.fswtw_:SetDirty()
			end

			if arg_562_1.time_ >= 0 + var_565_5 and arg_562_1.time_ < 0 + var_565_5 + arg_565_0 then
				arg_562_1.fswtw_.percent = var_565_2

				arg_562_1.fswtw_:SetDirty()
				arg_562_1:ShowNextGo(true)

				arg_562_1.typewritterCharCountI18N = var_565_3
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	Play115301140 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 115301140
		arg_566_1.duration_ = 8.57

		local var_566_0 = {
			ja = 7.4,
			ko = 8.566,
			zh = 7.766,
			en = 7.933
		}
		local var_566_1 = manager.audio:GetLocalizationFlag()

		if var_566_0[var_566_1] ~= nil then
			arg_566_1.duration_ = var_566_0[var_566_1]
		end

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play115301141(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			if arg_566_1.bgs_.ST22 == nil then
				local var_569_0 = Object.Instantiate(arg_566_1.paintGo_)

				var_569_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST22")
				var_569_0.name = "ST22"
				var_569_0.transform.parent = arg_566_1.stage_.transform
				var_569_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_566_1.bgs_.ST22 = var_569_0
			end

			if 2 < arg_566_1.time_ and arg_566_1.time_ <= 2 + arg_569_0 then
				local var_569_1 = arg_566_1.bgs_.ST22

				arg_566_1.bgs_.ST22.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_569_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_569_2 = var_569_1:GetComponent("SpriteRenderer")

				if var_569_2 and var_569_2.sprite then
					local var_569_3 = 2 * (var_569_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_569_1.transform.localScale = Vector3.New(var_569_3 / var_569_2.sprite.bounds.size.y < var_569_3 * manager.ui.mainCameraCom_.aspect / var_569_2.sprite.bounds.size.x and var_569_3 * manager.ui.mainCameraCom_.aspect / var_569_2.sprite.bounds.size.x or var_569_3 / var_569_2.sprite.bounds.size.y, var_569_3 / var_569_2.sprite.bounds.size.y < var_569_3 * manager.ui.mainCameraCom_.aspect / var_569_2.sprite.bounds.size.x and var_569_3 * manager.ui.mainCameraCom_.aspect / var_569_2.sprite.bounds.size.x or var_569_3 / var_569_2.sprite.bounds.size.y, 0)
				end

				for iter_569_0, iter_569_1 in pairs(arg_566_1.bgs_) do
					if iter_569_0 ~= "ST22" then
						iter_569_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_569_4 = 2

			if 2 < arg_566_1.time_ and arg_566_1.time_ <= var_569_4 + arg_569_0 then
				arg_566_1.mask_.enabled = true
				arg_566_1.mask_.raycastTarget = false

				arg_566_1:SetGaussion(false)
			end

			local var_569_5 = 2

			if var_569_4 <= arg_566_1.time_ and arg_566_1.time_ < var_569_4 + var_569_5 then
				local var_569_6 = Color.New(0, 0, 0)

				var_569_6.a = Mathf.Lerp(1, 0, (arg_566_1.time_ - var_569_4) / var_569_5)
				arg_566_1.mask_.color = var_569_6
			end

			if arg_566_1.time_ >= var_569_4 + var_569_5 and arg_566_1.time_ < var_569_4 + var_569_5 + arg_569_0 then
				local var_569_7 = Color.New(0, 0, 0)

				arg_566_1.mask_.enabled = false
				var_569_7.a = 0
				arg_566_1.mask_.color = var_569_7
			end

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 then
				arg_566_1.fswbg_:SetActive(false)
				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_566_1:ShowNextGo(false)
			end

			local var_569_8 = 0

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_8 + arg_569_0 then
				arg_566_1.allBtn_.enabled = false
			end

			if arg_566_1.time_ >= var_569_8 + 4 and arg_566_1.time_ < var_569_8 + 4 + arg_569_0 then
				arg_566_1.allBtn_.enabled = true
			end

			if arg_566_1.frameCnt_ <= 1 then
				arg_566_1.dialog_:SetActive(false)
			end

			local var_569_9 = 4
			local var_569_10 = 0.3

			if 4 < arg_566_1.time_ and arg_566_1.time_ <= var_569_9 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0

				arg_566_1.dialog_:SetActive(true)

				arg_566_1.dialogCg_.alpha = 0

				local var_569_11 = LeanTween.value(arg_566_1.dialog_, 0, 1, 0.3)

				var_569_11:setOnUpdate(LuaHelper.FloatAction(function(arg_570_0)
					arg_566_1.dialogCg_.alpha = arg_570_0
				end))
				var_569_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_566_1.dialog_)
					var_569_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_566_1.duration_ = arg_566_1.duration_ + 0.3

				SetActive(arg_566_1.leftNameGo_, true)

				arg_566_1.leftNameTxt_.text = arg_566_1:FormatText(StoryNameCfg[306].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_12 = arg_566_1:GetWordFromCfg(115301140)
				local var_569_13 = arg_566_1:FormatText(var_569_12.content)

				arg_566_1.text_.text = var_569_13

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_15 = 12 <= 0 and var_569_10 or var_569_10 * (utf8.len(var_569_13) / 12)

				if (12 <= 0 and var_569_10 or var_569_10 * (utf8.len(var_569_13) / 12)) > 0 and var_569_10 < var_569_15 then
					arg_566_1.talkMaxDuration = var_569_15
					var_569_9 = var_569_9 + 0.3

					if var_569_15 + var_569_9 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_15 + var_569_9
					end
				end

				arg_566_1.text_.text = var_569_13
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301140", "story_v_out_115301.awb") ~= 0 then
					local var_569_16 = manager.audio:GetVoiceLength("story_v_out_115301", "115301140", "story_v_out_115301.awb") / 1000

					if var_569_16 + var_569_9 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_16 + var_569_9
					end

					if var_569_12.prefab_name ~= "" and arg_566_1.actors_[var_569_12.prefab_name] ~= nil then
						local var_569_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_566_1.actors_[var_569_12.prefab_name].transform, "story_v_out_115301", "115301140", "story_v_out_115301.awb")

						arg_566_1:RecordAudio("115301140", var_569_17)
						arg_566_1:RecordAudio("115301140", var_569_17)
					else
						arg_566_1:AudioAction("play", "voice", "story_v_out_115301", "115301140", "story_v_out_115301.awb")
					end

					arg_566_1:RecordHistoryTalkVoice("story_v_out_115301", "115301140", "story_v_out_115301.awb")
				end

				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_18 = var_569_9 + 0.3
			local var_569_19 = math.max(var_569_10, arg_566_1.talkMaxDuration)

			if var_569_9 + 0.3 <= arg_566_1.time_ and arg_566_1.time_ < var_569_18 + var_569_19 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_18) / var_569_19

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_18 + var_569_19 and arg_566_1.time_ < var_569_18 + var_569_19 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {}

		arg_566_1:InitPlayNodeList()
	end,
	Play115301141 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 115301141
		arg_572_1.duration_ = 5.5

		local var_572_0 = {
			ja = 3.333,
			ko = 5.5,
			zh = 3.5,
			en = 3.7
		}
		local var_572_1 = manager.audio:GetLocalizationFlag()

		if var_572_0[var_572_1] ~= nil then
			arg_572_1.duration_ = var_572_0[var_572_1]
		end

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play115301142(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			local var_575_0 = 0.3

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, true)

				arg_572_1.leftNameTxt_.text = arg_572_1:FormatText(StoryNameCfg[306].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_572_1.leftNameTxt_.transform)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1.leftNameTxt_.text)
				SetActive(arg_572_1.iconTrs_.gameObject, false)
				arg_572_1.callingController_:SetSelectedState("normal")

				local var_575_1 = arg_572_1:GetWordFromCfg(115301141)
				local var_575_2 = arg_572_1:FormatText(var_575_1.content)

				arg_572_1.text_.text = var_575_2

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_4 = 12 <= 0 and var_575_0 or var_575_0 * (utf8.len(var_575_2) / 12)

				if (12 <= 0 and var_575_0 or var_575_0 * (utf8.len(var_575_2) / 12)) > 0 and var_575_0 < var_575_4 then
					arg_572_1.talkMaxDuration = var_575_4

					if var_575_4 + 0 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_4 + 0
					end
				end

				arg_572_1.text_.text = var_575_2
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301141", "story_v_out_115301.awb") ~= 0 then
					local var_575_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301141", "story_v_out_115301.awb") / 1000

					if var_575_5 + 0 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_5 + 0
					end

					if var_575_1.prefab_name ~= "" and arg_572_1.actors_[var_575_1.prefab_name] ~= nil then
						local var_575_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_572_1.actors_[var_575_1.prefab_name].transform, "story_v_out_115301", "115301141", "story_v_out_115301.awb")

						arg_572_1:RecordAudio("115301141", var_575_6)
						arg_572_1:RecordAudio("115301141", var_575_6)
					else
						arg_572_1:AudioAction("play", "voice", "story_v_out_115301", "115301141", "story_v_out_115301.awb")
					end

					arg_572_1:RecordHistoryTalkVoice("story_v_out_115301", "115301141", "story_v_out_115301.awb")
				end

				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_7 = math.max(var_575_0, arg_572_1.talkMaxDuration)

			if 0 <= arg_572_1.time_ and arg_572_1.time_ < 0 + var_575_7 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - 0) / var_575_7

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= 0 + var_575_7 and arg_572_1.time_ < 0 + var_575_7 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {}

		arg_572_1:InitPlayNodeList()
	end,
	Play115301142 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 115301142
		arg_576_1.duration_ = 5

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play115301143(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			local var_579_0 = 1.425

			if 0 < arg_576_1.time_ and arg_576_1.time_ <= 0 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0
				arg_576_1.dialogCg_.alpha = 1

				arg_576_1.dialog_:SetActive(true)
				SetActive(arg_576_1.leftNameGo_, false)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_576_1.iconTrs_.gameObject, false)
				arg_576_1.callingController_:SetSelectedState("normal")

				local var_579_1 = arg_576_1:FormatText(arg_576_1:GetWordFromCfg(115301142).content)

				arg_576_1.text_.text = var_579_1

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_3 = 57 <= 0 and var_579_0 or var_579_0 * (utf8.len(var_579_1) / 57)

				if (57 <= 0 and var_579_0 or var_579_0 * (utf8.len(var_579_1) / 57)) > 0 and var_579_0 < var_579_3 then
					arg_576_1.talkMaxDuration = var_579_3

					if var_579_3 + 0 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_3 + 0
					end
				end

				arg_576_1.text_.text = var_579_1
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)
				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_4 = math.max(var_579_0, arg_576_1.talkMaxDuration)

			if 0 <= arg_576_1.time_ and arg_576_1.time_ < 0 + var_579_4 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - 0) / var_579_4

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= 0 + var_579_4 and arg_576_1.time_ < 0 + var_579_4 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {}

		arg_576_1:InitPlayNodeList()
	end,
	Play115301143 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 115301143
		arg_580_1.duration_ = 5

		SetActive(arg_580_1.tipsGo_, false)

		function arg_580_1.onSingleLineFinish_()
			arg_580_1.onSingleLineUpdate_ = nil
			arg_580_1.onSingleLineFinish_ = nil
			arg_580_1.state_ = "waiting"
		end

		function arg_580_1.playNext_(arg_582_0)
			if arg_582_0 == 1 then
				arg_580_0:Play115301144(arg_580_1)
			end
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			local var_583_0 = 1.15

			if 0 < arg_580_1.time_ and arg_580_1.time_ <= 0 + arg_583_0 then
				arg_580_1.talkMaxDuration = 0
				arg_580_1.dialogCg_.alpha = 1

				arg_580_1.dialog_:SetActive(true)
				SetActive(arg_580_1.leftNameGo_, false)

				arg_580_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_580_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_580_1:RecordName(arg_580_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_580_1.iconTrs_.gameObject, false)
				arg_580_1.callingController_:SetSelectedState("normal")

				local var_583_1 = arg_580_1:FormatText(arg_580_1:GetWordFromCfg(115301143).content)

				arg_580_1.text_.text = var_583_1

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.text_)

				local var_583_3 = 46 <= 0 and var_583_0 or var_583_0 * (utf8.len(var_583_1) / 46)

				if (46 <= 0 and var_583_0 or var_583_0 * (utf8.len(var_583_1) / 46)) > 0 and var_583_0 < var_583_3 then
					arg_580_1.talkMaxDuration = var_583_3

					if var_583_3 + 0 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_3 + 0
					end
				end

				arg_580_1.text_.text = var_583_1
				arg_580_1.typewritter.percent = 0

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(false)
				arg_580_1:RecordContent(arg_580_1.text_.text)
			end

			local var_583_4 = math.max(var_583_0, arg_580_1.talkMaxDuration)

			if 0 <= arg_580_1.time_ and arg_580_1.time_ < 0 + var_583_4 then
				arg_580_1.typewritter.percent = (arg_580_1.time_ - 0) / var_583_4

				arg_580_1.typewritter:SetDirty()
			end

			if arg_580_1.time_ >= 0 + var_583_4 and arg_580_1.time_ < 0 + var_583_4 + arg_583_0 then
				arg_580_1.typewritter.percent = 1

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(true)
			end
		end

		arg_580_1.nodeConfigList_ = {}

		arg_580_1:InitPlayNodeList()
	end,
	Play115301144 = function(arg_584_0, arg_584_1)
		arg_584_1.time_ = 0
		arg_584_1.frameCnt_ = 0
		arg_584_1.state_ = "playing"
		arg_584_1.curTalkId_ = 115301144
		arg_584_1.duration_ = 5

		SetActive(arg_584_1.tipsGo_, false)

		function arg_584_1.onSingleLineFinish_()
			arg_584_1.onSingleLineUpdate_ = nil
			arg_584_1.onSingleLineFinish_ = nil
			arg_584_1.state_ = "waiting"
		end

		function arg_584_1.playNext_(arg_586_0)
			if arg_586_0 == 1 then
				arg_584_0:Play115301145(arg_584_1)
			end
		end

		function arg_584_1.onSingleLineUpdate_(arg_587_0)
			local var_587_0 = 0.925

			if 0 < arg_584_1.time_ and arg_584_1.time_ <= 0 + arg_587_0 then
				arg_584_1.talkMaxDuration = 0
				arg_584_1.dialogCg_.alpha = 1

				arg_584_1.dialog_:SetActive(true)
				SetActive(arg_584_1.leftNameGo_, false)

				arg_584_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_584_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_584_1:RecordName(arg_584_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_584_1.iconTrs_.gameObject, false)
				arg_584_1.callingController_:SetSelectedState("normal")

				local var_587_1 = arg_584_1:FormatText(arg_584_1:GetWordFromCfg(115301144).content)

				arg_584_1.text_.text = var_587_1

				LuaForUtil.ClearLinePrefixSymbol(arg_584_1.text_)

				local var_587_3 = 37 <= 0 and var_587_0 or var_587_0 * (utf8.len(var_587_1) / 37)

				if (37 <= 0 and var_587_0 or var_587_0 * (utf8.len(var_587_1) / 37)) > 0 and var_587_0 < var_587_3 then
					arg_584_1.talkMaxDuration = var_587_3

					if var_587_3 + 0 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_3 + 0
					end
				end

				arg_584_1.text_.text = var_587_1
				arg_584_1.typewritter.percent = 0

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(false)
				arg_584_1:RecordContent(arg_584_1.text_.text)
			end

			local var_587_4 = math.max(var_587_0, arg_584_1.talkMaxDuration)

			if 0 <= arg_584_1.time_ and arg_584_1.time_ < 0 + var_587_4 then
				arg_584_1.typewritter.percent = (arg_584_1.time_ - 0) / var_587_4

				arg_584_1.typewritter:SetDirty()
			end

			if arg_584_1.time_ >= 0 + var_587_4 and arg_584_1.time_ < 0 + var_587_4 + arg_587_0 then
				arg_584_1.typewritter.percent = 1

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(true)
			end
		end

		arg_584_1.nodeConfigList_ = {}

		arg_584_1:InitPlayNodeList()
	end,
	Play115301145 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 115301145
		arg_588_1.duration_ = 4.3

		local var_588_0 = {
			ja = 4.1,
			ko = 3.333,
			zh = 2.1,
			en = 4.3
		}
		local var_588_1 = manager.audio:GetLocalizationFlag()

		if var_588_0[var_588_1] ~= nil then
			arg_588_1.duration_ = var_588_0[var_588_1]
		end

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
		end

		function arg_588_1.playNext_(arg_590_0)
			if arg_590_0 == 1 then
				arg_588_0:Play115301146(arg_588_1)
			end
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			if 0 < arg_588_1.time_ and arg_588_1.time_ <= 0 + arg_591_0 then
				arg_588_1.var_.moveOldPos10030 = arg_588_1.actors_["10030"].transform.localPosition
				arg_588_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_588_1:CheckSpriteTmpPos("10030", 3)

				for iter_591_0 = 0, arg_588_1.actors_["10030"].transform.childCount - 1 do
					local var_591_0 = arg_588_1.actors_["10030"].transform:GetChild(iter_591_0)

					if var_591_0.name == "split_1" or not string.find(var_591_0.name, "split") then
						var_591_0.gameObject:SetActive(true)
					else
						var_591_0.gameObject:SetActive(false)
					end
				end
			end

			local var_591_1 = 0.001

			if 0 <= arg_588_1.time_ and arg_588_1.time_ < 0 + var_591_1 then
				arg_588_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_588_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_588_1.time_ - 0) / var_591_1)
			end

			if arg_588_1.time_ >= 0 + var_591_1 and arg_588_1.time_ < 0 + var_591_1 + arg_591_0 then
				arg_588_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			local var_591_2 = arg_588_1.actors_["10030"]

			if 0 < arg_588_1.time_ and arg_588_1.time_ <= 0 + arg_591_0 and not isNil(var_591_2) and arg_588_1.var_.actorSpriteComps10030 == nil then
				arg_588_1.var_.actorSpriteComps10030 = var_591_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_591_3 = 0.2

			if 0 <= arg_588_1.time_ and arg_588_1.time_ < 0 + var_591_3 and not isNil(var_591_2) then
				if arg_588_1.var_.actorSpriteComps10030 then
					for iter_591_1, iter_591_2 in pairs(arg_588_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_591_2 then
							if arg_588_1.isInRecall_ then
								iter_591_2.color = Color.New(Mathf.Lerp(iter_591_2.color.r, arg_588_1.hightColor1.r, (arg_588_1.time_ - 0) / var_591_3), Mathf.Lerp(iter_591_2.color.g, arg_588_1.hightColor1.g, (arg_588_1.time_ - 0) / var_591_3), (Mathf.Lerp(iter_591_2.color.b, arg_588_1.hightColor1.b, (arg_588_1.time_ - 0) / var_591_3)))
							else
								local var_591_4 = Mathf.Lerp(iter_591_2.color.r, 1, (arg_588_1.time_ - 0) / var_591_3)

								iter_591_2.color = Color.New(var_591_4, var_591_4, var_591_4)
							end
						end
					end
				end
			end

			if arg_588_1.time_ >= 0 + var_591_3 and arg_588_1.time_ < 0 + var_591_3 + arg_591_0 and not isNil(var_591_2) and arg_588_1.var_.actorSpriteComps10030 then
				for iter_591_3, iter_591_4 in pairs(arg_588_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_591_4 then
						iter_591_4.color = arg_588_1.isInRecall_ and (arg_588_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_588_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_588_1.time_ and arg_588_1.time_ <= 0 + arg_591_0 then
				local var_591_5 = arg_588_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_591_5 then
					arg_588_1.var_.alphaOldValue10030 = var_591_5.alpha
					arg_588_1.var_.characterEffect10030 = var_591_5
				end

				arg_588_1.var_.alphaOldValue10030 = 0
			end

			local var_591_6 = 0.333333333333333

			if 0 <= arg_588_1.time_ and arg_588_1.time_ < 0 + var_591_6 then
				if arg_588_1.var_.characterEffect10030 then
					arg_588_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_588_1.var_.alphaOldValue10030, 1, (arg_588_1.time_ - 0) / var_591_6)
				end
			end

			if arg_588_1.time_ >= 0 + var_591_6 and arg_588_1.time_ < 0 + var_591_6 + arg_591_0 and arg_588_1.var_.characterEffect10030 then
				arg_588_1.var_.characterEffect10030.alpha = 1
			end

			local var_591_7 = 0
			local var_591_8 = 0.25

			if 0 < arg_588_1.time_ and arg_588_1.time_ <= var_591_7 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, true)

				arg_588_1.leftNameTxt_.text = arg_588_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_588_1.leftNameTxt_.transform)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1.leftNameTxt_.text)
				SetActive(arg_588_1.iconTrs_.gameObject, false)
				arg_588_1.callingController_:SetSelectedState("normal")

				local var_591_9 = arg_588_1:GetWordFromCfg(115301145)
				local var_591_10 = arg_588_1:FormatText(var_591_9.content)

				arg_588_1.text_.text = var_591_10

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_12 = 10 <= 0 and var_591_8 or var_591_8 * (utf8.len(var_591_10) / 10)

				if (10 <= 0 and var_591_8 or var_591_8 * (utf8.len(var_591_10) / 10)) > 0 and var_591_8 < var_591_12 then
					arg_588_1.talkMaxDuration = var_591_12

					if var_591_12 + var_591_7 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_12 + var_591_7
					end
				end

				arg_588_1.text_.text = var_591_10
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301145", "story_v_out_115301.awb") ~= 0 then
					local var_591_13 = manager.audio:GetVoiceLength("story_v_out_115301", "115301145", "story_v_out_115301.awb") / 1000

					if var_591_13 + var_591_7 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_13 + var_591_7
					end

					if var_591_9.prefab_name ~= "" and arg_588_1.actors_[var_591_9.prefab_name] ~= nil then
						local var_591_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_588_1.actors_[var_591_9.prefab_name].transform, "story_v_out_115301", "115301145", "story_v_out_115301.awb")

						arg_588_1:RecordAudio("115301145", var_591_14)
						arg_588_1:RecordAudio("115301145", var_591_14)
					else
						arg_588_1:AudioAction("play", "voice", "story_v_out_115301", "115301145", "story_v_out_115301.awb")
					end

					arg_588_1:RecordHistoryTalkVoice("story_v_out_115301", "115301145", "story_v_out_115301.awb")
				end

				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_15 = math.max(var_591_8, arg_588_1.talkMaxDuration)

			if var_591_7 <= arg_588_1.time_ and arg_588_1.time_ < var_591_7 + var_591_15 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - var_591_7) / var_591_15

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= var_591_7 + var_591_15 and arg_588_1.time_ < var_591_7 + var_591_15 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_588_1:InitPlayNodeList()
	end,
	Play115301146 = function(arg_592_0, arg_592_1)
		arg_592_1.time_ = 0
		arg_592_1.frameCnt_ = 0
		arg_592_1.state_ = "playing"
		arg_592_1.curTalkId_ = 115301146
		arg_592_1.duration_ = 5

		SetActive(arg_592_1.tipsGo_, false)

		function arg_592_1.onSingleLineFinish_()
			arg_592_1.onSingleLineUpdate_ = nil
			arg_592_1.onSingleLineFinish_ = nil
			arg_592_1.state_ = "waiting"
		end

		function arg_592_1.playNext_(arg_594_0)
			if arg_594_0 == 1 then
				arg_592_0:Play115301147(arg_592_1)
			end
		end

		function arg_592_1.onSingleLineUpdate_(arg_595_0)
			if 0 < arg_592_1.time_ and arg_592_1.time_ <= 0 + arg_595_0 then
				local var_595_0 = arg_592_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_595_0 then
					arg_592_1.var_.alphaOldValue10030 = var_595_0.alpha
					arg_592_1.var_.characterEffect10030 = var_595_0
				end

				arg_592_1.var_.alphaOldValue10030 = 1
			end

			local var_595_1 = 0.333333333333333

			if 0 <= arg_592_1.time_ and arg_592_1.time_ < 0 + var_595_1 then
				if arg_592_1.var_.characterEffect10030 then
					arg_592_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_592_1.var_.alphaOldValue10030, 0, (arg_592_1.time_ - 0) / var_595_1)
				end
			end

			if arg_592_1.time_ >= 0 + var_595_1 and arg_592_1.time_ < 0 + var_595_1 + arg_595_0 and arg_592_1.var_.characterEffect10030 then
				arg_592_1.var_.characterEffect10030.alpha = 0
			end

			local var_595_2 = 0
			local var_595_3 = 0.7

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= var_595_2 + arg_595_0 then
				arg_592_1.talkMaxDuration = 0
				arg_592_1.dialogCg_.alpha = 1

				arg_592_1.dialog_:SetActive(true)
				SetActive(arg_592_1.leftNameGo_, false)

				arg_592_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_592_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_592_1:RecordName(arg_592_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_592_1.iconTrs_.gameObject, false)
				arg_592_1.callingController_:SetSelectedState("normal")

				local var_595_4 = arg_592_1:FormatText(arg_592_1:GetWordFromCfg(115301146).content)

				arg_592_1.text_.text = var_595_4

				LuaForUtil.ClearLinePrefixSymbol(arg_592_1.text_)

				local var_595_6 = 28 <= 0 and var_595_3 or var_595_3 * (utf8.len(var_595_4) / 28)

				if (28 <= 0 and var_595_3 or var_595_3 * (utf8.len(var_595_4) / 28)) > 0 and var_595_3 < var_595_6 then
					arg_592_1.talkMaxDuration = var_595_6

					if var_595_6 + var_595_2 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_6 + var_595_2
					end
				end

				arg_592_1.text_.text = var_595_4
				arg_592_1.typewritter.percent = 0

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(false)
				arg_592_1:RecordContent(arg_592_1.text_.text)
			end

			local var_595_7 = math.max(var_595_3, arg_592_1.talkMaxDuration)

			if var_595_2 <= arg_592_1.time_ and arg_592_1.time_ < var_595_2 + var_595_7 then
				arg_592_1.typewritter.percent = (arg_592_1.time_ - var_595_2) / var_595_7

				arg_592_1.typewritter:SetDirty()
			end

			if arg_592_1.time_ >= var_595_2 + var_595_7 and arg_592_1.time_ < var_595_2 + var_595_7 + arg_595_0 then
				arg_592_1.typewritter.percent = 1

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(true)
			end
		end

		arg_592_1.nodeConfigList_ = {}

		arg_592_1:InitPlayNodeList()
	end,
	Play115301147 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 115301147
		arg_596_1.duration_ = 8

		local var_596_0 = {
			ja = 8,
			ko = 4.966,
			zh = 5.266,
			en = 4.9
		}
		local var_596_1 = manager.audio:GetLocalizationFlag()

		if var_596_0[var_596_1] ~= nil then
			arg_596_1.duration_ = var_596_0[var_596_1]
		end

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play115301148(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			if 0 < arg_596_1.time_ and arg_596_1.time_ <= 0 + arg_599_0 then
				arg_596_1.var_.moveOldPos10030 = arg_596_1.actors_["10030"].transform.localPosition
				arg_596_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_596_1:CheckSpriteTmpPos("10030", 3)

				for iter_599_0 = 0, arg_596_1.actors_["10030"].transform.childCount - 1 do
					local var_599_0 = arg_596_1.actors_["10030"].transform:GetChild(iter_599_0)

					if var_599_0.name == "split_3" or not string.find(var_599_0.name, "split") then
						var_599_0.gameObject:SetActive(true)
					else
						var_599_0.gameObject:SetActive(false)
					end
				end
			end

			local var_599_1 = 0.001

			if 0 <= arg_596_1.time_ and arg_596_1.time_ < 0 + var_599_1 then
				arg_596_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_596_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_596_1.time_ - 0) / var_599_1)
			end

			if arg_596_1.time_ >= 0 + var_599_1 and arg_596_1.time_ < 0 + var_599_1 + arg_599_0 then
				arg_596_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			if 0 < arg_596_1.time_ and arg_596_1.time_ <= 0 + arg_599_0 then
				local var_599_2 = arg_596_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_599_2 then
					arg_596_1.var_.alphaOldValue10030 = var_599_2.alpha
					arg_596_1.var_.characterEffect10030 = var_599_2
				end

				arg_596_1.var_.alphaOldValue10030 = 0
			end

			local var_599_3 = 0.333333333333333

			if 0 <= arg_596_1.time_ and arg_596_1.time_ < 0 + var_599_3 then
				if arg_596_1.var_.characterEffect10030 then
					arg_596_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_596_1.var_.alphaOldValue10030, 1, (arg_596_1.time_ - 0) / var_599_3)
				end
			end

			if arg_596_1.time_ >= 0 + var_599_3 and arg_596_1.time_ < 0 + var_599_3 + arg_599_0 and arg_596_1.var_.characterEffect10030 then
				arg_596_1.var_.characterEffect10030.alpha = 1
			end

			local var_599_4 = 0
			local var_599_5 = 0.45

			if 0 < arg_596_1.time_ and arg_596_1.time_ <= var_599_4 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0
				arg_596_1.dialogCg_.alpha = 1

				arg_596_1.dialog_:SetActive(true)
				SetActive(arg_596_1.leftNameGo_, true)

				arg_596_1.leftNameTxt_.text = arg_596_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_596_1.leftNameTxt_.transform)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1.leftNameTxt_.text)
				SetActive(arg_596_1.iconTrs_.gameObject, false)
				arg_596_1.callingController_:SetSelectedState("normal")

				local var_599_6 = arg_596_1:GetWordFromCfg(115301147)
				local var_599_7 = arg_596_1:FormatText(var_599_6.content)

				arg_596_1.text_.text = var_599_7

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_9 = 18 <= 0 and var_599_5 or var_599_5 * (utf8.len(var_599_7) / 18)

				if (18 <= 0 and var_599_5 or var_599_5 * (utf8.len(var_599_7) / 18)) > 0 and var_599_5 < var_599_9 then
					arg_596_1.talkMaxDuration = var_599_9

					if var_599_9 + var_599_4 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_9 + var_599_4
					end
				end

				arg_596_1.text_.text = var_599_7
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301147", "story_v_out_115301.awb") ~= 0 then
					local var_599_10 = manager.audio:GetVoiceLength("story_v_out_115301", "115301147", "story_v_out_115301.awb") / 1000

					if var_599_10 + var_599_4 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_10 + var_599_4
					end

					if var_599_6.prefab_name ~= "" and arg_596_1.actors_[var_599_6.prefab_name] ~= nil then
						local var_599_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_596_1.actors_[var_599_6.prefab_name].transform, "story_v_out_115301", "115301147", "story_v_out_115301.awb")

						arg_596_1:RecordAudio("115301147", var_599_11)
						arg_596_1:RecordAudio("115301147", var_599_11)
					else
						arg_596_1:AudioAction("play", "voice", "story_v_out_115301", "115301147", "story_v_out_115301.awb")
					end

					arg_596_1:RecordHistoryTalkVoice("story_v_out_115301", "115301147", "story_v_out_115301.awb")
				end

				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_12 = math.max(var_599_5, arg_596_1.talkMaxDuration)

			if var_599_4 <= arg_596_1.time_ and arg_596_1.time_ < var_599_4 + var_599_12 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - var_599_4) / var_599_12

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= var_599_4 + var_599_12 and arg_596_1.time_ < var_599_4 + var_599_12 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_596_1:InitPlayNodeList()
	end,
	Play115301148 = function(arg_600_0, arg_600_1)
		arg_600_1.time_ = 0
		arg_600_1.frameCnt_ = 0
		arg_600_1.state_ = "playing"
		arg_600_1.curTalkId_ = 115301148
		arg_600_1.duration_ = 5

		SetActive(arg_600_1.tipsGo_, false)

		function arg_600_1.onSingleLineFinish_()
			arg_600_1.onSingleLineUpdate_ = nil
			arg_600_1.onSingleLineFinish_ = nil
			arg_600_1.state_ = "waiting"
		end

		function arg_600_1.playNext_(arg_602_0)
			if arg_602_0 == 1 then
				arg_600_0:Play115301149(arg_600_1)
			end
		end

		function arg_600_1.onSingleLineUpdate_(arg_603_0)
			if 0 < arg_600_1.time_ and arg_600_1.time_ <= 0 + arg_603_0 then
				local var_603_0 = arg_600_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_603_0 then
					arg_600_1.var_.alphaOldValue10030 = var_603_0.alpha
					arg_600_1.var_.characterEffect10030 = var_603_0
				end

				arg_600_1.var_.alphaOldValue10030 = 1
			end

			local var_603_1 = 0.333333333333333

			if 0 <= arg_600_1.time_ and arg_600_1.time_ < 0 + var_603_1 then
				if arg_600_1.var_.characterEffect10030 then
					arg_600_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_600_1.var_.alphaOldValue10030, 0, (arg_600_1.time_ - 0) / var_603_1)
				end
			end

			if arg_600_1.time_ >= 0 + var_603_1 and arg_600_1.time_ < 0 + var_603_1 + arg_603_0 and arg_600_1.var_.characterEffect10030 then
				arg_600_1.var_.characterEffect10030.alpha = 0
			end

			local var_603_2 = 0
			local var_603_3 = 0.75

			if 0 < arg_600_1.time_ and arg_600_1.time_ <= var_603_2 + arg_603_0 then
				arg_600_1.talkMaxDuration = 0
				arg_600_1.dialogCg_.alpha = 1

				arg_600_1.dialog_:SetActive(true)
				SetActive(arg_600_1.leftNameGo_, false)

				arg_600_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_600_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_600_1:RecordName(arg_600_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_600_1.iconTrs_.gameObject, false)
				arg_600_1.callingController_:SetSelectedState("normal")

				local var_603_4 = arg_600_1:FormatText(arg_600_1:GetWordFromCfg(115301148).content)

				arg_600_1.text_.text = var_603_4

				LuaForUtil.ClearLinePrefixSymbol(arg_600_1.text_)

				local var_603_6 = 30 <= 0 and var_603_3 or var_603_3 * (utf8.len(var_603_4) / 30)

				if (30 <= 0 and var_603_3 or var_603_3 * (utf8.len(var_603_4) / 30)) > 0 and var_603_3 < var_603_6 then
					arg_600_1.talkMaxDuration = var_603_6

					if var_603_6 + var_603_2 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_6 + var_603_2
					end
				end

				arg_600_1.text_.text = var_603_4
				arg_600_1.typewritter.percent = 0

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(false)
				arg_600_1:RecordContent(arg_600_1.text_.text)
			end

			local var_603_7 = math.max(var_603_3, arg_600_1.talkMaxDuration)

			if var_603_2 <= arg_600_1.time_ and arg_600_1.time_ < var_603_2 + var_603_7 then
				arg_600_1.typewritter.percent = (arg_600_1.time_ - var_603_2) / var_603_7

				arg_600_1.typewritter:SetDirty()
			end

			if arg_600_1.time_ >= var_603_2 + var_603_7 and arg_600_1.time_ < var_603_2 + var_603_7 + arg_603_0 then
				arg_600_1.typewritter.percent = 1

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(true)
			end
		end

		arg_600_1.nodeConfigList_ = {}

		arg_600_1:InitPlayNodeList()
	end,
	Play115301149 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 115301149
		arg_604_1.duration_ = 3.4

		local var_604_0 = {
			ja = 3.4,
			ko = 1.9,
			zh = 1.666,
			en = 2.866
		}
		local var_604_1 = manager.audio:GetLocalizationFlag()

		if var_604_0[var_604_1] ~= nil then
			arg_604_1.duration_ = var_604_0[var_604_1]
		end

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
		end

		function arg_604_1.playNext_(arg_606_0)
			if arg_606_0 == 1 then
				arg_604_0:Play115301150(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			if 0 < arg_604_1.time_ and arg_604_1.time_ <= 0 + arg_607_0 then
				arg_604_1.var_.moveOldPos10030 = arg_604_1.actors_["10030"].transform.localPosition
				arg_604_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_604_1:CheckSpriteTmpPos("10030", 3)

				for iter_607_0 = 0, arg_604_1.actors_["10030"].transform.childCount - 1 do
					local var_607_0 = arg_604_1.actors_["10030"].transform:GetChild(iter_607_0)

					if var_607_0.name == "split_3" or not string.find(var_607_0.name, "split") then
						var_607_0.gameObject:SetActive(true)
					else
						var_607_0.gameObject:SetActive(false)
					end
				end
			end

			local var_607_1 = 0.001

			if 0 <= arg_604_1.time_ and arg_604_1.time_ < 0 + var_607_1 then
				arg_604_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_604_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_604_1.time_ - 0) / var_607_1)
			end

			if arg_604_1.time_ >= 0 + var_607_1 and arg_604_1.time_ < 0 + var_607_1 + arg_607_0 then
				arg_604_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			if 0 < arg_604_1.time_ and arg_604_1.time_ <= 0 + arg_607_0 then
				local var_607_2 = arg_604_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_607_2 then
					arg_604_1.var_.alphaOldValue10030 = var_607_2.alpha
					arg_604_1.var_.characterEffect10030 = var_607_2
				end

				arg_604_1.var_.alphaOldValue10030 = 0
			end

			local var_607_3 = 0.333333333333333

			if 0 <= arg_604_1.time_ and arg_604_1.time_ < 0 + var_607_3 then
				if arg_604_1.var_.characterEffect10030 then
					arg_604_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_604_1.var_.alphaOldValue10030, 1, (arg_604_1.time_ - 0) / var_607_3)
				end
			end

			if arg_604_1.time_ >= 0 + var_607_3 and arg_604_1.time_ < 0 + var_607_3 + arg_607_0 and arg_604_1.var_.characterEffect10030 then
				arg_604_1.var_.characterEffect10030.alpha = 1
			end

			local var_607_4 = 0
			local var_607_5 = 0.15

			if 0 < arg_604_1.time_ and arg_604_1.time_ <= var_607_4 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, true)

				arg_604_1.leftNameTxt_.text = arg_604_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_604_1.leftNameTxt_.transform)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1.leftNameTxt_.text)
				SetActive(arg_604_1.iconTrs_.gameObject, false)
				arg_604_1.callingController_:SetSelectedState("normal")

				local var_607_6 = arg_604_1:GetWordFromCfg(115301149)
				local var_607_7 = arg_604_1:FormatText(var_607_6.content)

				arg_604_1.text_.text = var_607_7

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_9 = 6 <= 0 and var_607_5 or var_607_5 * (utf8.len(var_607_7) / 6)

				if (6 <= 0 and var_607_5 or var_607_5 * (utf8.len(var_607_7) / 6)) > 0 and var_607_5 < var_607_9 then
					arg_604_1.talkMaxDuration = var_607_9

					if var_607_9 + var_607_4 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_9 + var_607_4
					end
				end

				arg_604_1.text_.text = var_607_7
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301149", "story_v_out_115301.awb") ~= 0 then
					local var_607_10 = manager.audio:GetVoiceLength("story_v_out_115301", "115301149", "story_v_out_115301.awb") / 1000

					if var_607_10 + var_607_4 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_10 + var_607_4
					end

					if var_607_6.prefab_name ~= "" and arg_604_1.actors_[var_607_6.prefab_name] ~= nil then
						local var_607_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_604_1.actors_[var_607_6.prefab_name].transform, "story_v_out_115301", "115301149", "story_v_out_115301.awb")

						arg_604_1:RecordAudio("115301149", var_607_11)
						arg_604_1:RecordAudio("115301149", var_607_11)
					else
						arg_604_1:AudioAction("play", "voice", "story_v_out_115301", "115301149", "story_v_out_115301.awb")
					end

					arg_604_1:RecordHistoryTalkVoice("story_v_out_115301", "115301149", "story_v_out_115301.awb")
				end

				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_12 = math.max(var_607_5, arg_604_1.talkMaxDuration)

			if var_607_4 <= arg_604_1.time_ and arg_604_1.time_ < var_607_4 + var_607_12 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - var_607_4) / var_607_12

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= var_607_4 + var_607_12 and arg_604_1.time_ < var_607_4 + var_607_12 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_604_1:InitPlayNodeList()
	end,
	Play115301150 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 115301150
		arg_608_1.duration_ = 5

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play115301151(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			if 0 < arg_608_1.time_ and arg_608_1.time_ <= 0 + arg_611_0 then
				local var_611_0 = arg_608_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_611_0 then
					arg_608_1.var_.alphaOldValue10030 = var_611_0.alpha
					arg_608_1.var_.characterEffect10030 = var_611_0
				end

				arg_608_1.var_.alphaOldValue10030 = 1
			end

			local var_611_1 = 0.333333333333333

			if 0 <= arg_608_1.time_ and arg_608_1.time_ < 0 + var_611_1 then
				if arg_608_1.var_.characterEffect10030 then
					arg_608_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_608_1.var_.alphaOldValue10030, 0, (arg_608_1.time_ - 0) / var_611_1)
				end
			end

			if arg_608_1.time_ >= 0 + var_611_1 and arg_608_1.time_ < 0 + var_611_1 + arg_611_0 and arg_608_1.var_.characterEffect10030 then
				arg_608_1.var_.characterEffect10030.alpha = 0
			end

			local var_611_2 = 0
			local var_611_3 = 0.875

			if 0 < arg_608_1.time_ and arg_608_1.time_ <= var_611_2 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0
				arg_608_1.dialogCg_.alpha = 1

				arg_608_1.dialog_:SetActive(true)
				SetActive(arg_608_1.leftNameGo_, false)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_608_1.iconTrs_.gameObject, false)
				arg_608_1.callingController_:SetSelectedState("normal")

				local var_611_4 = arg_608_1:FormatText(arg_608_1:GetWordFromCfg(115301150).content)

				arg_608_1.text_.text = var_611_4

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_6 = 35 <= 0 and var_611_3 or var_611_3 * (utf8.len(var_611_4) / 35)

				if (35 <= 0 and var_611_3 or var_611_3 * (utf8.len(var_611_4) / 35)) > 0 and var_611_3 < var_611_6 then
					arg_608_1.talkMaxDuration = var_611_6

					if var_611_6 + var_611_2 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_6 + var_611_2
					end
				end

				arg_608_1.text_.text = var_611_4
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)
				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_7 = math.max(var_611_3, arg_608_1.talkMaxDuration)

			if var_611_2 <= arg_608_1.time_ and arg_608_1.time_ < var_611_2 + var_611_7 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - var_611_2) / var_611_7

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= var_611_2 + var_611_7 and arg_608_1.time_ < var_611_2 + var_611_7 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {}

		arg_608_1:InitPlayNodeList()
	end,
	Play115301151 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 115301151
		arg_612_1.duration_ = 5.17

		local var_612_0 = {
			ja = 3.866,
			ko = 5.166,
			zh = 4.6,
			en = 4.466
		}
		local var_612_1 = manager.audio:GetLocalizationFlag()

		if var_612_0[var_612_1] ~= nil then
			arg_612_1.duration_ = var_612_0[var_612_1]
		end

		SetActive(arg_612_1.tipsGo_, false)

		function arg_612_1.onSingleLineFinish_()
			arg_612_1.onSingleLineUpdate_ = nil
			arg_612_1.onSingleLineFinish_ = nil
			arg_612_1.state_ = "waiting"
		end

		function arg_612_1.playNext_(arg_614_0)
			if arg_614_0 == 1 then
				arg_612_0:Play115301152(arg_612_1)
			end
		end

		function arg_612_1.onSingleLineUpdate_(arg_615_0)
			if 0 < arg_612_1.time_ and arg_612_1.time_ <= 0 + arg_615_0 then
				arg_612_1.var_.moveOldPos10030 = arg_612_1.actors_["10030"].transform.localPosition
				arg_612_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_612_1:CheckSpriteTmpPos("10030", 3)

				for iter_615_0 = 0, arg_612_1.actors_["10030"].transform.childCount - 1 do
					local var_615_0 = arg_612_1.actors_["10030"].transform:GetChild(iter_615_0)

					if var_615_0.name == "split_2" or not string.find(var_615_0.name, "split") then
						var_615_0.gameObject:SetActive(true)
					else
						var_615_0.gameObject:SetActive(false)
					end
				end
			end

			local var_615_1 = 0.001

			if 0 <= arg_612_1.time_ and arg_612_1.time_ < 0 + var_615_1 then
				arg_612_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_612_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_612_1.time_ - 0) / var_615_1)
			end

			if arg_612_1.time_ >= 0 + var_615_1 and arg_612_1.time_ < 0 + var_615_1 + arg_615_0 then
				arg_612_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			if 0 < arg_612_1.time_ and arg_612_1.time_ <= 0 + arg_615_0 then
				local var_615_2 = arg_612_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_615_2 then
					arg_612_1.var_.alphaOldValue10030 = var_615_2.alpha
					arg_612_1.var_.characterEffect10030 = var_615_2
				end

				arg_612_1.var_.alphaOldValue10030 = 0
			end

			local var_615_3 = 0.333333333333333

			if 0 <= arg_612_1.time_ and arg_612_1.time_ < 0 + var_615_3 then
				if arg_612_1.var_.characterEffect10030 then
					arg_612_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_612_1.var_.alphaOldValue10030, 1, (arg_612_1.time_ - 0) / var_615_3)
				end
			end

			if arg_612_1.time_ >= 0 + var_615_3 and arg_612_1.time_ < 0 + var_615_3 + arg_615_0 and arg_612_1.var_.characterEffect10030 then
				arg_612_1.var_.characterEffect10030.alpha = 1
			end

			local var_615_4 = 0
			local var_615_5 = 0.275

			if 0 < arg_612_1.time_ and arg_612_1.time_ <= var_615_4 + arg_615_0 then
				arg_612_1.talkMaxDuration = 0
				arg_612_1.dialogCg_.alpha = 1

				arg_612_1.dialog_:SetActive(true)
				SetActive(arg_612_1.leftNameGo_, true)

				arg_612_1.leftNameTxt_.text = arg_612_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_612_1.leftNameTxt_.transform)

				arg_612_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_612_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_612_1:RecordName(arg_612_1.leftNameTxt_.text)
				SetActive(arg_612_1.iconTrs_.gameObject, false)
				arg_612_1.callingController_:SetSelectedState("normal")

				local var_615_6 = arg_612_1:GetWordFromCfg(115301151)
				local var_615_7 = arg_612_1:FormatText(var_615_6.content)

				arg_612_1.text_.text = var_615_7

				LuaForUtil.ClearLinePrefixSymbol(arg_612_1.text_)

				local var_615_9 = 11 <= 0 and var_615_5 or var_615_5 * (utf8.len(var_615_7) / 11)

				if (11 <= 0 and var_615_5 or var_615_5 * (utf8.len(var_615_7) / 11)) > 0 and var_615_5 < var_615_9 then
					arg_612_1.talkMaxDuration = var_615_9

					if var_615_9 + var_615_4 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_9 + var_615_4
					end
				end

				arg_612_1.text_.text = var_615_7
				arg_612_1.typewritter.percent = 0

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301151", "story_v_out_115301.awb") ~= 0 then
					local var_615_10 = manager.audio:GetVoiceLength("story_v_out_115301", "115301151", "story_v_out_115301.awb") / 1000

					if var_615_10 + var_615_4 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_10 + var_615_4
					end

					if var_615_6.prefab_name ~= "" and arg_612_1.actors_[var_615_6.prefab_name] ~= nil then
						local var_615_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_612_1.actors_[var_615_6.prefab_name].transform, "story_v_out_115301", "115301151", "story_v_out_115301.awb")

						arg_612_1:RecordAudio("115301151", var_615_11)
						arg_612_1:RecordAudio("115301151", var_615_11)
					else
						arg_612_1:AudioAction("play", "voice", "story_v_out_115301", "115301151", "story_v_out_115301.awb")
					end

					arg_612_1:RecordHistoryTalkVoice("story_v_out_115301", "115301151", "story_v_out_115301.awb")
				end

				arg_612_1:RecordContent(arg_612_1.text_.text)
			end

			local var_615_12 = math.max(var_615_5, arg_612_1.talkMaxDuration)

			if var_615_4 <= arg_612_1.time_ and arg_612_1.time_ < var_615_4 + var_615_12 then
				arg_612_1.typewritter.percent = (arg_612_1.time_ - var_615_4) / var_615_12

				arg_612_1.typewritter:SetDirty()
			end

			if arg_612_1.time_ >= var_615_4 + var_615_12 and arg_612_1.time_ < var_615_4 + var_615_12 + arg_615_0 then
				arg_612_1.typewritter.percent = 1

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(true)
			end
		end

		arg_612_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_612_1:InitPlayNodeList()
	end,
	Play115301152 = function(arg_616_0, arg_616_1)
		arg_616_1.time_ = 0
		arg_616_1.frameCnt_ = 0
		arg_616_1.state_ = "playing"
		arg_616_1.curTalkId_ = 115301152
		arg_616_1.duration_ = 5

		SetActive(arg_616_1.tipsGo_, false)

		function arg_616_1.onSingleLineFinish_()
			arg_616_1.onSingleLineUpdate_ = nil
			arg_616_1.onSingleLineFinish_ = nil
			arg_616_1.state_ = "waiting"
		end

		function arg_616_1.playNext_(arg_618_0)
			if arg_618_0 == 1 then
				arg_616_0:Play115301153(arg_616_1)
			end
		end

		function arg_616_1.onSingleLineUpdate_(arg_619_0)
			if 0 < arg_616_1.time_ and arg_616_1.time_ <= 0 + arg_619_0 then
				local var_619_0 = arg_616_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_619_0 then
					arg_616_1.var_.alphaOldValue10030 = var_619_0.alpha
					arg_616_1.var_.characterEffect10030 = var_619_0
				end

				arg_616_1.var_.alphaOldValue10030 = 1
			end

			local var_619_1 = 0.333333333333333

			if 0 <= arg_616_1.time_ and arg_616_1.time_ < 0 + var_619_1 then
				if arg_616_1.var_.characterEffect10030 then
					arg_616_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_616_1.var_.alphaOldValue10030, 0, (arg_616_1.time_ - 0) / var_619_1)
				end
			end

			if arg_616_1.time_ >= 0 + var_619_1 and arg_616_1.time_ < 0 + var_619_1 + arg_619_0 and arg_616_1.var_.characterEffect10030 then
				arg_616_1.var_.characterEffect10030.alpha = 0
			end

			local var_619_2 = 0
			local var_619_3 = 0.8

			if 0 < arg_616_1.time_ and arg_616_1.time_ <= var_619_2 + arg_619_0 then
				arg_616_1.talkMaxDuration = 0
				arg_616_1.dialogCg_.alpha = 1

				arg_616_1.dialog_:SetActive(true)
				SetActive(arg_616_1.leftNameGo_, false)

				arg_616_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_616_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_616_1:RecordName(arg_616_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_616_1.iconTrs_.gameObject, false)
				arg_616_1.callingController_:SetSelectedState("normal")

				local var_619_4 = arg_616_1:FormatText(arg_616_1:GetWordFromCfg(115301152).content)

				arg_616_1.text_.text = var_619_4

				LuaForUtil.ClearLinePrefixSymbol(arg_616_1.text_)

				local var_619_6 = 32 <= 0 and var_619_3 or var_619_3 * (utf8.len(var_619_4) / 32)

				if (32 <= 0 and var_619_3 or var_619_3 * (utf8.len(var_619_4) / 32)) > 0 and var_619_3 < var_619_6 then
					arg_616_1.talkMaxDuration = var_619_6

					if var_619_6 + var_619_2 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_6 + var_619_2
					end
				end

				arg_616_1.text_.text = var_619_4
				arg_616_1.typewritter.percent = 0

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(false)
				arg_616_1:RecordContent(arg_616_1.text_.text)
			end

			local var_619_7 = math.max(var_619_3, arg_616_1.talkMaxDuration)

			if var_619_2 <= arg_616_1.time_ and arg_616_1.time_ < var_619_2 + var_619_7 then
				arg_616_1.typewritter.percent = (arg_616_1.time_ - var_619_2) / var_619_7

				arg_616_1.typewritter:SetDirty()
			end

			if arg_616_1.time_ >= var_619_2 + var_619_7 and arg_616_1.time_ < var_619_2 + var_619_7 + arg_619_0 then
				arg_616_1.typewritter.percent = 1

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(true)
			end
		end

		arg_616_1.nodeConfigList_ = {}

		arg_616_1:InitPlayNodeList()
	end,
	Play115301153 = function(arg_620_0, arg_620_1)
		arg_620_1.time_ = 0
		arg_620_1.frameCnt_ = 0
		arg_620_1.state_ = "playing"
		arg_620_1.curTalkId_ = 115301153
		arg_620_1.duration_ = 10.13

		local var_620_0 = {
			ja = 6.3,
			ko = 6.9,
			zh = 8.566,
			en = 10.133
		}
		local var_620_1 = manager.audio:GetLocalizationFlag()

		if var_620_0[var_620_1] ~= nil then
			arg_620_1.duration_ = var_620_0[var_620_1]
		end

		SetActive(arg_620_1.tipsGo_, false)

		function arg_620_1.onSingleLineFinish_()
			arg_620_1.onSingleLineUpdate_ = nil
			arg_620_1.onSingleLineFinish_ = nil
			arg_620_1.state_ = "waiting"
		end

		function arg_620_1.playNext_(arg_622_0)
			if arg_622_0 == 1 then
				arg_620_0:Play115301154(arg_620_1)
			end
		end

		function arg_620_1.onSingleLineUpdate_(arg_623_0)
			if arg_620_1.bgs_.F01a == nil then
				local var_623_0 = Object.Instantiate(arg_620_1.paintGo_)

				var_623_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F01a")
				var_623_0.name = "F01a"
				var_623_0.transform.parent = arg_620_1.stage_.transform
				var_623_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_620_1.bgs_.F01a = var_623_0
			end

			if 2 < arg_620_1.time_ and arg_620_1.time_ <= 2 + arg_623_0 then
				local var_623_1 = arg_620_1.bgs_.F01a

				arg_620_1.bgs_.F01a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_623_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_623_2 = var_623_1:GetComponent("SpriteRenderer")

				if var_623_2 and var_623_2.sprite then
					local var_623_3 = 2 * (var_623_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_623_1.transform.localScale = Vector3.New(var_623_3 / var_623_2.sprite.bounds.size.y < var_623_3 * manager.ui.mainCameraCom_.aspect / var_623_2.sprite.bounds.size.x and var_623_3 * manager.ui.mainCameraCom_.aspect / var_623_2.sprite.bounds.size.x or var_623_3 / var_623_2.sprite.bounds.size.y, var_623_3 / var_623_2.sprite.bounds.size.y < var_623_3 * manager.ui.mainCameraCom_.aspect / var_623_2.sprite.bounds.size.x and var_623_3 * manager.ui.mainCameraCom_.aspect / var_623_2.sprite.bounds.size.x or var_623_3 / var_623_2.sprite.bounds.size.y, 0)
				end

				for iter_623_0, iter_623_1 in pairs(arg_620_1.bgs_) do
					if iter_623_0 ~= "F01a" then
						iter_623_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_623_4 = 0

			if 0 < arg_620_1.time_ and arg_620_1.time_ <= var_623_4 + arg_623_0 then
				arg_620_1.mask_.enabled = true
				arg_620_1.mask_.raycastTarget = false

				arg_620_1:SetGaussion(false)
			end

			local var_623_5 = 2

			if var_623_4 <= arg_620_1.time_ and arg_620_1.time_ < var_623_4 + var_623_5 then
				local var_623_6 = Color.New(0, 0, 0)

				var_623_6.a = Mathf.Lerp(0, 1, (arg_620_1.time_ - var_623_4) / var_623_5)
				arg_620_1.mask_.color = var_623_6
			end

			if arg_620_1.time_ >= var_623_4 + var_623_5 and arg_620_1.time_ < var_623_4 + var_623_5 + arg_623_0 then
				local var_623_7 = Color.New(0, 0, 0)

				var_623_7.a = 1
				arg_620_1.mask_.color = var_623_7
			end

			local var_623_8 = 2

			if 2 < arg_620_1.time_ and arg_620_1.time_ <= var_623_8 + arg_623_0 then
				arg_620_1.mask_.enabled = true
				arg_620_1.mask_.raycastTarget = false

				arg_620_1:SetGaussion(false)
			end

			local var_623_9 = 2

			if var_623_8 <= arg_620_1.time_ and arg_620_1.time_ < var_623_8 + var_623_9 then
				local var_623_10 = Color.New(0, 0, 0)

				var_623_10.a = Mathf.Lerp(1, 0, (arg_620_1.time_ - var_623_8) / var_623_9)
				arg_620_1.mask_.color = var_623_10
			end

			if arg_620_1.time_ >= var_623_8 + var_623_9 and arg_620_1.time_ < var_623_8 + var_623_9 + arg_623_0 then
				local var_623_11 = Color.New(0, 0, 0)

				arg_620_1.mask_.enabled = false
				var_623_11.a = 0
				arg_620_1.mask_.color = var_623_11
			end

			local var_623_12 = arg_620_1.actors_["1038"].transform

			if 4 < arg_620_1.time_ and arg_620_1.time_ <= 4 + arg_623_0 then
				arg_620_1.var_.moveOldPos1038 = var_623_12.localPosition
				var_623_12.localScale = Vector3.New(1, 1, 1)

				arg_620_1:CheckSpriteTmpPos("1038", 3)

				for iter_623_2 = 0, var_623_12.childCount - 1 do
					local var_623_13 = var_623_12:GetChild(iter_623_2)

					if var_623_13.name == "split_5" or not string.find(var_623_13.name, "split") then
						var_623_13.gameObject:SetActive(true)
					else
						var_623_13.gameObject:SetActive(false)
					end
				end
			end

			local var_623_14 = 0.001

			if 4 <= arg_620_1.time_ and arg_620_1.time_ < 4 + var_623_14 then
				var_623_12.localPosition = Vector3.Lerp(arg_620_1.var_.moveOldPos1038, Vector3.New(0, -400, 0), (arg_620_1.time_ - 4) / var_623_14)
			end

			if arg_620_1.time_ >= 4 + var_623_14 and arg_620_1.time_ < 4 + var_623_14 + arg_623_0 then
				var_623_12.localPosition = Vector3.New(0, -400, 0)
			end

			local var_623_15 = 0

			arg_620_1.isInRecall_ = false

			if var_623_15 < arg_620_1.time_ and arg_620_1.time_ <= var_623_15 + arg_623_0 then
				arg_620_1.screenFilterGo_:SetActive(true)

				arg_620_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_623_3, iter_623_4 in pairs(arg_620_1.actors_) do
					for iter_623_5, iter_623_6 in ipairs((iter_623_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_623_6.color = iter_623_6.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_623_16 = 5.5

			if var_623_15 <= arg_620_1.time_ and arg_620_1.time_ < var_623_15 + var_623_16 then
				arg_620_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_620_1.time_ - var_623_15) / var_623_16)
			end

			if arg_620_1.time_ >= var_623_15 + var_623_16 and arg_620_1.time_ < var_623_15 + var_623_16 + arg_623_0 then
				arg_620_1.screenFilterEffect_.weight = 1
			end

			if 4 < arg_620_1.time_ and arg_620_1.time_ <= 4 + arg_623_0 then
				local var_623_17 = arg_620_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_623_17 then
					arg_620_1.var_.alphaOldValue1038 = var_623_17.alpha
					arg_620_1.var_.characterEffect1038 = var_623_17
				end

				arg_620_1.var_.alphaOldValue1038 = 0
			end

			local var_623_18 = 0.333333333333333

			if 4 <= arg_620_1.time_ and arg_620_1.time_ < 4 + var_623_18 then
				if arg_620_1.var_.characterEffect1038 then
					arg_620_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_620_1.var_.alphaOldValue1038, 1, (arg_620_1.time_ - 4) / var_623_18)
				end
			end

			if arg_620_1.time_ >= 4 + var_623_18 and arg_620_1.time_ < 4 + var_623_18 + arg_623_0 and arg_620_1.var_.characterEffect1038 then
				arg_620_1.var_.characterEffect1038.alpha = 1
			end

			if arg_620_1.frameCnt_ <= 1 then
				arg_620_1.dialog_:SetActive(false)
			end

			local var_623_19 = 4
			local var_623_20 = 0.3

			if 4 < arg_620_1.time_ and arg_620_1.time_ <= var_623_19 + arg_623_0 then
				arg_620_1.talkMaxDuration = 0

				arg_620_1.dialog_:SetActive(true)

				arg_620_1.dialogCg_.alpha = 0

				local var_623_21 = LeanTween.value(arg_620_1.dialog_, 0, 1, 0.3)

				var_623_21:setOnUpdate(LuaHelper.FloatAction(function(arg_624_0)
					arg_620_1.dialogCg_.alpha = arg_624_0
				end))
				var_623_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_620_1.dialog_)
					var_623_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_620_1.duration_ = arg_620_1.duration_ + 0.3

				SetActive(arg_620_1.leftNameGo_, true)

				arg_620_1.leftNameTxt_.text = arg_620_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_620_1.leftNameTxt_.transform)

				arg_620_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_620_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_620_1:RecordName(arg_620_1.leftNameTxt_.text)
				SetActive(arg_620_1.iconTrs_.gameObject, false)
				arg_620_1.callingController_:SetSelectedState("normal")

				local var_623_22 = arg_620_1:GetWordFromCfg(115301153)
				local var_623_23 = arg_620_1:FormatText(var_623_22.content)

				arg_620_1.text_.text = var_623_23

				LuaForUtil.ClearLinePrefixSymbol(arg_620_1.text_)

				local var_623_25 = 12 <= 0 and var_623_20 or var_623_20 * (utf8.len(var_623_23) / 12)

				if (12 <= 0 and var_623_20 or var_623_20 * (utf8.len(var_623_23) / 12)) > 0 and var_623_20 < var_623_25 then
					arg_620_1.talkMaxDuration = var_623_25
					var_623_19 = var_623_19 + 0.3

					if var_623_25 + var_623_19 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_25 + var_623_19
					end
				end

				arg_620_1.text_.text = var_623_23
				arg_620_1.typewritter.percent = 0

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301153", "story_v_out_115301.awb") ~= 0 then
					local var_623_26 = manager.audio:GetVoiceLength("story_v_out_115301", "115301153", "story_v_out_115301.awb") / 1000

					if var_623_26 + var_623_19 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_26 + var_623_19
					end

					if var_623_22.prefab_name ~= "" and arg_620_1.actors_[var_623_22.prefab_name] ~= nil then
						local var_623_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_620_1.actors_[var_623_22.prefab_name].transform, "story_v_out_115301", "115301153", "story_v_out_115301.awb")

						arg_620_1:RecordAudio("115301153", var_623_27)
						arg_620_1:RecordAudio("115301153", var_623_27)
					else
						arg_620_1:AudioAction("play", "voice", "story_v_out_115301", "115301153", "story_v_out_115301.awb")
					end

					arg_620_1:RecordHistoryTalkVoice("story_v_out_115301", "115301153", "story_v_out_115301.awb")
				end

				arg_620_1:RecordContent(arg_620_1.text_.text)
			end

			local var_623_28 = var_623_19 + 0.3
			local var_623_29 = math.max(var_623_20, arg_620_1.talkMaxDuration)

			if var_623_19 + 0.3 <= arg_620_1.time_ and arg_620_1.time_ < var_623_28 + var_623_29 then
				arg_620_1.typewritter.percent = (arg_620_1.time_ - var_623_28) / var_623_29

				arg_620_1.typewritter:SetDirty()
			end

			if arg_620_1.time_ >= var_623_28 + var_623_29 and arg_620_1.time_ < var_623_28 + var_623_29 + arg_623_0 then
				arg_620_1.typewritter.percent = 1

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(true)
			end
		end

		arg_620_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_620_1:InitPlayNodeList()
	end,
	Play115301154 = function(arg_626_0, arg_626_1)
		arg_626_1.time_ = 0
		arg_626_1.frameCnt_ = 0
		arg_626_1.state_ = "playing"
		arg_626_1.curTalkId_ = 115301154
		arg_626_1.duration_ = 6.4

		local var_626_0 = {
			ja = 3.766,
			ko = 5.433,
			zh = 5.833,
			en = 6.4
		}
		local var_626_1 = manager.audio:GetLocalizationFlag()

		if var_626_0[var_626_1] ~= nil then
			arg_626_1.duration_ = var_626_0[var_626_1]
		end

		SetActive(arg_626_1.tipsGo_, false)

		function arg_626_1.onSingleLineFinish_()
			arg_626_1.onSingleLineUpdate_ = nil
			arg_626_1.onSingleLineFinish_ = nil
			arg_626_1.state_ = "waiting"
		end

		function arg_626_1.playNext_(arg_628_0)
			if arg_628_0 == 1 then
				arg_626_0:Play115301155(arg_626_1)
			end
		end

		function arg_626_1.onSingleLineUpdate_(arg_629_0)
			if 0 < arg_626_1.time_ and arg_626_1.time_ <= 0 + arg_629_0 and not isNil(arg_626_1.actors_["1038"]) and arg_626_1.var_.actorSpriteComps1038 == nil then
				arg_626_1.var_.actorSpriteComps1038 = arg_626_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_629_0 = 0.2

			if 0 <= arg_626_1.time_ and arg_626_1.time_ < 0 + var_629_0 and not isNil(arg_626_1.actors_["1038"]) then
				if arg_626_1.var_.actorSpriteComps1038 then
					for iter_629_0, iter_629_1 in pairs(arg_626_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_629_1 then
							if arg_626_1.isInRecall_ then
								iter_629_1.color = Color.New(Mathf.Lerp(iter_629_1.color.r, arg_626_1.hightColor2.r, (arg_626_1.time_ - 0) / var_629_0), Mathf.Lerp(iter_629_1.color.g, arg_626_1.hightColor2.g, (arg_626_1.time_ - 0) / var_629_0), (Mathf.Lerp(iter_629_1.color.b, arg_626_1.hightColor2.b, (arg_626_1.time_ - 0) / var_629_0)))
							else
								local var_629_1 = Mathf.Lerp(iter_629_1.color.r, 0.5, (arg_626_1.time_ - 0) / var_629_0)

								iter_629_1.color = Color.New(var_629_1, var_629_1, var_629_1)
							end
						end
					end
				end
			end

			if arg_626_1.time_ >= 0 + var_629_0 and arg_626_1.time_ < 0 + var_629_0 + arg_629_0 and not isNil(arg_626_1.actors_["1038"]) and arg_626_1.var_.actorSpriteComps1038 then
				for iter_629_2, iter_629_3 in pairs(arg_626_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_629_3 then
						iter_629_3.color = arg_626_1.isInRecall_ and (arg_626_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_626_1.var_.actorSpriteComps1038 = nil
			end

			local var_629_2 = 0
			local var_629_3 = 0.475

			if 0 < arg_626_1.time_ and arg_626_1.time_ <= var_629_2 + arg_629_0 then
				arg_626_1.talkMaxDuration = 0
				arg_626_1.dialogCg_.alpha = 1

				arg_626_1.dialog_:SetActive(true)
				SetActive(arg_626_1.leftNameGo_, true)

				arg_626_1.leftNameTxt_.text = arg_626_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_626_1.leftNameTxt_.transform)

				arg_626_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_626_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_626_1:RecordName(arg_626_1.leftNameTxt_.text)
				SetActive(arg_626_1.iconTrs_.gameObject, false)
				arg_626_1.callingController_:SetSelectedState("normal")

				local var_629_4 = arg_626_1:GetWordFromCfg(115301154)
				local var_629_5 = arg_626_1:FormatText(var_629_4.content)

				arg_626_1.text_.text = var_629_5

				LuaForUtil.ClearLinePrefixSymbol(arg_626_1.text_)

				local var_629_7 = 19 <= 0 and var_629_3 or var_629_3 * (utf8.len(var_629_5) / 19)

				if (19 <= 0 and var_629_3 or var_629_3 * (utf8.len(var_629_5) / 19)) > 0 and var_629_3 < var_629_7 then
					arg_626_1.talkMaxDuration = var_629_7

					if var_629_7 + var_629_2 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_7 + var_629_2
					end
				end

				arg_626_1.text_.text = var_629_5
				arg_626_1.typewritter.percent = 0

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301154", "story_v_out_115301.awb") ~= 0 then
					local var_629_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301154", "story_v_out_115301.awb") / 1000

					if var_629_8 + var_629_2 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_8 + var_629_2
					end

					if var_629_4.prefab_name ~= "" and arg_626_1.actors_[var_629_4.prefab_name] ~= nil then
						local var_629_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_626_1.actors_[var_629_4.prefab_name].transform, "story_v_out_115301", "115301154", "story_v_out_115301.awb")

						arg_626_1:RecordAudio("115301154", var_629_9)
						arg_626_1:RecordAudio("115301154", var_629_9)
					else
						arg_626_1:AudioAction("play", "voice", "story_v_out_115301", "115301154", "story_v_out_115301.awb")
					end

					arg_626_1:RecordHistoryTalkVoice("story_v_out_115301", "115301154", "story_v_out_115301.awb")
				end

				arg_626_1:RecordContent(arg_626_1.text_.text)
			end

			local var_629_10 = math.max(var_629_3, arg_626_1.talkMaxDuration)

			if var_629_2 <= arg_626_1.time_ and arg_626_1.time_ < var_629_2 + var_629_10 then
				arg_626_1.typewritter.percent = (arg_626_1.time_ - var_629_2) / var_629_10

				arg_626_1.typewritter:SetDirty()
			end

			if arg_626_1.time_ >= var_629_2 + var_629_10 and arg_626_1.time_ < var_629_2 + var_629_10 + arg_629_0 then
				arg_626_1.typewritter.percent = 1

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(true)
			end
		end

		arg_626_1.nodeConfigList_ = {}

		arg_626_1:InitPlayNodeList()
	end,
	Play115301155 = function(arg_630_0, arg_630_1)
		arg_630_1.time_ = 0
		arg_630_1.frameCnt_ = 0
		arg_630_1.state_ = "playing"
		arg_630_1.curTalkId_ = 115301155
		arg_630_1.duration_ = 8.73

		local var_630_0 = {
			ja = 7.666,
			ko = 8.133,
			zh = 8.733,
			en = 8.733
		}
		local var_630_1 = manager.audio:GetLocalizationFlag()

		if var_630_0[var_630_1] ~= nil then
			arg_630_1.duration_ = var_630_0[var_630_1]
		end

		SetActive(arg_630_1.tipsGo_, false)

		function arg_630_1.onSingleLineFinish_()
			arg_630_1.onSingleLineUpdate_ = nil
			arg_630_1.onSingleLineFinish_ = nil
			arg_630_1.state_ = "waiting"
		end

		function arg_630_1.playNext_(arg_632_0)
			if arg_632_0 == 1 then
				arg_630_0:Play115301156(arg_630_1)
			end
		end

		function arg_630_1.onSingleLineUpdate_(arg_633_0)
			local var_633_0 = 0.825

			if 0 < arg_630_1.time_ and arg_630_1.time_ <= 0 + arg_633_0 then
				arg_630_1.talkMaxDuration = 0
				arg_630_1.dialogCg_.alpha = 1

				arg_630_1.dialog_:SetActive(true)
				SetActive(arg_630_1.leftNameGo_, true)

				arg_630_1.leftNameTxt_.text = arg_630_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_630_1.leftNameTxt_.transform)

				arg_630_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_630_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_630_1:RecordName(arg_630_1.leftNameTxt_.text)
				SetActive(arg_630_1.iconTrs_.gameObject, false)
				arg_630_1.callingController_:SetSelectedState("normal")

				local var_633_1 = arg_630_1:GetWordFromCfg(115301155)
				local var_633_2 = arg_630_1:FormatText(var_633_1.content)

				arg_630_1.text_.text = var_633_2

				LuaForUtil.ClearLinePrefixSymbol(arg_630_1.text_)

				local var_633_4 = 33 <= 0 and var_633_0 or var_633_0 * (utf8.len(var_633_2) / 33)

				if (33 <= 0 and var_633_0 or var_633_0 * (utf8.len(var_633_2) / 33)) > 0 and var_633_0 < var_633_4 then
					arg_630_1.talkMaxDuration = var_633_4

					if var_633_4 + 0 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_4 + 0
					end
				end

				arg_630_1.text_.text = var_633_2
				arg_630_1.typewritter.percent = 0

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301155", "story_v_out_115301.awb") ~= 0 then
					local var_633_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301155", "story_v_out_115301.awb") / 1000

					if var_633_5 + 0 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_5 + 0
					end

					if var_633_1.prefab_name ~= "" and arg_630_1.actors_[var_633_1.prefab_name] ~= nil then
						local var_633_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_630_1.actors_[var_633_1.prefab_name].transform, "story_v_out_115301", "115301155", "story_v_out_115301.awb")

						arg_630_1:RecordAudio("115301155", var_633_6)
						arg_630_1:RecordAudio("115301155", var_633_6)
					else
						arg_630_1:AudioAction("play", "voice", "story_v_out_115301", "115301155", "story_v_out_115301.awb")
					end

					arg_630_1:RecordHistoryTalkVoice("story_v_out_115301", "115301155", "story_v_out_115301.awb")
				end

				arg_630_1:RecordContent(arg_630_1.text_.text)
			end

			local var_633_7 = math.max(var_633_0, arg_630_1.talkMaxDuration)

			if 0 <= arg_630_1.time_ and arg_630_1.time_ < 0 + var_633_7 then
				arg_630_1.typewritter.percent = (arg_630_1.time_ - 0) / var_633_7

				arg_630_1.typewritter:SetDirty()
			end

			if arg_630_1.time_ >= 0 + var_633_7 and arg_630_1.time_ < 0 + var_633_7 + arg_633_0 then
				arg_630_1.typewritter.percent = 1

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(true)
			end
		end

		arg_630_1.nodeConfigList_ = {}

		arg_630_1:InitPlayNodeList()
	end,
	Play115301156 = function(arg_634_0, arg_634_1)
		arg_634_1.time_ = 0
		arg_634_1.frameCnt_ = 0
		arg_634_1.state_ = "playing"
		arg_634_1.curTalkId_ = 115301156
		arg_634_1.duration_ = 4.4

		local var_634_0 = {
			ja = 3.833,
			ko = 3,
			zh = 4.4,
			en = 4.333
		}
		local var_634_1 = manager.audio:GetLocalizationFlag()

		if var_634_0[var_634_1] ~= nil then
			arg_634_1.duration_ = var_634_0[var_634_1]
		end

		SetActive(arg_634_1.tipsGo_, false)

		function arg_634_1.onSingleLineFinish_()
			arg_634_1.onSingleLineUpdate_ = nil
			arg_634_1.onSingleLineFinish_ = nil
			arg_634_1.state_ = "waiting"
		end

		function arg_634_1.playNext_(arg_636_0)
			if arg_636_0 == 1 then
				arg_634_0:Play115301157(arg_634_1)
			end
		end

		function arg_634_1.onSingleLineUpdate_(arg_637_0)
			if 0 < arg_634_1.time_ and arg_634_1.time_ <= 0 + arg_637_0 then
				arg_634_1.var_.moveOldPos1038 = arg_634_1.actors_["1038"].transform.localPosition
				arg_634_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_634_1:CheckSpriteTmpPos("1038", 3)

				for iter_637_0 = 0, arg_634_1.actors_["1038"].transform.childCount - 1 do
					local var_637_0 = arg_634_1.actors_["1038"].transform:GetChild(iter_637_0)

					if var_637_0.name == "split_9" or not string.find(var_637_0.name, "split") then
						var_637_0.gameObject:SetActive(true)
					else
						var_637_0.gameObject:SetActive(false)
					end
				end
			end

			local var_637_1 = 0.001

			if 0 <= arg_634_1.time_ and arg_634_1.time_ < 0 + var_637_1 then
				arg_634_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_634_1.var_.moveOldPos1038, Vector3.New(0, -400, 0), (arg_634_1.time_ - 0) / var_637_1)
			end

			if arg_634_1.time_ >= 0 + var_637_1 and arg_634_1.time_ < 0 + var_637_1 + arg_637_0 then
				arg_634_1.actors_["1038"].transform.localPosition = Vector3.New(0, -400, 0)
			end

			if 0 < arg_634_1.time_ and arg_634_1.time_ <= 0 + arg_637_0 then
				local var_637_2 = arg_634_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_637_2 then
					arg_634_1.var_.alphaOldValue1038 = var_637_2.alpha
					arg_634_1.var_.characterEffect1038 = var_637_2
				end

				arg_634_1.var_.alphaOldValue1038 = 0
			end

			local var_637_3 = 0.0166666666666667

			if 0 <= arg_634_1.time_ and arg_634_1.time_ < 0 + var_637_3 then
				if arg_634_1.var_.characterEffect1038 then
					arg_634_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_634_1.var_.alphaOldValue1038, 1, (arg_634_1.time_ - 0) / var_637_3)
				end
			end

			if arg_634_1.time_ >= 0 + var_637_3 and arg_634_1.time_ < 0 + var_637_3 + arg_637_0 and arg_634_1.var_.characterEffect1038 then
				arg_634_1.var_.characterEffect1038.alpha = 1
			end

			local var_637_4 = arg_634_1.actors_["1038"]

			if 0 < arg_634_1.time_ and arg_634_1.time_ <= 0 + arg_637_0 and not isNil(var_637_4) and arg_634_1.var_.actorSpriteComps1038 == nil then
				arg_634_1.var_.actorSpriteComps1038 = var_637_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_637_5 = 0.2

			if 0 <= arg_634_1.time_ and arg_634_1.time_ < 0 + var_637_5 and not isNil(var_637_4) then
				if arg_634_1.var_.actorSpriteComps1038 then
					for iter_637_1, iter_637_2 in pairs(arg_634_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_637_2 then
							if arg_634_1.isInRecall_ then
								iter_637_2.color = Color.New(Mathf.Lerp(iter_637_2.color.r, arg_634_1.hightColor1.r, (arg_634_1.time_ - 0) / var_637_5), Mathf.Lerp(iter_637_2.color.g, arg_634_1.hightColor1.g, (arg_634_1.time_ - 0) / var_637_5), (Mathf.Lerp(iter_637_2.color.b, arg_634_1.hightColor1.b, (arg_634_1.time_ - 0) / var_637_5)))
							else
								local var_637_6 = Mathf.Lerp(iter_637_2.color.r, 1, (arg_634_1.time_ - 0) / var_637_5)

								iter_637_2.color = Color.New(var_637_6, var_637_6, var_637_6)
							end
						end
					end
				end
			end

			if arg_634_1.time_ >= 0 + var_637_5 and arg_634_1.time_ < 0 + var_637_5 + arg_637_0 and not isNil(var_637_4) and arg_634_1.var_.actorSpriteComps1038 then
				for iter_637_3, iter_637_4 in pairs(arg_634_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_637_4 then
						iter_637_4.color = arg_634_1.isInRecall_ and (arg_634_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_634_1.var_.actorSpriteComps1038 = nil
			end

			local var_637_7 = 0
			local var_637_8 = 0.4

			if 0 < arg_634_1.time_ and arg_634_1.time_ <= var_637_7 + arg_637_0 then
				arg_634_1.talkMaxDuration = 0
				arg_634_1.dialogCg_.alpha = 1

				arg_634_1.dialog_:SetActive(true)
				SetActive(arg_634_1.leftNameGo_, true)

				arg_634_1.leftNameTxt_.text = arg_634_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_634_1.leftNameTxt_.transform)

				arg_634_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_634_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_634_1:RecordName(arg_634_1.leftNameTxt_.text)
				SetActive(arg_634_1.iconTrs_.gameObject, false)
				arg_634_1.callingController_:SetSelectedState("normal")

				local var_637_9 = arg_634_1:GetWordFromCfg(115301156)
				local var_637_10 = arg_634_1:FormatText(var_637_9.content)

				arg_634_1.text_.text = var_637_10

				LuaForUtil.ClearLinePrefixSymbol(arg_634_1.text_)

				local var_637_12 = 16 <= 0 and var_637_8 or var_637_8 * (utf8.len(var_637_10) / 16)

				if (16 <= 0 and var_637_8 or var_637_8 * (utf8.len(var_637_10) / 16)) > 0 and var_637_8 < var_637_12 then
					arg_634_1.talkMaxDuration = var_637_12

					if var_637_12 + var_637_7 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_12 + var_637_7
					end
				end

				arg_634_1.text_.text = var_637_10
				arg_634_1.typewritter.percent = 0

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301156", "story_v_out_115301.awb") ~= 0 then
					local var_637_13 = manager.audio:GetVoiceLength("story_v_out_115301", "115301156", "story_v_out_115301.awb") / 1000

					if var_637_13 + var_637_7 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_13 + var_637_7
					end

					if var_637_9.prefab_name ~= "" and arg_634_1.actors_[var_637_9.prefab_name] ~= nil then
						local var_637_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_634_1.actors_[var_637_9.prefab_name].transform, "story_v_out_115301", "115301156", "story_v_out_115301.awb")

						arg_634_1:RecordAudio("115301156", var_637_14)
						arg_634_1:RecordAudio("115301156", var_637_14)
					else
						arg_634_1:AudioAction("play", "voice", "story_v_out_115301", "115301156", "story_v_out_115301.awb")
					end

					arg_634_1:RecordHistoryTalkVoice("story_v_out_115301", "115301156", "story_v_out_115301.awb")
				end

				arg_634_1:RecordContent(arg_634_1.text_.text)
			end

			local var_637_15 = math.max(var_637_8, arg_634_1.talkMaxDuration)

			if var_637_7 <= arg_634_1.time_ and arg_634_1.time_ < var_637_7 + var_637_15 then
				arg_634_1.typewritter.percent = (arg_634_1.time_ - var_637_7) / var_637_15

				arg_634_1.typewritter:SetDirty()
			end

			if arg_634_1.time_ >= var_637_7 + var_637_15 and arg_634_1.time_ < var_637_7 + var_637_15 + arg_637_0 then
				arg_634_1.typewritter.percent = 1

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(true)
			end
		end

		arg_634_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_634_1:InitPlayNodeList()
	end,
	Play115301157 = function(arg_638_0, arg_638_1)
		arg_638_1.time_ = 0
		arg_638_1.frameCnt_ = 0
		arg_638_1.state_ = "playing"
		arg_638_1.curTalkId_ = 115301157
		arg_638_1.duration_ = 7.27

		local var_638_0 = {
			ja = 4.4,
			ko = 5.6,
			zh = 5.166,
			en = 7.266
		}
		local var_638_1 = manager.audio:GetLocalizationFlag()

		if var_638_0[var_638_1] ~= nil then
			arg_638_1.duration_ = var_638_0[var_638_1]
		end

		SetActive(arg_638_1.tipsGo_, false)

		function arg_638_1.onSingleLineFinish_()
			arg_638_1.onSingleLineUpdate_ = nil
			arg_638_1.onSingleLineFinish_ = nil
			arg_638_1.state_ = "waiting"
		end

		function arg_638_1.playNext_(arg_640_0)
			if arg_640_0 == 1 then
				arg_638_0:Play115301158(arg_638_1)
			end
		end

		function arg_638_1.onSingleLineUpdate_(arg_641_0)
			if 0 < arg_638_1.time_ and arg_638_1.time_ <= 0 + arg_641_0 and not isNil(arg_638_1.actors_["1038"]) and arg_638_1.var_.actorSpriteComps1038 == nil then
				arg_638_1.var_.actorSpriteComps1038 = arg_638_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_641_0 = 0.2

			if 0 <= arg_638_1.time_ and arg_638_1.time_ < 0 + var_641_0 and not isNil(arg_638_1.actors_["1038"]) then
				if arg_638_1.var_.actorSpriteComps1038 then
					for iter_641_0, iter_641_1 in pairs(arg_638_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_641_1 then
							if arg_638_1.isInRecall_ then
								iter_641_1.color = Color.New(Mathf.Lerp(iter_641_1.color.r, arg_638_1.hightColor2.r, (arg_638_1.time_ - 0) / var_641_0), Mathf.Lerp(iter_641_1.color.g, arg_638_1.hightColor2.g, (arg_638_1.time_ - 0) / var_641_0), (Mathf.Lerp(iter_641_1.color.b, arg_638_1.hightColor2.b, (arg_638_1.time_ - 0) / var_641_0)))
							else
								local var_641_1 = Mathf.Lerp(iter_641_1.color.r, 0.5, (arg_638_1.time_ - 0) / var_641_0)

								iter_641_1.color = Color.New(var_641_1, var_641_1, var_641_1)
							end
						end
					end
				end
			end

			if arg_638_1.time_ >= 0 + var_641_0 and arg_638_1.time_ < 0 + var_641_0 + arg_641_0 and not isNil(arg_638_1.actors_["1038"]) and arg_638_1.var_.actorSpriteComps1038 then
				for iter_641_2, iter_641_3 in pairs(arg_638_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_641_3 then
						iter_641_3.color = arg_638_1.isInRecall_ and (arg_638_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_638_1.var_.actorSpriteComps1038 = nil
			end

			local var_641_2 = 0
			local var_641_3 = 0.525

			if 0 < arg_638_1.time_ and arg_638_1.time_ <= var_641_2 + arg_641_0 then
				arg_638_1.talkMaxDuration = 0
				arg_638_1.dialogCg_.alpha = 1

				arg_638_1.dialog_:SetActive(true)
				SetActive(arg_638_1.leftNameGo_, true)

				arg_638_1.leftNameTxt_.text = arg_638_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_638_1.leftNameTxt_.transform)

				arg_638_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_638_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_638_1:RecordName(arg_638_1.leftNameTxt_.text)
				SetActive(arg_638_1.iconTrs_.gameObject, false)
				arg_638_1.callingController_:SetSelectedState("normal")

				local var_641_4 = arg_638_1:GetWordFromCfg(115301157)
				local var_641_5 = arg_638_1:FormatText(var_641_4.content)

				arg_638_1.text_.text = var_641_5

				LuaForUtil.ClearLinePrefixSymbol(arg_638_1.text_)

				local var_641_7 = 21 <= 0 and var_641_3 or var_641_3 * (utf8.len(var_641_5) / 21)

				if (21 <= 0 and var_641_3 or var_641_3 * (utf8.len(var_641_5) / 21)) > 0 and var_641_3 < var_641_7 then
					arg_638_1.talkMaxDuration = var_641_7

					if var_641_7 + var_641_2 > arg_638_1.duration_ then
						arg_638_1.duration_ = var_641_7 + var_641_2
					end
				end

				arg_638_1.text_.text = var_641_5
				arg_638_1.typewritter.percent = 0

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301157", "story_v_out_115301.awb") ~= 0 then
					local var_641_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301157", "story_v_out_115301.awb") / 1000

					if var_641_8 + var_641_2 > arg_638_1.duration_ then
						arg_638_1.duration_ = var_641_8 + var_641_2
					end

					if var_641_4.prefab_name ~= "" and arg_638_1.actors_[var_641_4.prefab_name] ~= nil then
						local var_641_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_638_1.actors_[var_641_4.prefab_name].transform, "story_v_out_115301", "115301157", "story_v_out_115301.awb")

						arg_638_1:RecordAudio("115301157", var_641_9)
						arg_638_1:RecordAudio("115301157", var_641_9)
					else
						arg_638_1:AudioAction("play", "voice", "story_v_out_115301", "115301157", "story_v_out_115301.awb")
					end

					arg_638_1:RecordHistoryTalkVoice("story_v_out_115301", "115301157", "story_v_out_115301.awb")
				end

				arg_638_1:RecordContent(arg_638_1.text_.text)
			end

			local var_641_10 = math.max(var_641_3, arg_638_1.talkMaxDuration)

			if var_641_2 <= arg_638_1.time_ and arg_638_1.time_ < var_641_2 + var_641_10 then
				arg_638_1.typewritter.percent = (arg_638_1.time_ - var_641_2) / var_641_10

				arg_638_1.typewritter:SetDirty()
			end

			if arg_638_1.time_ >= var_641_2 + var_641_10 and arg_638_1.time_ < var_641_2 + var_641_10 + arg_641_0 then
				arg_638_1.typewritter.percent = 1

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(true)
			end
		end

		arg_638_1.nodeConfigList_ = {}

		arg_638_1:InitPlayNodeList()
	end,
	Play115301158 = function(arg_642_0, arg_642_1)
		arg_642_1.time_ = 0
		arg_642_1.frameCnt_ = 0
		arg_642_1.state_ = "playing"
		arg_642_1.curTalkId_ = 115301158
		arg_642_1.duration_ = 16.37

		local var_642_0 = {
			ja = 14.333,
			ko = 11.666,
			zh = 12.7,
			en = 16.366
		}
		local var_642_1 = manager.audio:GetLocalizationFlag()

		if var_642_0[var_642_1] ~= nil then
			arg_642_1.duration_ = var_642_0[var_642_1]
		end

		SetActive(arg_642_1.tipsGo_, false)

		function arg_642_1.onSingleLineFinish_()
			arg_642_1.onSingleLineUpdate_ = nil
			arg_642_1.onSingleLineFinish_ = nil
			arg_642_1.state_ = "waiting"
		end

		function arg_642_1.playNext_(arg_644_0)
			if arg_644_0 == 1 then
				arg_642_0:Play115301159(arg_642_1)
			end
		end

		function arg_642_1.onSingleLineUpdate_(arg_645_0)
			local var_645_0 = 1.125

			if 0 < arg_642_1.time_ and arg_642_1.time_ <= 0 + arg_645_0 then
				arg_642_1.talkMaxDuration = 0
				arg_642_1.dialogCg_.alpha = 1

				arg_642_1.dialog_:SetActive(true)
				SetActive(arg_642_1.leftNameGo_, true)

				arg_642_1.leftNameTxt_.text = arg_642_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_642_1.leftNameTxt_.transform)

				arg_642_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_642_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_642_1:RecordName(arg_642_1.leftNameTxt_.text)
				SetActive(arg_642_1.iconTrs_.gameObject, false)
				arg_642_1.callingController_:SetSelectedState("normal")

				local var_645_1 = arg_642_1:GetWordFromCfg(115301158)
				local var_645_2 = arg_642_1:FormatText(var_645_1.content)

				arg_642_1.text_.text = var_645_2

				LuaForUtil.ClearLinePrefixSymbol(arg_642_1.text_)

				local var_645_4 = 45 <= 0 and var_645_0 or var_645_0 * (utf8.len(var_645_2) / 45)

				if (45 <= 0 and var_645_0 or var_645_0 * (utf8.len(var_645_2) / 45)) > 0 and var_645_0 < var_645_4 then
					arg_642_1.talkMaxDuration = var_645_4

					if var_645_4 + 0 > arg_642_1.duration_ then
						arg_642_1.duration_ = var_645_4 + 0
					end
				end

				arg_642_1.text_.text = var_645_2
				arg_642_1.typewritter.percent = 0

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301158", "story_v_out_115301.awb") ~= 0 then
					local var_645_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301158", "story_v_out_115301.awb") / 1000

					if var_645_5 + 0 > arg_642_1.duration_ then
						arg_642_1.duration_ = var_645_5 + 0
					end

					if var_645_1.prefab_name ~= "" and arg_642_1.actors_[var_645_1.prefab_name] ~= nil then
						local var_645_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_642_1.actors_[var_645_1.prefab_name].transform, "story_v_out_115301", "115301158", "story_v_out_115301.awb")

						arg_642_1:RecordAudio("115301158", var_645_6)
						arg_642_1:RecordAudio("115301158", var_645_6)
					else
						arg_642_1:AudioAction("play", "voice", "story_v_out_115301", "115301158", "story_v_out_115301.awb")
					end

					arg_642_1:RecordHistoryTalkVoice("story_v_out_115301", "115301158", "story_v_out_115301.awb")
				end

				arg_642_1:RecordContent(arg_642_1.text_.text)
			end

			local var_645_7 = math.max(var_645_0, arg_642_1.talkMaxDuration)

			if 0 <= arg_642_1.time_ and arg_642_1.time_ < 0 + var_645_7 then
				arg_642_1.typewritter.percent = (arg_642_1.time_ - 0) / var_645_7

				arg_642_1.typewritter:SetDirty()
			end

			if arg_642_1.time_ >= 0 + var_645_7 and arg_642_1.time_ < 0 + var_645_7 + arg_645_0 then
				arg_642_1.typewritter.percent = 1

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(true)
			end
		end

		arg_642_1.nodeConfigList_ = {}

		arg_642_1:InitPlayNodeList()
	end,
	Play115301159 = function(arg_646_0, arg_646_1)
		arg_646_1.time_ = 0
		arg_646_1.frameCnt_ = 0
		arg_646_1.state_ = "playing"
		arg_646_1.curTalkId_ = 115301159
		arg_646_1.duration_ = 5.5

		local var_646_0 = {
			ja = 5.5,
			ko = 3.4,
			zh = 4.7,
			en = 3.833
		}
		local var_646_1 = manager.audio:GetLocalizationFlag()

		if var_646_0[var_646_1] ~= nil then
			arg_646_1.duration_ = var_646_0[var_646_1]
		end

		SetActive(arg_646_1.tipsGo_, false)

		function arg_646_1.onSingleLineFinish_()
			arg_646_1.onSingleLineUpdate_ = nil
			arg_646_1.onSingleLineFinish_ = nil
			arg_646_1.state_ = "waiting"
		end

		function arg_646_1.playNext_(arg_648_0)
			if arg_648_0 == 1 then
				arg_646_0:Play115301160(arg_646_1)
			end
		end

		function arg_646_1.onSingleLineUpdate_(arg_649_0)
			if 0 < arg_646_1.time_ and arg_646_1.time_ <= 0 + arg_649_0 and not isNil(arg_646_1.actors_["1038"]) and arg_646_1.var_.actorSpriteComps1038 == nil then
				arg_646_1.var_.actorSpriteComps1038 = arg_646_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_649_0 = 0.2

			if 0 <= arg_646_1.time_ and arg_646_1.time_ < 0 + var_649_0 and not isNil(arg_646_1.actors_["1038"]) then
				if arg_646_1.var_.actorSpriteComps1038 then
					for iter_649_0, iter_649_1 in pairs(arg_646_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_649_1 then
							if arg_646_1.isInRecall_ then
								iter_649_1.color = Color.New(Mathf.Lerp(iter_649_1.color.r, arg_646_1.hightColor1.r, (arg_646_1.time_ - 0) / var_649_0), Mathf.Lerp(iter_649_1.color.g, arg_646_1.hightColor1.g, (arg_646_1.time_ - 0) / var_649_0), (Mathf.Lerp(iter_649_1.color.b, arg_646_1.hightColor1.b, (arg_646_1.time_ - 0) / var_649_0)))
							else
								local var_649_1 = Mathf.Lerp(iter_649_1.color.r, 1, (arg_646_1.time_ - 0) / var_649_0)

								iter_649_1.color = Color.New(var_649_1, var_649_1, var_649_1)
							end
						end
					end
				end
			end

			if arg_646_1.time_ >= 0 + var_649_0 and arg_646_1.time_ < 0 + var_649_0 + arg_649_0 and not isNil(arg_646_1.actors_["1038"]) and arg_646_1.var_.actorSpriteComps1038 then
				for iter_649_2, iter_649_3 in pairs(arg_646_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_649_3 then
						iter_649_3.color = arg_646_1.isInRecall_ and (arg_646_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_646_1.var_.actorSpriteComps1038 = nil
			end

			local var_649_2 = arg_646_1.actors_["1038"].transform

			if 0 < arg_646_1.time_ and arg_646_1.time_ <= 0 + arg_649_0 then
				arg_646_1.var_.moveOldPos1038 = var_649_2.localPosition
				var_649_2.localScale = Vector3.New(1, 1, 1)

				arg_646_1:CheckSpriteTmpPos("1038", 3)

				for iter_649_4 = 0, var_649_2.childCount - 1 do
					local var_649_3 = var_649_2:GetChild(iter_649_4)

					if var_649_3.name == "split_1" or not string.find(var_649_3.name, "split") then
						var_649_3.gameObject:SetActive(true)
					else
						var_649_3.gameObject:SetActive(false)
					end
				end
			end

			local var_649_4 = 0.001

			if 0 <= arg_646_1.time_ and arg_646_1.time_ < 0 + var_649_4 then
				var_649_2.localPosition = Vector3.Lerp(arg_646_1.var_.moveOldPos1038, Vector3.New(0, -400, 0), (arg_646_1.time_ - 0) / var_649_4)
			end

			if arg_646_1.time_ >= 0 + var_649_4 and arg_646_1.time_ < 0 + var_649_4 + arg_649_0 then
				var_649_2.localPosition = Vector3.New(0, -400, 0)
			end

			local var_649_5 = 0
			local var_649_6 = 0.425

			if 0 < arg_646_1.time_ and arg_646_1.time_ <= var_649_5 + arg_649_0 then
				arg_646_1.talkMaxDuration = 0
				arg_646_1.dialogCg_.alpha = 1

				arg_646_1.dialog_:SetActive(true)
				SetActive(arg_646_1.leftNameGo_, true)

				arg_646_1.leftNameTxt_.text = arg_646_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_646_1.leftNameTxt_.transform)

				arg_646_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_646_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_646_1:RecordName(arg_646_1.leftNameTxt_.text)
				SetActive(arg_646_1.iconTrs_.gameObject, false)
				arg_646_1.callingController_:SetSelectedState("normal")

				local var_649_7 = arg_646_1:GetWordFromCfg(115301159)
				local var_649_8 = arg_646_1:FormatText(var_649_7.content)

				arg_646_1.text_.text = var_649_8

				LuaForUtil.ClearLinePrefixSymbol(arg_646_1.text_)

				local var_649_10 = 17 <= 0 and var_649_6 or var_649_6 * (utf8.len(var_649_8) / 17)

				if (17 <= 0 and var_649_6 or var_649_6 * (utf8.len(var_649_8) / 17)) > 0 and var_649_6 < var_649_10 then
					arg_646_1.talkMaxDuration = var_649_10

					if var_649_10 + var_649_5 > arg_646_1.duration_ then
						arg_646_1.duration_ = var_649_10 + var_649_5
					end
				end

				arg_646_1.text_.text = var_649_8
				arg_646_1.typewritter.percent = 0

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301159", "story_v_out_115301.awb") ~= 0 then
					local var_649_11 = manager.audio:GetVoiceLength("story_v_out_115301", "115301159", "story_v_out_115301.awb") / 1000

					if var_649_11 + var_649_5 > arg_646_1.duration_ then
						arg_646_1.duration_ = var_649_11 + var_649_5
					end

					if var_649_7.prefab_name ~= "" and arg_646_1.actors_[var_649_7.prefab_name] ~= nil then
						local var_649_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_646_1.actors_[var_649_7.prefab_name].transform, "story_v_out_115301", "115301159", "story_v_out_115301.awb")

						arg_646_1:RecordAudio("115301159", var_649_12)
						arg_646_1:RecordAudio("115301159", var_649_12)
					else
						arg_646_1:AudioAction("play", "voice", "story_v_out_115301", "115301159", "story_v_out_115301.awb")
					end

					arg_646_1:RecordHistoryTalkVoice("story_v_out_115301", "115301159", "story_v_out_115301.awb")
				end

				arg_646_1:RecordContent(arg_646_1.text_.text)
			end

			local var_649_13 = math.max(var_649_6, arg_646_1.talkMaxDuration)

			if var_649_5 <= arg_646_1.time_ and arg_646_1.time_ < var_649_5 + var_649_13 then
				arg_646_1.typewritter.percent = (arg_646_1.time_ - var_649_5) / var_649_13

				arg_646_1.typewritter:SetDirty()
			end

			if arg_646_1.time_ >= var_649_5 + var_649_13 and arg_646_1.time_ < var_649_5 + var_649_13 + arg_649_0 then
				arg_646_1.typewritter.percent = 1

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(true)
			end
		end

		arg_646_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_646_1:InitPlayNodeList()
	end,
	Play115301160 = function(arg_650_0, arg_650_1)
		arg_650_1.time_ = 0
		arg_650_1.frameCnt_ = 0
		arg_650_1.state_ = "playing"
		arg_650_1.curTalkId_ = 115301160
		arg_650_1.duration_ = 7.57

		local var_650_0 = {
			ja = 6.6,
			ko = 5.8,
			zh = 5.5,
			en = 7.566
		}
		local var_650_1 = manager.audio:GetLocalizationFlag()

		if var_650_0[var_650_1] ~= nil then
			arg_650_1.duration_ = var_650_0[var_650_1]
		end

		SetActive(arg_650_1.tipsGo_, false)

		function arg_650_1.onSingleLineFinish_()
			arg_650_1.onSingleLineUpdate_ = nil
			arg_650_1.onSingleLineFinish_ = nil
			arg_650_1.state_ = "waiting"
		end

		function arg_650_1.playNext_(arg_652_0)
			if arg_652_0 == 1 then
				arg_650_0:Play115301161(arg_650_1)
			end
		end

		function arg_650_1.onSingleLineUpdate_(arg_653_0)
			if 0 < arg_650_1.time_ and arg_650_1.time_ <= 0 + arg_653_0 and not isNil(arg_650_1.actors_["1038"]) and arg_650_1.var_.actorSpriteComps1038 == nil then
				arg_650_1.var_.actorSpriteComps1038 = arg_650_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_653_0 = 0.2

			if 0 <= arg_650_1.time_ and arg_650_1.time_ < 0 + var_653_0 and not isNil(arg_650_1.actors_["1038"]) then
				if arg_650_1.var_.actorSpriteComps1038 then
					for iter_653_0, iter_653_1 in pairs(arg_650_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_653_1 then
							if arg_650_1.isInRecall_ then
								iter_653_1.color = Color.New(Mathf.Lerp(iter_653_1.color.r, arg_650_1.hightColor2.r, (arg_650_1.time_ - 0) / var_653_0), Mathf.Lerp(iter_653_1.color.g, arg_650_1.hightColor2.g, (arg_650_1.time_ - 0) / var_653_0), (Mathf.Lerp(iter_653_1.color.b, arg_650_1.hightColor2.b, (arg_650_1.time_ - 0) / var_653_0)))
							else
								local var_653_1 = Mathf.Lerp(iter_653_1.color.r, 0.5, (arg_650_1.time_ - 0) / var_653_0)

								iter_653_1.color = Color.New(var_653_1, var_653_1, var_653_1)
							end
						end
					end
				end
			end

			if arg_650_1.time_ >= 0 + var_653_0 and arg_650_1.time_ < 0 + var_653_0 + arg_653_0 and not isNil(arg_650_1.actors_["1038"]) and arg_650_1.var_.actorSpriteComps1038 then
				for iter_653_2, iter_653_3 in pairs(arg_650_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_653_3 then
						iter_653_3.color = arg_650_1.isInRecall_ and (arg_650_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_650_1.var_.actorSpriteComps1038 = nil
			end

			local var_653_2 = 0
			local var_653_3 = 0.6

			if 0 < arg_650_1.time_ and arg_650_1.time_ <= var_653_2 + arg_653_0 then
				arg_650_1.talkMaxDuration = 0
				arg_650_1.dialogCg_.alpha = 1

				arg_650_1.dialog_:SetActive(true)
				SetActive(arg_650_1.leftNameGo_, true)

				arg_650_1.leftNameTxt_.text = arg_650_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_650_1.leftNameTxt_.transform)

				arg_650_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_650_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_650_1:RecordName(arg_650_1.leftNameTxt_.text)
				SetActive(arg_650_1.iconTrs_.gameObject, false)
				arg_650_1.callingController_:SetSelectedState("normal")

				local var_653_4 = arg_650_1:GetWordFromCfg(115301160)
				local var_653_5 = arg_650_1:FormatText(var_653_4.content)

				arg_650_1.text_.text = var_653_5

				LuaForUtil.ClearLinePrefixSymbol(arg_650_1.text_)

				local var_653_7 = 24 <= 0 and var_653_3 or var_653_3 * (utf8.len(var_653_5) / 24)

				if (24 <= 0 and var_653_3 or var_653_3 * (utf8.len(var_653_5) / 24)) > 0 and var_653_3 < var_653_7 then
					arg_650_1.talkMaxDuration = var_653_7

					if var_653_7 + var_653_2 > arg_650_1.duration_ then
						arg_650_1.duration_ = var_653_7 + var_653_2
					end
				end

				arg_650_1.text_.text = var_653_5
				arg_650_1.typewritter.percent = 0

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301160", "story_v_out_115301.awb") ~= 0 then
					local var_653_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301160", "story_v_out_115301.awb") / 1000

					if var_653_8 + var_653_2 > arg_650_1.duration_ then
						arg_650_1.duration_ = var_653_8 + var_653_2
					end

					if var_653_4.prefab_name ~= "" and arg_650_1.actors_[var_653_4.prefab_name] ~= nil then
						local var_653_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_650_1.actors_[var_653_4.prefab_name].transform, "story_v_out_115301", "115301160", "story_v_out_115301.awb")

						arg_650_1:RecordAudio("115301160", var_653_9)
						arg_650_1:RecordAudio("115301160", var_653_9)
					else
						arg_650_1:AudioAction("play", "voice", "story_v_out_115301", "115301160", "story_v_out_115301.awb")
					end

					arg_650_1:RecordHistoryTalkVoice("story_v_out_115301", "115301160", "story_v_out_115301.awb")
				end

				arg_650_1:RecordContent(arg_650_1.text_.text)
			end

			local var_653_10 = math.max(var_653_3, arg_650_1.talkMaxDuration)

			if var_653_2 <= arg_650_1.time_ and arg_650_1.time_ < var_653_2 + var_653_10 then
				arg_650_1.typewritter.percent = (arg_650_1.time_ - var_653_2) / var_653_10

				arg_650_1.typewritter:SetDirty()
			end

			if arg_650_1.time_ >= var_653_2 + var_653_10 and arg_650_1.time_ < var_653_2 + var_653_10 + arg_653_0 then
				arg_650_1.typewritter.percent = 1

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(true)
			end
		end

		arg_650_1.nodeConfigList_ = {}

		arg_650_1:InitPlayNodeList()
	end,
	Play115301161 = function(arg_654_0, arg_654_1)
		arg_654_1.time_ = 0
		arg_654_1.frameCnt_ = 0
		arg_654_1.state_ = "playing"
		arg_654_1.curTalkId_ = 115301161
		arg_654_1.duration_ = 14.47

		local var_654_0 = {
			ja = 14.466,
			ko = 10,
			zh = 10.933,
			en = 10.9
		}
		local var_654_1 = manager.audio:GetLocalizationFlag()

		if var_654_0[var_654_1] ~= nil then
			arg_654_1.duration_ = var_654_0[var_654_1]
		end

		SetActive(arg_654_1.tipsGo_, false)

		function arg_654_1.onSingleLineFinish_()
			arg_654_1.onSingleLineUpdate_ = nil
			arg_654_1.onSingleLineFinish_ = nil
			arg_654_1.state_ = "waiting"
		end

		function arg_654_1.playNext_(arg_656_0)
			if arg_656_0 == 1 then
				arg_654_0:Play115301162(arg_654_1)
			end
		end

		function arg_654_1.onSingleLineUpdate_(arg_657_0)
			local var_657_0 = 1.075

			if 0 < arg_654_1.time_ and arg_654_1.time_ <= 0 + arg_657_0 then
				arg_654_1.talkMaxDuration = 0
				arg_654_1.dialogCg_.alpha = 1

				arg_654_1.dialog_:SetActive(true)
				SetActive(arg_654_1.leftNameGo_, true)

				arg_654_1.leftNameTxt_.text = arg_654_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_654_1.leftNameTxt_.transform)

				arg_654_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_654_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_654_1:RecordName(arg_654_1.leftNameTxt_.text)
				SetActive(arg_654_1.iconTrs_.gameObject, false)
				arg_654_1.callingController_:SetSelectedState("normal")

				local var_657_1 = arg_654_1:GetWordFromCfg(115301161)
				local var_657_2 = arg_654_1:FormatText(var_657_1.content)

				arg_654_1.text_.text = var_657_2

				LuaForUtil.ClearLinePrefixSymbol(arg_654_1.text_)

				local var_657_4 = 43 <= 0 and var_657_0 or var_657_0 * (utf8.len(var_657_2) / 43)

				if (43 <= 0 and var_657_0 or var_657_0 * (utf8.len(var_657_2) / 43)) > 0 and var_657_0 < var_657_4 then
					arg_654_1.talkMaxDuration = var_657_4

					if var_657_4 + 0 > arg_654_1.duration_ then
						arg_654_1.duration_ = var_657_4 + 0
					end
				end

				arg_654_1.text_.text = var_657_2
				arg_654_1.typewritter.percent = 0

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301161", "story_v_out_115301.awb") ~= 0 then
					local var_657_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301161", "story_v_out_115301.awb") / 1000

					if var_657_5 + 0 > arg_654_1.duration_ then
						arg_654_1.duration_ = var_657_5 + 0
					end

					if var_657_1.prefab_name ~= "" and arg_654_1.actors_[var_657_1.prefab_name] ~= nil then
						local var_657_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_654_1.actors_[var_657_1.prefab_name].transform, "story_v_out_115301", "115301161", "story_v_out_115301.awb")

						arg_654_1:RecordAudio("115301161", var_657_6)
						arg_654_1:RecordAudio("115301161", var_657_6)
					else
						arg_654_1:AudioAction("play", "voice", "story_v_out_115301", "115301161", "story_v_out_115301.awb")
					end

					arg_654_1:RecordHistoryTalkVoice("story_v_out_115301", "115301161", "story_v_out_115301.awb")
				end

				arg_654_1:RecordContent(arg_654_1.text_.text)
			end

			local var_657_7 = math.max(var_657_0, arg_654_1.talkMaxDuration)

			if 0 <= arg_654_1.time_ and arg_654_1.time_ < 0 + var_657_7 then
				arg_654_1.typewritter.percent = (arg_654_1.time_ - 0) / var_657_7

				arg_654_1.typewritter:SetDirty()
			end

			if arg_654_1.time_ >= 0 + var_657_7 and arg_654_1.time_ < 0 + var_657_7 + arg_657_0 then
				arg_654_1.typewritter.percent = 1

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(true)
			end
		end

		arg_654_1.nodeConfigList_ = {}

		arg_654_1:InitPlayNodeList()
	end,
	Play115301162 = function(arg_658_0, arg_658_1)
		arg_658_1.time_ = 0
		arg_658_1.frameCnt_ = 0
		arg_658_1.state_ = "playing"
		arg_658_1.curTalkId_ = 115301162
		arg_658_1.duration_ = 4.23

		local var_658_0 = {
			ja = 3.166,
			ko = 2.633,
			zh = 4.233,
			en = 3.466
		}
		local var_658_1 = manager.audio:GetLocalizationFlag()

		if var_658_0[var_658_1] ~= nil then
			arg_658_1.duration_ = var_658_0[var_658_1]
		end

		SetActive(arg_658_1.tipsGo_, false)

		function arg_658_1.onSingleLineFinish_()
			arg_658_1.onSingleLineUpdate_ = nil
			arg_658_1.onSingleLineFinish_ = nil
			arg_658_1.state_ = "waiting"
		end

		function arg_658_1.playNext_(arg_660_0)
			if arg_660_0 == 1 then
				arg_658_0:Play115301163(arg_658_1)
			end
		end

		function arg_658_1.onSingleLineUpdate_(arg_661_0)
			local var_661_0 = 0.275

			if 0 < arg_658_1.time_ and arg_658_1.time_ <= 0 + arg_661_0 then
				arg_658_1.talkMaxDuration = 0
				arg_658_1.dialogCg_.alpha = 1

				arg_658_1.dialog_:SetActive(true)
				SetActive(arg_658_1.leftNameGo_, true)

				arg_658_1.leftNameTxt_.text = arg_658_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_658_1.leftNameTxt_.transform)

				arg_658_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_658_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_658_1:RecordName(arg_658_1.leftNameTxt_.text)
				SetActive(arg_658_1.iconTrs_.gameObject, false)
				arg_658_1.callingController_:SetSelectedState("normal")

				local var_661_1 = arg_658_1:GetWordFromCfg(115301162)
				local var_661_2 = arg_658_1:FormatText(var_661_1.content)

				arg_658_1.text_.text = var_661_2

				LuaForUtil.ClearLinePrefixSymbol(arg_658_1.text_)

				local var_661_4 = 11 <= 0 and var_661_0 or var_661_0 * (utf8.len(var_661_2) / 11)

				if (11 <= 0 and var_661_0 or var_661_0 * (utf8.len(var_661_2) / 11)) > 0 and var_661_0 < var_661_4 then
					arg_658_1.talkMaxDuration = var_661_4

					if var_661_4 + 0 > arg_658_1.duration_ then
						arg_658_1.duration_ = var_661_4 + 0
					end
				end

				arg_658_1.text_.text = var_661_2
				arg_658_1.typewritter.percent = 0

				arg_658_1.typewritter:SetDirty()
				arg_658_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301162", "story_v_out_115301.awb") ~= 0 then
					local var_661_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301162", "story_v_out_115301.awb") / 1000

					if var_661_5 + 0 > arg_658_1.duration_ then
						arg_658_1.duration_ = var_661_5 + 0
					end

					if var_661_1.prefab_name ~= "" and arg_658_1.actors_[var_661_1.prefab_name] ~= nil then
						local var_661_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_658_1.actors_[var_661_1.prefab_name].transform, "story_v_out_115301", "115301162", "story_v_out_115301.awb")

						arg_658_1:RecordAudio("115301162", var_661_6)
						arg_658_1:RecordAudio("115301162", var_661_6)
					else
						arg_658_1:AudioAction("play", "voice", "story_v_out_115301", "115301162", "story_v_out_115301.awb")
					end

					arg_658_1:RecordHistoryTalkVoice("story_v_out_115301", "115301162", "story_v_out_115301.awb")
				end

				arg_658_1:RecordContent(arg_658_1.text_.text)
			end

			local var_661_7 = math.max(var_661_0, arg_658_1.talkMaxDuration)

			if 0 <= arg_658_1.time_ and arg_658_1.time_ < 0 + var_661_7 then
				arg_658_1.typewritter.percent = (arg_658_1.time_ - 0) / var_661_7

				arg_658_1.typewritter:SetDirty()
			end

			if arg_658_1.time_ >= 0 + var_661_7 and arg_658_1.time_ < 0 + var_661_7 + arg_661_0 then
				arg_658_1.typewritter.percent = 1

				arg_658_1.typewritter:SetDirty()
				arg_658_1:ShowNextGo(true)
			end
		end

		arg_658_1.nodeConfigList_ = {}

		arg_658_1:InitPlayNodeList()
	end,
	Play115301163 = function(arg_662_0, arg_662_1)
		arg_662_1.time_ = 0
		arg_662_1.frameCnt_ = 0
		arg_662_1.state_ = "playing"
		arg_662_1.curTalkId_ = 115301163
		arg_662_1.duration_ = 9.23

		local var_662_0 = {
			ja = 8.233,
			ko = 8.4,
			zh = 9.233,
			en = 8.666
		}
		local var_662_1 = manager.audio:GetLocalizationFlag()

		if var_662_0[var_662_1] ~= nil then
			arg_662_1.duration_ = var_662_0[var_662_1]
		end

		SetActive(arg_662_1.tipsGo_, false)

		function arg_662_1.onSingleLineFinish_()
			arg_662_1.onSingleLineUpdate_ = nil
			arg_662_1.onSingleLineFinish_ = nil
			arg_662_1.state_ = "waiting"
		end

		function arg_662_1.playNext_(arg_664_0)
			if arg_664_0 == 1 then
				arg_662_0:Play115301164(arg_662_1)
			end
		end

		function arg_662_1.onSingleLineUpdate_(arg_665_0)
			if 0 < arg_662_1.time_ and arg_662_1.time_ <= 0 + arg_665_0 and not isNil(arg_662_1.actors_["1038"]) and arg_662_1.var_.actorSpriteComps1038 == nil then
				arg_662_1.var_.actorSpriteComps1038 = arg_662_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_665_0 = 0.2

			if 0 <= arg_662_1.time_ and arg_662_1.time_ < 0 + var_665_0 and not isNil(arg_662_1.actors_["1038"]) then
				if arg_662_1.var_.actorSpriteComps1038 then
					for iter_665_0, iter_665_1 in pairs(arg_662_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_665_1 then
							if arg_662_1.isInRecall_ then
								iter_665_1.color = Color.New(Mathf.Lerp(iter_665_1.color.r, arg_662_1.hightColor1.r, (arg_662_1.time_ - 0) / var_665_0), Mathf.Lerp(iter_665_1.color.g, arg_662_1.hightColor1.g, (arg_662_1.time_ - 0) / var_665_0), (Mathf.Lerp(iter_665_1.color.b, arg_662_1.hightColor1.b, (arg_662_1.time_ - 0) / var_665_0)))
							else
								local var_665_1 = Mathf.Lerp(iter_665_1.color.r, 1, (arg_662_1.time_ - 0) / var_665_0)

								iter_665_1.color = Color.New(var_665_1, var_665_1, var_665_1)
							end
						end
					end
				end
			end

			if arg_662_1.time_ >= 0 + var_665_0 and arg_662_1.time_ < 0 + var_665_0 + arg_665_0 and not isNil(arg_662_1.actors_["1038"]) and arg_662_1.var_.actorSpriteComps1038 then
				for iter_665_2, iter_665_3 in pairs(arg_662_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_665_3 then
						iter_665_3.color = arg_662_1.isInRecall_ and (arg_662_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_662_1.var_.actorSpriteComps1038 = nil
			end

			local var_665_2 = 0
			local var_665_3 = 0.8

			if 0 < arg_662_1.time_ and arg_662_1.time_ <= var_665_2 + arg_665_0 then
				arg_662_1.talkMaxDuration = 0
				arg_662_1.dialogCg_.alpha = 1

				arg_662_1.dialog_:SetActive(true)
				SetActive(arg_662_1.leftNameGo_, true)

				arg_662_1.leftNameTxt_.text = arg_662_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_662_1.leftNameTxt_.transform)

				arg_662_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_662_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_662_1:RecordName(arg_662_1.leftNameTxt_.text)
				SetActive(arg_662_1.iconTrs_.gameObject, false)
				arg_662_1.callingController_:SetSelectedState("normal")

				local var_665_4 = arg_662_1:GetWordFromCfg(115301163)
				local var_665_5 = arg_662_1:FormatText(var_665_4.content)

				arg_662_1.text_.text = var_665_5

				LuaForUtil.ClearLinePrefixSymbol(arg_662_1.text_)

				local var_665_7 = 32 <= 0 and var_665_3 or var_665_3 * (utf8.len(var_665_5) / 32)

				if (32 <= 0 and var_665_3 or var_665_3 * (utf8.len(var_665_5) / 32)) > 0 and var_665_3 < var_665_7 then
					arg_662_1.talkMaxDuration = var_665_7

					if var_665_7 + var_665_2 > arg_662_1.duration_ then
						arg_662_1.duration_ = var_665_7 + var_665_2
					end
				end

				arg_662_1.text_.text = var_665_5
				arg_662_1.typewritter.percent = 0

				arg_662_1.typewritter:SetDirty()
				arg_662_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301163", "story_v_out_115301.awb") ~= 0 then
					local var_665_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301163", "story_v_out_115301.awb") / 1000

					if var_665_8 + var_665_2 > arg_662_1.duration_ then
						arg_662_1.duration_ = var_665_8 + var_665_2
					end

					if var_665_4.prefab_name ~= "" and arg_662_1.actors_[var_665_4.prefab_name] ~= nil then
						local var_665_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_662_1.actors_[var_665_4.prefab_name].transform, "story_v_out_115301", "115301163", "story_v_out_115301.awb")

						arg_662_1:RecordAudio("115301163", var_665_9)
						arg_662_1:RecordAudio("115301163", var_665_9)
					else
						arg_662_1:AudioAction("play", "voice", "story_v_out_115301", "115301163", "story_v_out_115301.awb")
					end

					arg_662_1:RecordHistoryTalkVoice("story_v_out_115301", "115301163", "story_v_out_115301.awb")
				end

				arg_662_1:RecordContent(arg_662_1.text_.text)
			end

			local var_665_10 = math.max(var_665_3, arg_662_1.talkMaxDuration)

			if var_665_2 <= arg_662_1.time_ and arg_662_1.time_ < var_665_2 + var_665_10 then
				arg_662_1.typewritter.percent = (arg_662_1.time_ - var_665_2) / var_665_10

				arg_662_1.typewritter:SetDirty()
			end

			if arg_662_1.time_ >= var_665_2 + var_665_10 and arg_662_1.time_ < var_665_2 + var_665_10 + arg_665_0 then
				arg_662_1.typewritter.percent = 1

				arg_662_1.typewritter:SetDirty()
				arg_662_1:ShowNextGo(true)
			end
		end

		arg_662_1.nodeConfigList_ = {}

		arg_662_1:InitPlayNodeList()
	end,
	Play115301164 = function(arg_666_0, arg_666_1)
		arg_666_1.time_ = 0
		arg_666_1.frameCnt_ = 0
		arg_666_1.state_ = "playing"
		arg_666_1.curTalkId_ = 115301164
		arg_666_1.duration_ = 6.3

		local var_666_0 = {
			ja = 6.3,
			ko = 6.266,
			zh = 5.433,
			en = 5.633
		}
		local var_666_1 = manager.audio:GetLocalizationFlag()

		if var_666_0[var_666_1] ~= nil then
			arg_666_1.duration_ = var_666_0[var_666_1]
		end

		SetActive(arg_666_1.tipsGo_, false)

		function arg_666_1.onSingleLineFinish_()
			arg_666_1.onSingleLineUpdate_ = nil
			arg_666_1.onSingleLineFinish_ = nil
			arg_666_1.state_ = "waiting"
		end

		function arg_666_1.playNext_(arg_668_0)
			if arg_668_0 == 1 then
				arg_666_0:Play115301165(arg_666_1)
			end
		end

		function arg_666_1.onSingleLineUpdate_(arg_669_0)
			local var_669_0 = 0.525

			if 0 < arg_666_1.time_ and arg_666_1.time_ <= 0 + arg_669_0 then
				arg_666_1.talkMaxDuration = 0
				arg_666_1.dialogCg_.alpha = 1

				arg_666_1.dialog_:SetActive(true)
				SetActive(arg_666_1.leftNameGo_, true)

				arg_666_1.leftNameTxt_.text = arg_666_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_666_1.leftNameTxt_.transform)

				arg_666_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_666_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_666_1:RecordName(arg_666_1.leftNameTxt_.text)
				SetActive(arg_666_1.iconTrs_.gameObject, false)
				arg_666_1.callingController_:SetSelectedState("normal")

				local var_669_1 = arg_666_1:GetWordFromCfg(115301164)
				local var_669_2 = arg_666_1:FormatText(var_669_1.content)

				arg_666_1.text_.text = var_669_2

				LuaForUtil.ClearLinePrefixSymbol(arg_666_1.text_)

				local var_669_4 = 21 <= 0 and var_669_0 or var_669_0 * (utf8.len(var_669_2) / 21)

				if (21 <= 0 and var_669_0 or var_669_0 * (utf8.len(var_669_2) / 21)) > 0 and var_669_0 < var_669_4 then
					arg_666_1.talkMaxDuration = var_669_4

					if var_669_4 + 0 > arg_666_1.duration_ then
						arg_666_1.duration_ = var_669_4 + 0
					end
				end

				arg_666_1.text_.text = var_669_2
				arg_666_1.typewritter.percent = 0

				arg_666_1.typewritter:SetDirty()
				arg_666_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301164", "story_v_out_115301.awb") ~= 0 then
					local var_669_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301164", "story_v_out_115301.awb") / 1000

					if var_669_5 + 0 > arg_666_1.duration_ then
						arg_666_1.duration_ = var_669_5 + 0
					end

					if var_669_1.prefab_name ~= "" and arg_666_1.actors_[var_669_1.prefab_name] ~= nil then
						local var_669_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_666_1.actors_[var_669_1.prefab_name].transform, "story_v_out_115301", "115301164", "story_v_out_115301.awb")

						arg_666_1:RecordAudio("115301164", var_669_6)
						arg_666_1:RecordAudio("115301164", var_669_6)
					else
						arg_666_1:AudioAction("play", "voice", "story_v_out_115301", "115301164", "story_v_out_115301.awb")
					end

					arg_666_1:RecordHistoryTalkVoice("story_v_out_115301", "115301164", "story_v_out_115301.awb")
				end

				arg_666_1:RecordContent(arg_666_1.text_.text)
			end

			local var_669_7 = math.max(var_669_0, arg_666_1.talkMaxDuration)

			if 0 <= arg_666_1.time_ and arg_666_1.time_ < 0 + var_669_7 then
				arg_666_1.typewritter.percent = (arg_666_1.time_ - 0) / var_669_7

				arg_666_1.typewritter:SetDirty()
			end

			if arg_666_1.time_ >= 0 + var_669_7 and arg_666_1.time_ < 0 + var_669_7 + arg_669_0 then
				arg_666_1.typewritter.percent = 1

				arg_666_1.typewritter:SetDirty()
				arg_666_1:ShowNextGo(true)
			end
		end

		arg_666_1.nodeConfigList_ = {}

		arg_666_1:InitPlayNodeList()
	end,
	Play115301165 = function(arg_670_0, arg_670_1)
		arg_670_1.time_ = 0
		arg_670_1.frameCnt_ = 0
		arg_670_1.state_ = "playing"
		arg_670_1.curTalkId_ = 115301165
		arg_670_1.duration_ = 6.1

		local var_670_0 = {
			ja = 4.9,
			ko = 5.233,
			zh = 6.1,
			en = 4.866
		}
		local var_670_1 = manager.audio:GetLocalizationFlag()

		if var_670_0[var_670_1] ~= nil then
			arg_670_1.duration_ = var_670_0[var_670_1]
		end

		SetActive(arg_670_1.tipsGo_, false)

		function arg_670_1.onSingleLineFinish_()
			arg_670_1.onSingleLineUpdate_ = nil
			arg_670_1.onSingleLineFinish_ = nil
			arg_670_1.state_ = "waiting"
		end

		function arg_670_1.playNext_(arg_672_0)
			if arg_672_0 == 1 then
				arg_670_0:Play115301166(arg_670_1)
			end
		end

		function arg_670_1.onSingleLineUpdate_(arg_673_0)
			if 0 < arg_670_1.time_ and arg_670_1.time_ <= 0 + arg_673_0 and not isNil(arg_670_1.actors_["1038"]) and arg_670_1.var_.actorSpriteComps1038 == nil then
				arg_670_1.var_.actorSpriteComps1038 = arg_670_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_673_0 = 0.2

			if 0 <= arg_670_1.time_ and arg_670_1.time_ < 0 + var_673_0 and not isNil(arg_670_1.actors_["1038"]) then
				if arg_670_1.var_.actorSpriteComps1038 then
					for iter_673_0, iter_673_1 in pairs(arg_670_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_673_1 then
							if arg_670_1.isInRecall_ then
								iter_673_1.color = Color.New(Mathf.Lerp(iter_673_1.color.r, arg_670_1.hightColor2.r, (arg_670_1.time_ - 0) / var_673_0), Mathf.Lerp(iter_673_1.color.g, arg_670_1.hightColor2.g, (arg_670_1.time_ - 0) / var_673_0), (Mathf.Lerp(iter_673_1.color.b, arg_670_1.hightColor2.b, (arg_670_1.time_ - 0) / var_673_0)))
							else
								local var_673_1 = Mathf.Lerp(iter_673_1.color.r, 0.5, (arg_670_1.time_ - 0) / var_673_0)

								iter_673_1.color = Color.New(var_673_1, var_673_1, var_673_1)
							end
						end
					end
				end
			end

			if arg_670_1.time_ >= 0 + var_673_0 and arg_670_1.time_ < 0 + var_673_0 + arg_673_0 and not isNil(arg_670_1.actors_["1038"]) and arg_670_1.var_.actorSpriteComps1038 then
				for iter_673_2, iter_673_3 in pairs(arg_670_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_673_3 then
						iter_673_3.color = arg_670_1.isInRecall_ and (arg_670_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_670_1.var_.actorSpriteComps1038 = nil
			end

			local var_673_2 = 0
			local var_673_3 = 0.45

			if 0 < arg_670_1.time_ and arg_670_1.time_ <= var_673_2 + arg_673_0 then
				arg_670_1.talkMaxDuration = 0
				arg_670_1.dialogCg_.alpha = 1

				arg_670_1.dialog_:SetActive(true)
				SetActive(arg_670_1.leftNameGo_, true)

				arg_670_1.leftNameTxt_.text = arg_670_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_670_1.leftNameTxt_.transform)

				arg_670_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_670_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_670_1:RecordName(arg_670_1.leftNameTxt_.text)
				SetActive(arg_670_1.iconTrs_.gameObject, false)
				arg_670_1.callingController_:SetSelectedState("normal")

				local var_673_4 = arg_670_1:GetWordFromCfg(115301165)
				local var_673_5 = arg_670_1:FormatText(var_673_4.content)

				arg_670_1.text_.text = var_673_5

				LuaForUtil.ClearLinePrefixSymbol(arg_670_1.text_)

				local var_673_7 = 18 <= 0 and var_673_3 or var_673_3 * (utf8.len(var_673_5) / 18)

				if (18 <= 0 and var_673_3 or var_673_3 * (utf8.len(var_673_5) / 18)) > 0 and var_673_3 < var_673_7 then
					arg_670_1.talkMaxDuration = var_673_7

					if var_673_7 + var_673_2 > arg_670_1.duration_ then
						arg_670_1.duration_ = var_673_7 + var_673_2
					end
				end

				arg_670_1.text_.text = var_673_5
				arg_670_1.typewritter.percent = 0

				arg_670_1.typewritter:SetDirty()
				arg_670_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301165", "story_v_out_115301.awb") ~= 0 then
					local var_673_8 = manager.audio:GetVoiceLength("story_v_out_115301", "115301165", "story_v_out_115301.awb") / 1000

					if var_673_8 + var_673_2 > arg_670_1.duration_ then
						arg_670_1.duration_ = var_673_8 + var_673_2
					end

					if var_673_4.prefab_name ~= "" and arg_670_1.actors_[var_673_4.prefab_name] ~= nil then
						local var_673_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_670_1.actors_[var_673_4.prefab_name].transform, "story_v_out_115301", "115301165", "story_v_out_115301.awb")

						arg_670_1:RecordAudio("115301165", var_673_9)
						arg_670_1:RecordAudio("115301165", var_673_9)
					else
						arg_670_1:AudioAction("play", "voice", "story_v_out_115301", "115301165", "story_v_out_115301.awb")
					end

					arg_670_1:RecordHistoryTalkVoice("story_v_out_115301", "115301165", "story_v_out_115301.awb")
				end

				arg_670_1:RecordContent(arg_670_1.text_.text)
			end

			local var_673_10 = math.max(var_673_3, arg_670_1.talkMaxDuration)

			if var_673_2 <= arg_670_1.time_ and arg_670_1.time_ < var_673_2 + var_673_10 then
				arg_670_1.typewritter.percent = (arg_670_1.time_ - var_673_2) / var_673_10

				arg_670_1.typewritter:SetDirty()
			end

			if arg_670_1.time_ >= var_673_2 + var_673_10 and arg_670_1.time_ < var_673_2 + var_673_10 + arg_673_0 then
				arg_670_1.typewritter.percent = 1

				arg_670_1.typewritter:SetDirty()
				arg_670_1:ShowNextGo(true)
			end
		end

		arg_670_1.nodeConfigList_ = {}

		arg_670_1:InitPlayNodeList()
	end,
	Play115301166 = function(arg_674_0, arg_674_1)
		arg_674_1.time_ = 0
		arg_674_1.frameCnt_ = 0
		arg_674_1.state_ = "playing"
		arg_674_1.curTalkId_ = 115301166
		arg_674_1.duration_ = 18.43

		local var_674_0 = {
			ja = 12.6,
			ko = 14.066,
			zh = 13.6,
			en = 18.433
		}
		local var_674_1 = manager.audio:GetLocalizationFlag()

		if var_674_0[var_674_1] ~= nil then
			arg_674_1.duration_ = var_674_0[var_674_1]
		end

		SetActive(arg_674_1.tipsGo_, false)

		function arg_674_1.onSingleLineFinish_()
			arg_674_1.onSingleLineUpdate_ = nil
			arg_674_1.onSingleLineFinish_ = nil
			arg_674_1.state_ = "waiting"
		end

		function arg_674_1.playNext_(arg_676_0)
			if arg_676_0 == 1 then
				arg_674_0:Play115301167(arg_674_1)
			end
		end

		function arg_674_1.onSingleLineUpdate_(arg_677_0)
			local var_677_0 = 1.25

			if 0 < arg_674_1.time_ and arg_674_1.time_ <= 0 + arg_677_0 then
				arg_674_1.talkMaxDuration = 0
				arg_674_1.dialogCg_.alpha = 1

				arg_674_1.dialog_:SetActive(true)
				SetActive(arg_674_1.leftNameGo_, true)

				arg_674_1.leftNameTxt_.text = arg_674_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_674_1.leftNameTxt_.transform)

				arg_674_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_674_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_674_1:RecordName(arg_674_1.leftNameTxt_.text)
				SetActive(arg_674_1.iconTrs_.gameObject, false)
				arg_674_1.callingController_:SetSelectedState("normal")

				local var_677_1 = arg_674_1:GetWordFromCfg(115301166)
				local var_677_2 = arg_674_1:FormatText(var_677_1.content)

				arg_674_1.text_.text = var_677_2

				LuaForUtil.ClearLinePrefixSymbol(arg_674_1.text_)

				local var_677_4 = 50 <= 0 and var_677_0 or var_677_0 * (utf8.len(var_677_2) / 50)

				if (50 <= 0 and var_677_0 or var_677_0 * (utf8.len(var_677_2) / 50)) > 0 and var_677_0 < var_677_4 then
					arg_674_1.talkMaxDuration = var_677_4

					if var_677_4 + 0 > arg_674_1.duration_ then
						arg_674_1.duration_ = var_677_4 + 0
					end
				end

				arg_674_1.text_.text = var_677_2
				arg_674_1.typewritter.percent = 0

				arg_674_1.typewritter:SetDirty()
				arg_674_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301166", "story_v_out_115301.awb") ~= 0 then
					local var_677_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301166", "story_v_out_115301.awb") / 1000

					if var_677_5 + 0 > arg_674_1.duration_ then
						arg_674_1.duration_ = var_677_5 + 0
					end

					if var_677_1.prefab_name ~= "" and arg_674_1.actors_[var_677_1.prefab_name] ~= nil then
						local var_677_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_674_1.actors_[var_677_1.prefab_name].transform, "story_v_out_115301", "115301166", "story_v_out_115301.awb")

						arg_674_1:RecordAudio("115301166", var_677_6)
						arg_674_1:RecordAudio("115301166", var_677_6)
					else
						arg_674_1:AudioAction("play", "voice", "story_v_out_115301", "115301166", "story_v_out_115301.awb")
					end

					arg_674_1:RecordHistoryTalkVoice("story_v_out_115301", "115301166", "story_v_out_115301.awb")
				end

				arg_674_1:RecordContent(arg_674_1.text_.text)
			end

			local var_677_7 = math.max(var_677_0, arg_674_1.talkMaxDuration)

			if 0 <= arg_674_1.time_ and arg_674_1.time_ < 0 + var_677_7 then
				arg_674_1.typewritter.percent = (arg_674_1.time_ - 0) / var_677_7

				arg_674_1.typewritter:SetDirty()
			end

			if arg_674_1.time_ >= 0 + var_677_7 and arg_674_1.time_ < 0 + var_677_7 + arg_677_0 then
				arg_674_1.typewritter.percent = 1

				arg_674_1.typewritter:SetDirty()
				arg_674_1:ShowNextGo(true)
			end
		end

		arg_674_1.nodeConfigList_ = {}

		arg_674_1:InitPlayNodeList()
	end,
	Play115301167 = function(arg_678_0, arg_678_1)
		arg_678_1.time_ = 0
		arg_678_1.frameCnt_ = 0
		arg_678_1.state_ = "playing"
		arg_678_1.curTalkId_ = 115301167
		arg_678_1.duration_ = 9.97

		local var_678_0 = {
			ja = 9.2,
			ko = 9.133,
			zh = 9.966,
			en = 9.466
		}
		local var_678_1 = manager.audio:GetLocalizationFlag()

		if var_678_0[var_678_1] ~= nil then
			arg_678_1.duration_ = var_678_0[var_678_1]
		end

		SetActive(arg_678_1.tipsGo_, false)

		function arg_678_1.onSingleLineFinish_()
			arg_678_1.onSingleLineUpdate_ = nil
			arg_678_1.onSingleLineFinish_ = nil
			arg_678_1.state_ = "waiting"
		end

		function arg_678_1.playNext_(arg_680_0)
			if arg_680_0 == 1 then
				arg_678_0:Play115301168(arg_678_1)
			end
		end

		function arg_678_1.onSingleLineUpdate_(arg_681_0)
			local var_681_0 = 0.925

			if 0 < arg_678_1.time_ and arg_678_1.time_ <= 0 + arg_681_0 then
				arg_678_1.talkMaxDuration = 0
				arg_678_1.dialogCg_.alpha = 1

				arg_678_1.dialog_:SetActive(true)
				SetActive(arg_678_1.leftNameGo_, true)

				arg_678_1.leftNameTxt_.text = arg_678_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_678_1.leftNameTxt_.transform)

				arg_678_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_678_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_678_1:RecordName(arg_678_1.leftNameTxt_.text)
				SetActive(arg_678_1.iconTrs_.gameObject, false)
				arg_678_1.callingController_:SetSelectedState("normal")

				local var_681_1 = arg_678_1:GetWordFromCfg(115301167)
				local var_681_2 = arg_678_1:FormatText(var_681_1.content)

				arg_678_1.text_.text = var_681_2

				LuaForUtil.ClearLinePrefixSymbol(arg_678_1.text_)

				local var_681_4 = 37 <= 0 and var_681_0 or var_681_0 * (utf8.len(var_681_2) / 37)

				if (37 <= 0 and var_681_0 or var_681_0 * (utf8.len(var_681_2) / 37)) > 0 and var_681_0 < var_681_4 then
					arg_678_1.talkMaxDuration = var_681_4

					if var_681_4 + 0 > arg_678_1.duration_ then
						arg_678_1.duration_ = var_681_4 + 0
					end
				end

				arg_678_1.text_.text = var_681_2
				arg_678_1.typewritter.percent = 0

				arg_678_1.typewritter:SetDirty()
				arg_678_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301167", "story_v_out_115301.awb") ~= 0 then
					local var_681_5 = manager.audio:GetVoiceLength("story_v_out_115301", "115301167", "story_v_out_115301.awb") / 1000

					if var_681_5 + 0 > arg_678_1.duration_ then
						arg_678_1.duration_ = var_681_5 + 0
					end

					if var_681_1.prefab_name ~= "" and arg_678_1.actors_[var_681_1.prefab_name] ~= nil then
						local var_681_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_678_1.actors_[var_681_1.prefab_name].transform, "story_v_out_115301", "115301167", "story_v_out_115301.awb")

						arg_678_1:RecordAudio("115301167", var_681_6)
						arg_678_1:RecordAudio("115301167", var_681_6)
					else
						arg_678_1:AudioAction("play", "voice", "story_v_out_115301", "115301167", "story_v_out_115301.awb")
					end

					arg_678_1:RecordHistoryTalkVoice("story_v_out_115301", "115301167", "story_v_out_115301.awb")
				end

				arg_678_1:RecordContent(arg_678_1.text_.text)
			end

			local var_681_7 = math.max(var_681_0, arg_678_1.talkMaxDuration)

			if 0 <= arg_678_1.time_ and arg_678_1.time_ < 0 + var_681_7 then
				arg_678_1.typewritter.percent = (arg_678_1.time_ - 0) / var_681_7

				arg_678_1.typewritter:SetDirty()
			end

			if arg_678_1.time_ >= 0 + var_681_7 and arg_678_1.time_ < 0 + var_681_7 + arg_681_0 then
				arg_678_1.typewritter.percent = 1

				arg_678_1.typewritter:SetDirty()
				arg_678_1:ShowNextGo(true)
			end
		end

		arg_678_1.nodeConfigList_ = {}

		arg_678_1:InitPlayNodeList()
	end,
	Play115301168 = function(arg_682_0, arg_682_1)
		arg_682_1.time_ = 0
		arg_682_1.frameCnt_ = 0
		arg_682_1.state_ = "playing"
		arg_682_1.curTalkId_ = 115301168
		arg_682_1.duration_ = 9

		SetActive(arg_682_1.tipsGo_, false)

		function arg_682_1.onSingleLineFinish_()
			arg_682_1.onSingleLineUpdate_ = nil
			arg_682_1.onSingleLineFinish_ = nil
			arg_682_1.state_ = "waiting"
		end

		function arg_682_1.playNext_(arg_684_0)
			if arg_684_0 == 1 then
				arg_682_0:Play115301169(arg_682_1)
			end
		end

		function arg_682_1.onSingleLineUpdate_(arg_685_0)
			if 2 < arg_682_1.time_ and arg_682_1.time_ <= 2 + arg_685_0 then
				local var_685_0 = arg_682_1.bgs_.F01

				arg_682_1.bgs_.F01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_685_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_685_1 = var_685_0:GetComponent("SpriteRenderer")

				if var_685_1 and var_685_1.sprite then
					local var_685_2 = 2 * (var_685_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_685_0.transform.localScale = Vector3.New(var_685_2 / var_685_1.sprite.bounds.size.y < var_685_2 * manager.ui.mainCameraCom_.aspect / var_685_1.sprite.bounds.size.x and var_685_2 * manager.ui.mainCameraCom_.aspect / var_685_1.sprite.bounds.size.x or var_685_2 / var_685_1.sprite.bounds.size.y, var_685_2 / var_685_1.sprite.bounds.size.y < var_685_2 * manager.ui.mainCameraCom_.aspect / var_685_1.sprite.bounds.size.x and var_685_2 * manager.ui.mainCameraCom_.aspect / var_685_1.sprite.bounds.size.x or var_685_2 / var_685_1.sprite.bounds.size.y, 0)
				end

				for iter_685_0, iter_685_1 in pairs(arg_682_1.bgs_) do
					if iter_685_0 ~= "F01" then
						iter_685_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_685_3 = 0

			if 0 < arg_682_1.time_ and arg_682_1.time_ <= var_685_3 + arg_685_0 then
				arg_682_1.mask_.enabled = true
				arg_682_1.mask_.raycastTarget = false

				arg_682_1:SetGaussion(false)
			end

			local var_685_4 = 2

			if var_685_3 <= arg_682_1.time_ and arg_682_1.time_ < var_685_3 + var_685_4 then
				local var_685_5 = Color.New(0, 0, 0)

				var_685_5.a = Mathf.Lerp(0, 1, (arg_682_1.time_ - var_685_3) / var_685_4)
				arg_682_1.mask_.color = var_685_5
			end

			if arg_682_1.time_ >= var_685_3 + var_685_4 and arg_682_1.time_ < var_685_3 + var_685_4 + arg_685_0 then
				local var_685_6 = Color.New(0, 0, 0)

				var_685_6.a = 1
				arg_682_1.mask_.color = var_685_6
			end

			local var_685_7 = 2

			if 2 < arg_682_1.time_ and arg_682_1.time_ <= var_685_7 + arg_685_0 then
				arg_682_1.mask_.enabled = true
				arg_682_1.mask_.raycastTarget = false

				arg_682_1:SetGaussion(false)
			end

			local var_685_8 = 2

			if var_685_7 <= arg_682_1.time_ and arg_682_1.time_ < var_685_7 + var_685_8 then
				local var_685_9 = Color.New(0, 0, 0)

				var_685_9.a = Mathf.Lerp(1, 0, (arg_682_1.time_ - var_685_7) / var_685_8)
				arg_682_1.mask_.color = var_685_9
			end

			if arg_682_1.time_ >= var_685_7 + var_685_8 and arg_682_1.time_ < var_685_7 + var_685_8 + arg_685_0 then
				local var_685_10 = Color.New(0, 0, 0)

				arg_682_1.mask_.enabled = false
				var_685_10.a = 0
				arg_682_1.mask_.color = var_685_10
			end

			local var_685_11 = arg_682_1.actors_["1038"].transform

			if 2 < arg_682_1.time_ and arg_682_1.time_ <= 2 + arg_685_0 then
				arg_682_1.var_.moveOldPos1038 = var_685_11.localPosition
				var_685_11.localScale = Vector3.New(1, 1, 1)

				arg_682_1:CheckSpriteTmpPos("1038", 0)

				for iter_685_2 = 0, var_685_11.childCount - 1 do
					local var_685_12 = var_685_11:GetChild(iter_685_2)

					if var_685_12.name == "split_1" or not string.find(var_685_12.name, "split") then
						var_685_12.gameObject:SetActive(true)
					else
						var_685_12.gameObject:SetActive(false)
					end
				end
			end

			local var_685_13 = 0.001

			if 2 <= arg_682_1.time_ and arg_682_1.time_ < 2 + var_685_13 then
				var_685_11.localPosition = Vector3.Lerp(arg_682_1.var_.moveOldPos1038, Vector3.New(-2000, -400, 0), (arg_682_1.time_ - 2) / var_685_13)
			end

			if arg_682_1.time_ >= 2 + var_685_13 and arg_682_1.time_ < 2 + var_685_13 + arg_685_0 then
				var_685_11.localPosition = Vector3.New(-2000, -400, 0)
			end

			local var_685_14 = 2

			arg_682_1.isInRecall_ = false

			if var_685_14 < arg_682_1.time_ and arg_682_1.time_ <= var_685_14 + arg_685_0 then
				arg_682_1.screenFilterGo_:SetActive(false)

				for iter_685_3, iter_685_4 in pairs(arg_682_1.actors_) do
					for iter_685_5, iter_685_6 in ipairs((iter_685_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_685_6.color = iter_685_6.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_685_15 = 0.0166666666666667

			if var_685_14 <= arg_682_1.time_ and arg_682_1.time_ < var_685_14 + var_685_15 then
				arg_682_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_682_1.time_ - var_685_14) / var_685_15)
			end

			if arg_682_1.time_ >= var_685_14 + var_685_15 and arg_682_1.time_ < var_685_14 + var_685_15 + arg_685_0 then
				arg_682_1.screenFilterEffect_.weight = 0
			end

			if arg_682_1.frameCnt_ <= 1 then
				arg_682_1.dialog_:SetActive(false)
			end

			local var_685_16 = 4
			local var_685_17 = 0.625

			if 4 < arg_682_1.time_ and arg_682_1.time_ <= var_685_16 + arg_685_0 then
				arg_682_1.talkMaxDuration = 0

				arg_682_1.dialog_:SetActive(true)

				arg_682_1.dialogCg_.alpha = 0

				local var_685_18 = LeanTween.value(arg_682_1.dialog_, 0, 1, 0.3)

				var_685_18:setOnUpdate(LuaHelper.FloatAction(function(arg_686_0)
					arg_682_1.dialogCg_.alpha = arg_686_0
				end))
				var_685_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_682_1.dialog_)
					var_685_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_682_1.duration_ = arg_682_1.duration_ + 0.3

				SetActive(arg_682_1.leftNameGo_, false)

				arg_682_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_682_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_682_1:RecordName(arg_682_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_682_1.iconTrs_.gameObject, false)
				arg_682_1.callingController_:SetSelectedState("normal")

				local var_685_19 = arg_682_1:FormatText(arg_682_1:GetWordFromCfg(115301168).content)

				arg_682_1.text_.text = var_685_19

				LuaForUtil.ClearLinePrefixSymbol(arg_682_1.text_)

				local var_685_21 = 25 <= 0 and var_685_17 or var_685_17 * (utf8.len(var_685_19) / 25)

				if (25 <= 0 and var_685_17 or var_685_17 * (utf8.len(var_685_19) / 25)) > 0 and var_685_17 < var_685_21 then
					arg_682_1.talkMaxDuration = var_685_21
					var_685_16 = var_685_16 + 0.3

					if var_685_21 + var_685_16 > arg_682_1.duration_ then
						arg_682_1.duration_ = var_685_21 + var_685_16
					end
				end

				arg_682_1.text_.text = var_685_19
				arg_682_1.typewritter.percent = 0

				arg_682_1.typewritter:SetDirty()
				arg_682_1:ShowNextGo(false)
				arg_682_1:RecordContent(arg_682_1.text_.text)
			end

			local var_685_22 = var_685_16 + 0.3
			local var_685_23 = math.max(var_685_17, arg_682_1.talkMaxDuration)

			if var_685_16 + 0.3 <= arg_682_1.time_ and arg_682_1.time_ < var_685_22 + var_685_23 then
				arg_682_1.typewritter.percent = (arg_682_1.time_ - var_685_22) / var_685_23

				arg_682_1.typewritter:SetDirty()
			end

			if arg_682_1.time_ >= var_685_22 + var_685_23 and arg_682_1.time_ < var_685_22 + var_685_23 + arg_685_0 then
				arg_682_1.typewritter.percent = 1

				arg_682_1.typewritter:SetDirty()
				arg_682_1:ShowNextGo(true)
			end
		end

		arg_682_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_682_1:InitPlayNodeList()
	end,
	Play115301169 = function(arg_688_0, arg_688_1)
		arg_688_1.time_ = 0
		arg_688_1.frameCnt_ = 0
		arg_688_1.state_ = "playing"
		arg_688_1.curTalkId_ = 115301169
		arg_688_1.duration_ = 9.77

		local var_688_0 = {
			ja = 8.466,
			ko = 9.233,
			zh = 9.766,
			en = 6.9
		}
		local var_688_1 = manager.audio:GetLocalizationFlag()

		if var_688_0[var_688_1] ~= nil then
			arg_688_1.duration_ = var_688_0[var_688_1]
		end

		SetActive(arg_688_1.tipsGo_, false)

		function arg_688_1.onSingleLineFinish_()
			arg_688_1.onSingleLineUpdate_ = nil
			arg_688_1.onSingleLineFinish_ = nil
			arg_688_1.state_ = "waiting"
			arg_688_1.auto_ = false
		end

		function arg_688_1.playNext_(arg_690_0)
			arg_688_1.onStoryFinished_()
		end

		function arg_688_1.onSingleLineUpdate_(arg_691_0)
			if 0 < arg_688_1.time_ and arg_688_1.time_ <= 0 + arg_691_0 then
				arg_688_1.var_.moveOldPos1038 = arg_688_1.actors_["1038"].transform.localPosition
				arg_688_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_688_1:CheckSpriteTmpPos("1038", 3)

				for iter_691_0 = 0, arg_688_1.actors_["1038"].transform.childCount - 1 do
					local var_691_0 = arg_688_1.actors_["1038"].transform:GetChild(iter_691_0)

					if var_691_0.name == "split_9" or not string.find(var_691_0.name, "split") then
						var_691_0.gameObject:SetActive(true)
					else
						var_691_0.gameObject:SetActive(false)
					end
				end
			end

			local var_691_1 = 0.001

			if 0 <= arg_688_1.time_ and arg_688_1.time_ < 0 + var_691_1 then
				arg_688_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_688_1.var_.moveOldPos1038, Vector3.New(0, -400, 0), (arg_688_1.time_ - 0) / var_691_1)
			end

			if arg_688_1.time_ >= 0 + var_691_1 and arg_688_1.time_ < 0 + var_691_1 + arg_691_0 then
				arg_688_1.actors_["1038"].transform.localPosition = Vector3.New(0, -400, 0)
			end

			local var_691_2 = arg_688_1.actors_["1038"]

			if 0 < arg_688_1.time_ and arg_688_1.time_ <= 0 + arg_691_0 and not isNil(var_691_2) and arg_688_1.var_.actorSpriteComps1038 == nil then
				arg_688_1.var_.actorSpriteComps1038 = var_691_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_691_3 = 0.2

			if 0 <= arg_688_1.time_ and arg_688_1.time_ < 0 + var_691_3 and not isNil(var_691_2) then
				if arg_688_1.var_.actorSpriteComps1038 then
					for iter_691_1, iter_691_2 in pairs(arg_688_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_691_2 then
							if arg_688_1.isInRecall_ then
								iter_691_2.color = Color.New(Mathf.Lerp(iter_691_2.color.r, arg_688_1.hightColor1.r, (arg_688_1.time_ - 0) / var_691_3), Mathf.Lerp(iter_691_2.color.g, arg_688_1.hightColor1.g, (arg_688_1.time_ - 0) / var_691_3), (Mathf.Lerp(iter_691_2.color.b, arg_688_1.hightColor1.b, (arg_688_1.time_ - 0) / var_691_3)))
							else
								local var_691_4 = Mathf.Lerp(iter_691_2.color.r, 1, (arg_688_1.time_ - 0) / var_691_3)

								iter_691_2.color = Color.New(var_691_4, var_691_4, var_691_4)
							end
						end
					end
				end
			end

			if arg_688_1.time_ >= 0 + var_691_3 and arg_688_1.time_ < 0 + var_691_3 + arg_691_0 and not isNil(var_691_2) and arg_688_1.var_.actorSpriteComps1038 then
				for iter_691_3, iter_691_4 in pairs(arg_688_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_691_4 then
						iter_691_4.color = arg_688_1.isInRecall_ and (arg_688_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_688_1.var_.actorSpriteComps1038 = nil
			end

			if 0 < arg_688_1.time_ and arg_688_1.time_ <= 0 + arg_691_0 then
				local var_691_5 = arg_688_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_691_5 then
					arg_688_1.var_.alphaOldValue1038 = var_691_5.alpha
					arg_688_1.var_.characterEffect1038 = var_691_5
				end

				arg_688_1.var_.alphaOldValue1038 = 0
			end

			local var_691_6 = 0.333333333333333

			if 0 <= arg_688_1.time_ and arg_688_1.time_ < 0 + var_691_6 then
				if arg_688_1.var_.characterEffect1038 then
					arg_688_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_688_1.var_.alphaOldValue1038, 1, (arg_688_1.time_ - 0) / var_691_6)
				end
			end

			if arg_688_1.time_ >= 0 + var_691_6 and arg_688_1.time_ < 0 + var_691_6 + arg_691_0 and arg_688_1.var_.characterEffect1038 then
				arg_688_1.var_.characterEffect1038.alpha = 1
			end

			local var_691_7 = 0
			local var_691_8 = 0.7

			if 0 < arg_688_1.time_ and arg_688_1.time_ <= var_691_7 + arg_691_0 then
				arg_688_1.talkMaxDuration = 0
				arg_688_1.dialogCg_.alpha = 1

				arg_688_1.dialog_:SetActive(true)
				SetActive(arg_688_1.leftNameGo_, true)

				arg_688_1.leftNameTxt_.text = arg_688_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_688_1.leftNameTxt_.transform)

				arg_688_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_688_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_688_1:RecordName(arg_688_1.leftNameTxt_.text)
				SetActive(arg_688_1.iconTrs_.gameObject, false)
				arg_688_1.callingController_:SetSelectedState("normal")

				local var_691_9 = arg_688_1:GetWordFromCfg(115301169)
				local var_691_10 = arg_688_1:FormatText(var_691_9.content)

				arg_688_1.text_.text = var_691_10

				LuaForUtil.ClearLinePrefixSymbol(arg_688_1.text_)

				local var_691_12 = 28 <= 0 and var_691_8 or var_691_8 * (utf8.len(var_691_10) / 28)

				if (28 <= 0 and var_691_8 or var_691_8 * (utf8.len(var_691_10) / 28)) > 0 and var_691_8 < var_691_12 then
					arg_688_1.talkMaxDuration = var_691_12

					if var_691_12 + var_691_7 > arg_688_1.duration_ then
						arg_688_1.duration_ = var_691_12 + var_691_7
					end
				end

				arg_688_1.text_.text = var_691_10
				arg_688_1.typewritter.percent = 0

				arg_688_1.typewritter:SetDirty()
				arg_688_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115301", "115301169", "story_v_out_115301.awb") ~= 0 then
					local var_691_13 = manager.audio:GetVoiceLength("story_v_out_115301", "115301169", "story_v_out_115301.awb") / 1000

					if var_691_13 + var_691_7 > arg_688_1.duration_ then
						arg_688_1.duration_ = var_691_13 + var_691_7
					end

					if var_691_9.prefab_name ~= "" and arg_688_1.actors_[var_691_9.prefab_name] ~= nil then
						local var_691_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_688_1.actors_[var_691_9.prefab_name].transform, "story_v_out_115301", "115301169", "story_v_out_115301.awb")

						arg_688_1:RecordAudio("115301169", var_691_14)
						arg_688_1:RecordAudio("115301169", var_691_14)
					else
						arg_688_1:AudioAction("play", "voice", "story_v_out_115301", "115301169", "story_v_out_115301.awb")
					end

					arg_688_1:RecordHistoryTalkVoice("story_v_out_115301", "115301169", "story_v_out_115301.awb")
				end

				arg_688_1:RecordContent(arg_688_1.text_.text)
			end

			local var_691_15 = math.max(var_691_8, arg_688_1.talkMaxDuration)

			if var_691_7 <= arg_688_1.time_ and arg_688_1.time_ < var_691_7 + var_691_15 then
				arg_688_1.typewritter.percent = (arg_688_1.time_ - var_691_7) / var_691_15

				arg_688_1.typewritter:SetDirty()
			end

			if arg_688_1.time_ >= var_691_7 + var_691_15 and arg_688_1.time_ < var_691_7 + var_691_15 + arg_691_0 then
				arg_688_1.typewritter.percent = 1

				arg_688_1.typewritter:SetDirty()
				arg_688_1:ShowNextGo(true)
			end
		end

		arg_688_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_688_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F01",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/RO0503",
		"TextureConfig/Background/ST22",
		"TextureConfig/Background/F01a"
	},
	voices = {
		"story_v_out_115301.awb"
	}
}
