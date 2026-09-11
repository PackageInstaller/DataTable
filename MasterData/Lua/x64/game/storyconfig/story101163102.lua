return {
	Play116312001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116312001
		arg_1_1.duration_ = 4.63

		local var_1_0 = {
			zh = 4.633,
			ja = 4.3
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play116312002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.B13c == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13c")
				var_4_0.name = "B13c"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B13c = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B13c

				arg_1_1.bgs_.B13c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B13c" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

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

			if 0.266666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.266666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

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

			local var_4_14 = 2
			local var_4_15 = 0.275

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_16 = arg_1_1:GetWordFromCfg(116312001)
				local var_4_17 = arg_1_1:FormatText(var_4_16.content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 11 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 11)

				if (11 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 11)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312001", "story_v_out_116312.awb") ~= 0 then
					local var_4_20 = manager.audio:GetVoiceLength("story_v_out_116312", "116312001", "story_v_out_116312.awb") / 1000

					if var_4_20 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_14
					end

					if var_4_16.prefab_name ~= "" and arg_1_1.actors_[var_4_16.prefab_name] ~= nil then
						local var_4_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_16.prefab_name].transform, "story_v_out_116312", "116312001", "story_v_out_116312.awb")

						arg_1_1:RecordAudio("116312001", var_4_21)
						arg_1_1:RecordAudio("116312001", var_4_21)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_116312", "116312001", "story_v_out_116312.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_116312", "116312001", "story_v_out_116312.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 <= arg_1_1.time_ and arg_1_1.time_ < var_4_14 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_14) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_14 + var_4_22 and arg_1_1.time_ < var_4_14 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play116312002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 116312002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play116312003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if arg_7_1.actors_["1184ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1184ui_story"))) then
				local var_10_0 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_7_1.stage_.transform)

				var_10_0.name = "1184ui_story"
				var_10_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.actors_["1184ui_story"] = var_10_0

				local var_10_1 = var_10_0:GetComponentInChildren(typeof(CharacterEffect))

				var_10_1.enabled = true

				local var_10_2 = GameObjectTools.GetOrAddComponent(var_10_0, typeof(DynamicBoneHelper))

				if var_10_2 then
					var_10_2:EnableDynamicBone(false)
				end

				arg_7_1:ShowWeapon(var_10_1.transform, false)

				arg_7_1.var_["1184ui_story" .. "Animator"] = var_10_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_7_1.var_["1184ui_story" .. "Animator"].applyRootMotion = true
				arg_7_1.var_["1184ui_story" .. "LipSync"] = var_10_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_10_3 = arg_7_1.actors_["1184ui_story"].transform

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos1184ui_story = var_10_3.localPosition
			end

			local var_10_4 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_4 then
				var_10_3.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_7_1.time_ - 0) / var_10_4)
				var_10_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_3.position).x, (manager.ui.mainCamera.transform.position - var_10_3.position).y, (manager.ui.mainCamera.transform.position - var_10_3.position).z)
				var_10_3.localEulerAngles.z = 0
				var_10_3.localEulerAngles.x = 0
				var_10_3.localEulerAngles = var_10_3.localEulerAngles
			end

			if arg_7_1.time_ >= 0 + var_10_4 and arg_7_1.time_ < 0 + var_10_4 + arg_10_0 then
				var_10_3.localPosition = Vector3.New(0, 100, 0)
				var_10_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_3.position).x, (manager.ui.mainCamera.transform.position - var_10_3.position).y, (manager.ui.mainCamera.transform.position - var_10_3.position).z)
				var_10_3.localEulerAngles.z = 0
				var_10_3.localEulerAngles.x = 0
				var_10_3.localEulerAngles = var_10_3.localEulerAngles
			end

			local var_10_5 = 0
			local var_10_6 = 1.5

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_5 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_7 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(116312002).content)

				arg_7_1.text_.text = var_10_7

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_9 = 60 <= 0 and var_10_6 or var_10_6 * (utf8.len(var_10_7) / 60)

				if (60 <= 0 and var_10_6 or var_10_6 * (utf8.len(var_10_7) / 60)) > 0 and var_10_6 < var_10_9 then
					arg_7_1.talkMaxDuration = var_10_9

					if var_10_9 + var_10_5 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_9 + var_10_5
					end
				end

				arg_7_1.text_.text = var_10_7
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_10 = math.max(var_10_6, arg_7_1.talkMaxDuration)

			if var_10_5 <= arg_7_1.time_ and arg_7_1.time_ < var_10_5 + var_10_10 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_5) / var_10_10

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_5 + var_10_10 and arg_7_1.time_ < var_10_5 + var_10_10 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_7_1:InitPlayNodeList()
	end,
	Play116312003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 116312003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play116312004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 1.025

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_1 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(116312003).content)

				arg_11_1.text_.text = var_14_1

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_3 = 41 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_1) / 41)

				if (41 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_1) / 41)) > 0 and var_14_0 < var_14_3 then
					arg_11_1.talkMaxDuration = var_14_3

					if var_14_3 + 0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_3 + 0
					end
				end

				arg_11_1.text_.text = var_14_1
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_4 = math.max(var_14_0, arg_11_1.talkMaxDuration)

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_4 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - 0) / var_14_4

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= 0 + var_14_4 and arg_11_1.time_ < 0 + var_14_4 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play116312004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 116312004
		arg_15_1.duration_ = 5.5

		local var_15_0 = {
			zh = 5.5,
			ja = 4.866
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
				arg_15_0:Play116312005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0.475

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4031")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_1 = arg_15_1:GetWordFromCfg(116312004)
				local var_18_2 = arg_15_1:FormatText(var_18_1.content)

				arg_15_1.text_.text = var_18_2

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_4 = 19 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_2) / 19)

				if (19 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_2) / 19)) > 0 and var_18_0 < var_18_4 then
					arg_15_1.talkMaxDuration = var_18_4

					if var_18_4 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_4 + 0
					end
				end

				arg_15_1.text_.text = var_18_2
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312004", "story_v_out_116312.awb") ~= 0 then
					local var_18_5 = manager.audio:GetVoiceLength("story_v_out_116312", "116312004", "story_v_out_116312.awb") / 1000

					if var_18_5 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_5 + 0
					end

					if var_18_1.prefab_name ~= "" and arg_15_1.actors_[var_18_1.prefab_name] ~= nil then
						local var_18_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_1.prefab_name].transform, "story_v_out_116312", "116312004", "story_v_out_116312.awb")

						arg_15_1:RecordAudio("116312004", var_18_6)
						arg_15_1:RecordAudio("116312004", var_18_6)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_116312", "116312004", "story_v_out_116312.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_116312", "116312004", "story_v_out_116312.awb")
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
	Play116312005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 116312005
		arg_19_1.duration_ = 2.4

		local var_19_0 = {
			zh = 2.4,
			ja = 1.999999999999
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play116312006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1184ui_story = arg_19_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_22_0 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 then
				arg_19_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_19_1.time_ - 0) / var_22_0)
				arg_19_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1184ui_story"].transform.position).z)
				arg_19_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["1184ui_story"].transform.localEulerAngles = arg_19_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 then
				arg_19_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_19_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1184ui_story"].transform.position).z)
				arg_19_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["1184ui_story"].transform.localEulerAngles = arg_19_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_22_1 = arg_19_1.actors_["1184ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_1) and arg_19_1.var_.characterEffect1184ui_story == nil then
				arg_19_1.var_.characterEffect1184ui_story = var_22_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_2 = 0.2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_2 and not isNil(var_22_1) then
				if arg_19_1.var_.characterEffect1184ui_story and not isNil(var_22_1) then
					arg_19_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= 0 + var_22_2 and arg_19_1.time_ < 0 + var_22_2 + arg_22_0 and not isNil(var_22_1) and arg_19_1.var_.characterEffect1184ui_story then
				arg_19_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_22_4 = 0
			local var_22_5 = 0.175

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_4 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_6 = arg_19_1:GetWordFromCfg(116312005)
				local var_22_7 = arg_19_1:FormatText(var_22_6.content)

				arg_19_1.text_.text = var_22_7

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_9 = 7 <= 0 and var_22_5 or var_22_5 * (utf8.len(var_22_7) / 7)

				if (7 <= 0 and var_22_5 or var_22_5 * (utf8.len(var_22_7) / 7)) > 0 and var_22_5 < var_22_9 then
					arg_19_1.talkMaxDuration = var_22_9

					if var_22_9 + var_22_4 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_9 + var_22_4
					end
				end

				arg_19_1.text_.text = var_22_7
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312005", "story_v_out_116312.awb") ~= 0 then
					local var_22_10 = manager.audio:GetVoiceLength("story_v_out_116312", "116312005", "story_v_out_116312.awb") / 1000

					if var_22_10 + var_22_4 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_10 + var_22_4
					end

					if var_22_6.prefab_name ~= "" and arg_19_1.actors_[var_22_6.prefab_name] ~= nil then
						local var_22_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_6.prefab_name].transform, "story_v_out_116312", "116312005", "story_v_out_116312.awb")

						arg_19_1:RecordAudio("116312005", var_22_11)
						arg_19_1:RecordAudio("116312005", var_22_11)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_116312", "116312005", "story_v_out_116312.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_116312", "116312005", "story_v_out_116312.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_12 = math.max(var_22_5, arg_19_1.talkMaxDuration)

			if var_22_4 <= arg_19_1.time_ and arg_19_1.time_ < var_22_4 + var_22_12 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_4) / var_22_12

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_4 + var_22_12 and arg_19_1.time_ < var_22_4 + var_22_12 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_19_1:InitPlayNodeList()
	end,
	Play116312006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 116312006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play116312007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:AudioAction("play", "effect", "se_story_6", "se_story_6_black_fog02", "")
			end

			local var_26_1 = arg_23_1.actors_["1184ui_story"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1184ui_story = var_26_1.localPosition
			end

			local var_26_2 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_2 then
				var_26_1.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_23_1.time_ - 0) / var_26_2)
				var_26_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_1.position).x, (manager.ui.mainCamera.transform.position - var_26_1.position).y, (manager.ui.mainCamera.transform.position - var_26_1.position).z)
				var_26_1.localEulerAngles.z = 0
				var_26_1.localEulerAngles.x = 0
				var_26_1.localEulerAngles = var_26_1.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_2 and arg_23_1.time_ < 0 + var_26_2 + arg_26_0 then
				var_26_1.localPosition = Vector3.New(0, 100, 0)
				var_26_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_1.position).x, (manager.ui.mainCamera.transform.position - var_26_1.position).y, (manager.ui.mainCamera.transform.position - var_26_1.position).z)
				var_26_1.localEulerAngles.z = 0
				var_26_1.localEulerAngles.x = 0
				var_26_1.localEulerAngles = var_26_1.localEulerAngles
			end

			local var_26_3 = 0
			local var_26_4 = 1

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_3 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_5 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(116312006).content)

				arg_23_1.text_.text = var_26_5

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_7 = 40 <= 0 and var_26_4 or var_26_4 * (utf8.len(var_26_5) / 40)

				if (40 <= 0 and var_26_4 or var_26_4 * (utf8.len(var_26_5) / 40)) > 0 and var_26_4 < var_26_7 then
					arg_23_1.talkMaxDuration = var_26_7

					if var_26_7 + var_26_3 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_7 + var_26_3
					end
				end

				arg_23_1.text_.text = var_26_5
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_8 = math.max(var_26_4, arg_23_1.talkMaxDuration)

			if var_26_3 <= arg_23_1.time_ and arg_23_1.time_ < var_26_3 + var_26_8 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_3) / var_26_8

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_3 + var_26_8 and arg_23_1.time_ < var_26_3 + var_26_8 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play116312007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 116312007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play116312008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:AudioAction("play", "effect", "se_story_16", "se_story_16_metal03", "")
			end

			if 0.566666666666667 < arg_27_1.time_ and arg_27_1.time_ <= 0.566666666666667 + arg_30_0 then
				arg_27_1:AudioAction("play", "effect", "se_story_9", "se_story_9_skill02_loop", "")
			end

			local var_30_2 = 0
			local var_30_3 = 1.05

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

				local var_30_4 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(116312007).content)

				arg_27_1.text_.text = var_30_4

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_6 = 42 <= 0 and var_30_3 or var_30_3 * (utf8.len(var_30_4) / 42)

				if (42 <= 0 and var_30_3 or var_30_3 * (utf8.len(var_30_4) / 42)) > 0 and var_30_3 < var_30_6 then
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
	Play116312008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 116312008
		arg_31_1.duration_ = 1.7

		local var_31_0 = {
			zh = 1.7,
			ja = 1.033
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
				arg_31_0:Play116312009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:AudioAction("stop", "music", "se_story_9", "se_story_9_skill02_loop", "")

				local var_34_2 = manager.audio:GetAudioName("se_story_9", "se_story_9_skill02_loop")

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
			local var_34_4 = 0.125

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_3 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_5 = arg_31_1:GetWordFromCfg(116312008)
				local var_34_6 = arg_31_1:FormatText(var_34_5.content)

				arg_31_1.text_.text = var_34_6

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_8 = 5 <= 0 and var_34_4 or var_34_4 * (utf8.len(var_34_6) / 5)

				if (5 <= 0 and var_34_4 or var_34_4 * (utf8.len(var_34_6) / 5)) > 0 and var_34_4 < var_34_8 then
					arg_31_1.talkMaxDuration = var_34_8

					if var_34_8 + var_34_3 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_8 + var_34_3
					end
				end

				arg_31_1.text_.text = var_34_6
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312008", "story_v_out_116312.awb") ~= 0 then
					local var_34_9 = manager.audio:GetVoiceLength("story_v_out_116312", "116312008", "story_v_out_116312.awb") / 1000

					if var_34_9 + var_34_3 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_9 + var_34_3
					end

					if var_34_5.prefab_name ~= "" and arg_31_1.actors_[var_34_5.prefab_name] ~= nil then
						local var_34_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_5.prefab_name].transform, "story_v_out_116312", "116312008", "story_v_out_116312.awb")

						arg_31_1:RecordAudio("116312008", var_34_10)
						arg_31_1:RecordAudio("116312008", var_34_10)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_116312", "116312008", "story_v_out_116312.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_116312", "116312008", "story_v_out_116312.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_11 = math.max(var_34_4, arg_31_1.talkMaxDuration)

			if var_34_3 <= arg_31_1.time_ and arg_31_1.time_ < var_34_3 + var_34_11 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_3) / var_34_11

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_3 + var_34_11 and arg_31_1.time_ < var_34_3 + var_34_11 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play116312009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 116312009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play116312010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if arg_36_1.actors_["1032ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1032ui_story"))) then
				local var_39_0 = Object.Instantiate(Asset.Load("Char/" .. "1032ui_story"), arg_36_1.stage_.transform)

				var_39_0.name = "1032ui_story"
				var_39_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.actors_["1032ui_story"] = var_39_0

				local var_39_1 = var_39_0:GetComponentInChildren(typeof(CharacterEffect))

				var_39_1.enabled = true

				local var_39_2 = GameObjectTools.GetOrAddComponent(var_39_0, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(false)
				end

				arg_36_1:ShowWeapon(var_39_1.transform, false)

				arg_36_1.var_["1032ui_story" .. "Animator"] = var_39_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_36_1.var_["1032ui_story" .. "Animator"].applyRootMotion = true
				arg_36_1.var_["1032ui_story" .. "LipSync"] = var_39_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_39_3 = arg_36_1.actors_["1032ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1032ui_story = var_39_3.localPosition
			end

			local var_39_4 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_4 then
				var_39_3.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1032ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_4)
				var_39_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_3.position).x, (manager.ui.mainCamera.transform.position - var_39_3.position).y, (manager.ui.mainCamera.transform.position - var_39_3.position).z)
				var_39_3.localEulerAngles.z = 0
				var_39_3.localEulerAngles.x = 0
				var_39_3.localEulerAngles = var_39_3.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_4 and arg_36_1.time_ < 0 + var_39_4 + arg_39_0 then
				var_39_3.localPosition = Vector3.New(0, 100, 0)
				var_39_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_3.position).x, (manager.ui.mainCamera.transform.position - var_39_3.position).y, (manager.ui.mainCamera.transform.position - var_39_3.position).z)
				var_39_3.localEulerAngles.z = 0
				var_39_3.localEulerAngles.x = 0
				var_39_3.localEulerAngles = var_39_3.localEulerAngles
			end

			local var_39_5 = 0
			local var_39_6 = 1.1

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_7 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(116312009).content)

				arg_36_1.text_.text = var_39_7

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_9 = 44 <= 0 and var_39_6 or var_39_6 * (utf8.len(var_39_7) / 44)

				if (44 <= 0 and var_39_6 or var_39_6 * (utf8.len(var_39_7) / 44)) > 0 and var_39_6 < var_39_9 then
					arg_36_1.talkMaxDuration = var_39_9

					if var_39_9 + var_39_5 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_5
					end
				end

				arg_36_1.text_.text = var_39_7
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_10 = math.max(var_39_6, arg_36_1.talkMaxDuration)

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_10 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_5) / var_39_10

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_5 + var_39_10 and arg_36_1.time_ < var_39_5 + var_39_10 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play116312010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 116312010
		arg_40_1.duration_ = 2.97

		local var_40_0 = {
			zh = 1.999999999999,
			ja = 2.966
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
				arg_40_0:Play116312011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1032ui_story = arg_40_1.actors_["1032ui_story"].transform.localPosition
			end

			local var_43_0 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 then
				arg_40_1.actors_["1032ui_story"].transform.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1032ui_story, Vector3.New(0, -1.05, -6.2), (arg_40_1.time_ - 0) / var_43_0)
				arg_40_1.actors_["1032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["1032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1032ui_story"].transform.position).z)
				arg_40_1.actors_["1032ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["1032ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["1032ui_story"].transform.localEulerAngles = arg_40_1.actors_["1032ui_story"].transform.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 then
				arg_40_1.actors_["1032ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_40_1.actors_["1032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["1032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1032ui_story"].transform.position).z)
				arg_40_1.actors_["1032ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["1032ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["1032ui_story"].transform.localEulerAngles = arg_40_1.actors_["1032ui_story"].transform.localEulerAngles
			end

			local var_43_1 = arg_40_1.actors_["1032ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_1) and arg_40_1.var_.characterEffect1032ui_story == nil then
				arg_40_1.var_.characterEffect1032ui_story = var_43_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_2 and not isNil(var_43_1) then
				if arg_40_1.var_.characterEffect1032ui_story and not isNil(var_43_1) then
					arg_40_1.var_.characterEffect1032ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_2 and arg_40_1.time_ < 0 + var_43_2 + arg_43_0 and not isNil(var_43_1) and arg_40_1.var_.characterEffect1032ui_story then
				arg_40_1.var_.characterEffect1032ui_story.fillFlat = false
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032action/1032action2_1")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_43_4 = 0
			local var_43_5 = 0.125

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_6 = arg_40_1:GetWordFromCfg(116312010)
				local var_43_7 = arg_40_1:FormatText(var_43_6.content)

				arg_40_1.text_.text = var_43_7

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 5 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 5)

				if (5 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 5)) > 0 and var_43_5 < var_43_9 then
					arg_40_1.talkMaxDuration = var_43_9

					if var_43_9 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_7
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312010", "story_v_out_116312.awb") ~= 0 then
					local var_43_10 = manager.audio:GetVoiceLength("story_v_out_116312", "116312010", "story_v_out_116312.awb") / 1000

					if var_43_10 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_4
					end

					if var_43_6.prefab_name ~= "" and arg_40_1.actors_[var_43_6.prefab_name] ~= nil then
						local var_43_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_6.prefab_name].transform, "story_v_out_116312", "116312010", "story_v_out_116312.awb")

						arg_40_1:RecordAudio("116312010", var_43_11)
						arg_40_1:RecordAudio("116312010", var_43_11)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_116312", "116312010", "story_v_out_116312.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_116312", "116312010", "story_v_out_116312.awb")
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
				actorName = "1032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play116312011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 116312011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play116312012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1032ui_story = arg_44_1.actors_["1032ui_story"].transform.localPosition
			end

			local var_47_0 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 then
				arg_44_1.actors_["1032ui_story"].transform.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1032ui_story, Vector3.New(0, 100, 0), (arg_44_1.time_ - 0) / var_47_0)
				arg_44_1.actors_["1032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1032ui_story"].transform.position).z)
				arg_44_1.actors_["1032ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1032ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1032ui_story"].transform.localEulerAngles = arg_44_1.actors_["1032ui_story"].transform.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 then
				arg_44_1.actors_["1032ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.actors_["1032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1032ui_story"].transform.position).z)
				arg_44_1.actors_["1032ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1032ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1032ui_story"].transform.localEulerAngles = arg_44_1.actors_["1032ui_story"].transform.localEulerAngles
			end

			local var_47_1 = 0
			local var_47_2 = 0.975

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_3 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(116312011).content)

				arg_44_1.text_.text = var_47_3

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 39 <= 0 and var_47_2 or var_47_2 * (utf8.len(var_47_3) / 39)

				if (39 <= 0 and var_47_2 or var_47_2 * (utf8.len(var_47_3) / 39)) > 0 and var_47_2 < var_47_5 then
					arg_44_1.talkMaxDuration = var_47_5

					if var_47_5 + var_47_1 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + var_47_1
					end
				end

				arg_44_1.text_.text = var_47_3
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_6 = math.max(var_47_2, arg_44_1.talkMaxDuration)

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_6 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_1) / var_47_6

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_1 + var_47_6 and arg_44_1.time_ < var_47_1 + var_47_6 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play116312012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 116312012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play116312013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 1.075

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_1 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(116312012).content)

				arg_48_1.text_.text = var_51_1

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_3 = 43 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 43)

				if (43 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 43)) > 0 and var_51_0 < var_51_3 then
					arg_48_1.talkMaxDuration = var_51_3

					if var_51_3 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_3 + 0
					end
				end

				arg_48_1.text_.text = var_51_1
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_4 = math.max(var_51_0, arg_48_1.talkMaxDuration)

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - 0) / var_51_4

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play116312013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 116312013
		arg_52_1.duration_ = 2.83

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play116312014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if arg_52_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_55_0 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_52_1.stage_.transform)

				var_55_0.name = "1037ui_story"
				var_55_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.actors_["1037ui_story"] = var_55_0

				local var_55_1 = var_55_0:GetComponentInChildren(typeof(CharacterEffect))

				var_55_1.enabled = true

				local var_55_2 = GameObjectTools.GetOrAddComponent(var_55_0, typeof(DynamicBoneHelper))

				if var_55_2 then
					var_55_2:EnableDynamicBone(false)
				end

				arg_52_1:ShowWeapon(var_55_1.transform, false)

				arg_52_1.var_["1037ui_story" .. "Animator"] = var_55_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_52_1.var_["1037ui_story" .. "Animator"].applyRootMotion = true
				arg_52_1.var_["1037ui_story" .. "LipSync"] = var_55_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_55_3 = arg_52_1.actors_["1037ui_story"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1037ui_story = var_55_3.localPosition
			end

			local var_55_4 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 then
				var_55_3.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1037ui_story, Vector3.New(0.7, -1.09, -5.81), (arg_52_1.time_ - 0) / var_55_4)
				var_55_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_3.position).x, (manager.ui.mainCamera.transform.position - var_55_3.position).y, (manager.ui.mainCamera.transform.position - var_55_3.position).z)
				var_55_3.localEulerAngles.z = 0
				var_55_3.localEulerAngles.x = 0
				var_55_3.localEulerAngles = var_55_3.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 then
				var_55_3.localPosition = Vector3.New(0.7, -1.09, -5.81)
				var_55_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_3.position).x, (manager.ui.mainCamera.transform.position - var_55_3.position).y, (manager.ui.mainCamera.transform.position - var_55_3.position).z)
				var_55_3.localEulerAngles.z = 0
				var_55_3.localEulerAngles.x = 0
				var_55_3.localEulerAngles = var_55_3.localEulerAngles
			end

			local var_55_5 = arg_52_1.actors_["1032ui_story"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1032ui_story = var_55_5.localPosition
			end

			local var_55_6 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_6 then
				var_55_5.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1032ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_52_1.time_ - 0) / var_55_6)
				var_55_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_5.position).x, (manager.ui.mainCamera.transform.position - var_55_5.position).y, (manager.ui.mainCamera.transform.position - var_55_5.position).z)
				var_55_5.localEulerAngles.z = 0
				var_55_5.localEulerAngles.x = 0
				var_55_5.localEulerAngles = var_55_5.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_6 and arg_52_1.time_ < 0 + var_55_6 + arg_55_0 then
				var_55_5.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				var_55_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_5.position).x, (manager.ui.mainCamera.transform.position - var_55_5.position).y, (manager.ui.mainCamera.transform.position - var_55_5.position).z)
				var_55_5.localEulerAngles.z = 0
				var_55_5.localEulerAngles.x = 0
				var_55_5.localEulerAngles = var_55_5.localEulerAngles
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action6_1")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_55_7 = 0
			local var_55_8 = 0.05

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_7 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[336].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_9 = arg_52_1:GetWordFromCfg(116312013)
				local var_55_10 = arg_52_1:FormatText(var_55_9.content)

				arg_52_1.text_.text = var_55_10

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_12 = 2 <= 0 and var_55_8 or var_55_8 * (utf8.len(var_55_10) / 2)

				if (2 <= 0 and var_55_8 or var_55_8 * (utf8.len(var_55_10) / 2)) > 0 and var_55_8 < var_55_12 then
					arg_52_1.talkMaxDuration = var_55_12

					if var_55_12 + var_55_7 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_12 + var_55_7
					end
				end

				arg_52_1.text_.text = var_55_10
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312013", "story_v_out_116312.awb") ~= 0 then
					local var_55_13 = manager.audio:GetVoiceLength("story_v_out_116312", "116312013", "story_v_out_116312.awb") / 1000

					if var_55_13 + var_55_7 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_13 + var_55_7
					end

					if var_55_9.prefab_name ~= "" and arg_52_1.actors_[var_55_9.prefab_name] ~= nil then
						local var_55_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_9.prefab_name].transform, "story_v_out_116312", "116312013", "story_v_out_116312.awb")

						arg_52_1:RecordAudio("116312013", var_55_14)
						arg_52_1:RecordAudio("116312013", var_55_14)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_116312", "116312013", "story_v_out_116312.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_116312", "116312013", "story_v_out_116312.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_15 = math.max(var_55_8, arg_52_1.talkMaxDuration)

			if var_55_7 <= arg_52_1.time_ and arg_52_1.time_ < var_55_7 + var_55_15 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_7) / var_55_15

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_7 + var_55_15 and arg_52_1.time_ < var_55_7 + var_55_15 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play116312014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 116312014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play116312015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1037ui_story = arg_56_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_59_0 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 then
				arg_56_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_0)
				arg_56_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1037ui_story"].transform.position).z)
				arg_56_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["1037ui_story"].transform.localEulerAngles = arg_56_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 then
				arg_56_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_56_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1037ui_story"].transform.position).z)
				arg_56_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["1037ui_story"].transform.localEulerAngles = arg_56_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_59_1 = arg_56_1.actors_["1032ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1032ui_story = var_59_1.localPosition
			end

			local var_59_2 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_2 then
				var_59_1.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1032ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_2)
				var_59_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_1.position).x, (manager.ui.mainCamera.transform.position - var_59_1.position).y, (manager.ui.mainCamera.transform.position - var_59_1.position).z)
				var_59_1.localEulerAngles.z = 0
				var_59_1.localEulerAngles.x = 0
				var_59_1.localEulerAngles = var_59_1.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_2 and arg_56_1.time_ < 0 + var_59_2 + arg_59_0 then
				var_59_1.localPosition = Vector3.New(0, 100, 0)
				var_59_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_1.position).x, (manager.ui.mainCamera.transform.position - var_59_1.position).y, (manager.ui.mainCamera.transform.position - var_59_1.position).z)
				var_59_1.localEulerAngles.z = 0
				var_59_1.localEulerAngles.x = 0
				var_59_1.localEulerAngles = var_59_1.localEulerAngles
			end

			local var_59_3 = 0
			local var_59_4 = 0.1

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_3 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_5 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(116312014).content)

				arg_56_1.text_.text = var_59_5

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_7 = 4 <= 0 and var_59_4 or var_59_4 * (utf8.len(var_59_5) / 4)

				if (4 <= 0 and var_59_4 or var_59_4 * (utf8.len(var_59_5) / 4)) > 0 and var_59_4 < var_59_7 then
					arg_56_1.talkMaxDuration = var_59_7

					if var_59_7 + var_59_3 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_3
					end
				end

				arg_56_1.text_.text = var_59_5
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_8 = math.max(var_59_4, arg_56_1.talkMaxDuration)

			if var_59_3 <= arg_56_1.time_ and arg_56_1.time_ < var_59_3 + var_59_8 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_3) / var_59_8

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_3 + var_59_8 and arg_56_1.time_ < var_59_3 + var_59_8 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play116312015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 116312015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play116312016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0.7

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_1 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(116312015).content)

				arg_60_1.text_.text = var_63_1

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_3 = 28 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 28)

				if (28 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 28)) > 0 and var_63_0 < var_63_3 then
					arg_60_1.talkMaxDuration = var_63_3

					if var_63_3 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_3 + 0
					end
				end

				arg_60_1.text_.text = var_63_1
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_4 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_4

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play116312016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 116312016
		arg_64_1.duration_ = 7.77

		local var_64_0 = {
			zh = 7.766,
			ja = 6.333
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
				arg_64_0:Play116312017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0.775

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4031")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_1 = arg_64_1:GetWordFromCfg(116312016)
				local var_67_2 = arg_64_1:FormatText(var_67_1.content)

				arg_64_1.text_.text = var_67_2

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_4 = 31 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 31)

				if (31 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 31)) > 0 and var_67_0 < var_67_4 then
					arg_64_1.talkMaxDuration = var_67_4

					if var_67_4 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_4 + 0
					end
				end

				arg_64_1.text_.text = var_67_2
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312016", "story_v_out_116312.awb") ~= 0 then
					local var_67_5 = manager.audio:GetVoiceLength("story_v_out_116312", "116312016", "story_v_out_116312.awb") / 1000

					if var_67_5 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + 0
					end

					if var_67_1.prefab_name ~= "" and arg_64_1.actors_[var_67_1.prefab_name] ~= nil then
						local var_67_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_1.prefab_name].transform, "story_v_out_116312", "116312016", "story_v_out_116312.awb")

						arg_64_1:RecordAudio("116312016", var_67_6)
						arg_64_1:RecordAudio("116312016", var_67_6)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_116312", "116312016", "story_v_out_116312.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_116312", "116312016", "story_v_out_116312.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_7 = math.max(var_67_0, arg_64_1.talkMaxDuration)

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_7 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - 0) / var_67_7

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= 0 + var_67_7 and arg_64_1.time_ < 0 + var_67_7 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play116312017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 116312017
		arg_68_1.duration_ = 1.73

		local var_68_0 = {
			zh = 1.4,
			ja = 1.733
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
				arg_68_0:Play116312018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0.125

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4031")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_1 = arg_68_1:GetWordFromCfg(116312017)
				local var_71_2 = arg_68_1:FormatText(var_71_1.content)

				arg_68_1.text_.text = var_71_2

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 5 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 5)

				if (5 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 5)) > 0 and var_71_0 < var_71_4 then
					arg_68_1.talkMaxDuration = var_71_4

					if var_71_4 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_4 + 0
					end
				end

				arg_68_1.text_.text = var_71_2
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312017", "story_v_out_116312.awb") ~= 0 then
					local var_71_5 = manager.audio:GetVoiceLength("story_v_out_116312", "116312017", "story_v_out_116312.awb") / 1000

					if var_71_5 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + 0
					end

					if var_71_1.prefab_name ~= "" and arg_68_1.actors_[var_71_1.prefab_name] ~= nil then
						local var_71_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_1.prefab_name].transform, "story_v_out_116312", "116312017", "story_v_out_116312.awb")

						arg_68_1:RecordAudio("116312017", var_71_6)
						arg_68_1:RecordAudio("116312017", var_71_6)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_116312", "116312017", "story_v_out_116312.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_116312", "116312017", "story_v_out_116312.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_7 = math.max(var_71_0, arg_68_1.talkMaxDuration)

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_7 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - 0) / var_71_7

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= 0 + var_71_7 and arg_68_1.time_ < 0 + var_71_7 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play116312018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 116312018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play116312019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.875

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_1 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(116312018).content)

				arg_72_1.text_.text = var_75_1

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_3 = 35 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 35)

				if (35 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 35)) > 0 and var_75_0 < var_75_3 then
					arg_72_1.talkMaxDuration = var_75_3

					if var_75_3 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_3 + 0
					end
				end

				arg_72_1.text_.text = var_75_1
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_4 = math.max(var_75_0, arg_72_1.talkMaxDuration)

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - 0) / var_75_4

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play116312019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 116312019
		arg_76_1.duration_ = 2.3

		local var_76_0 = {
			zh = 2.3,
			ja = 1.999999999999
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
				arg_76_0:Play116312020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1184ui_story = arg_76_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_79_0 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 then
				arg_76_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_76_1.time_ - 0) / var_79_0)
				arg_76_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1184ui_story"].transform.position).z)
				arg_76_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1184ui_story"].transform.localEulerAngles = arg_76_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 then
				arg_76_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_76_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1184ui_story"].transform.position).z)
				arg_76_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1184ui_story"].transform.localEulerAngles = arg_76_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_79_1 = arg_76_1.actors_["1184ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_1) and arg_76_1.var_.characterEffect1184ui_story == nil then
				arg_76_1.var_.characterEffect1184ui_story = var_79_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.2

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_2 and not isNil(var_79_1) then
				if arg_76_1.var_.characterEffect1184ui_story and not isNil(var_79_1) then
					arg_76_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_2 and arg_76_1.time_ < 0 + var_79_2 + arg_79_0 and not isNil(var_79_1) and arg_76_1.var_.characterEffect1184ui_story then
				arg_76_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_79_4 = 0
			local var_79_5 = 0.2

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_6 = arg_76_1:GetWordFromCfg(116312019)
				local var_79_7 = arg_76_1:FormatText(var_79_6.content)

				arg_76_1.text_.text = var_79_7

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_9 = 8 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 8)

				if (8 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 8)) > 0 and var_79_5 < var_79_9 then
					arg_76_1.talkMaxDuration = var_79_9

					if var_79_9 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_9 + var_79_4
					end
				end

				arg_76_1.text_.text = var_79_7
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312019", "story_v_out_116312.awb") ~= 0 then
					local var_79_10 = manager.audio:GetVoiceLength("story_v_out_116312", "116312019", "story_v_out_116312.awb") / 1000

					if var_79_10 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_10 + var_79_4
					end

					if var_79_6.prefab_name ~= "" and arg_76_1.actors_[var_79_6.prefab_name] ~= nil then
						local var_79_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_6.prefab_name].transform, "story_v_out_116312", "116312019", "story_v_out_116312.awb")

						arg_76_1:RecordAudio("116312019", var_79_11)
						arg_76_1:RecordAudio("116312019", var_79_11)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_116312", "116312019", "story_v_out_116312.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_116312", "116312019", "story_v_out_116312.awb")
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

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play116312020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 116312020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play116312021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1184ui_story = arg_80_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_83_0 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 then
				arg_80_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_0)
				arg_80_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1184ui_story"].transform.position).z)
				arg_80_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1184ui_story"].transform.localEulerAngles = arg_80_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 then
				arg_80_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_80_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1184ui_story"].transform.position).z)
				arg_80_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1184ui_story"].transform.localEulerAngles = arg_80_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_83_1 = 0
			local var_83_2 = 0.7

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_3 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(116312020).content)

				arg_80_1.text_.text = var_83_3

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 28 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 28)

				if (28 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 28)) > 0 and var_83_2 < var_83_5 then
					arg_80_1.talkMaxDuration = var_83_5

					if var_83_5 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + var_83_1
					end
				end

				arg_80_1.text_.text = var_83_3
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_6 = math.max(var_83_2, arg_80_1.talkMaxDuration)

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_6 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_1) / var_83_6

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_1 + var_83_6 and arg_80_1.time_ < var_83_1 + var_83_6 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play116312021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 116312021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play116312022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.575

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_1 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(116312021).content)

				arg_84_1.text_.text = var_87_1

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_3 = 23 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 23)

				if (23 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 23)) > 0 and var_87_0 < var_87_3 then
					arg_84_1.talkMaxDuration = var_87_3

					if var_87_3 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_3 + 0
					end
				end

				arg_84_1.text_.text = var_87_1
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_4 = math.max(var_87_0, arg_84_1.talkMaxDuration)

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - 0) / var_87_4

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play116312022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 116312022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play116312023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0.65

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_1 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(116312022).content)

				arg_88_1.text_.text = var_91_1

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_3 = 26 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 26)

				if (26 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 26)) > 0 and var_91_0 < var_91_3 then
					arg_88_1.talkMaxDuration = var_91_3

					if var_91_3 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_3 + 0
					end
				end

				arg_88_1.text_.text = var_91_1
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_4 = math.max(var_91_0, arg_88_1.talkMaxDuration)

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - 0) / var_91_4

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play116312023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 116312023
		arg_92_1.duration_ = 5.5

		local var_92_0 = {
			zh = 4.566,
			ja = 5.5
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
				arg_92_0:Play116312024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0.375

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4031")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_1 = arg_92_1:GetWordFromCfg(116312023)
				local var_95_2 = arg_92_1:FormatText(var_95_1.content)

				arg_92_1.text_.text = var_95_2

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_4 = 15 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 15)

				if (15 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 15)) > 0 and var_95_0 < var_95_4 then
					arg_92_1.talkMaxDuration = var_95_4

					if var_95_4 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_4 + 0
					end
				end

				arg_92_1.text_.text = var_95_2
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312023", "story_v_out_116312.awb") ~= 0 then
					local var_95_5 = manager.audio:GetVoiceLength("story_v_out_116312", "116312023", "story_v_out_116312.awb") / 1000

					if var_95_5 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + 0
					end

					if var_95_1.prefab_name ~= "" and arg_92_1.actors_[var_95_1.prefab_name] ~= nil then
						local var_95_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_1.prefab_name].transform, "story_v_out_116312", "116312023", "story_v_out_116312.awb")

						arg_92_1:RecordAudio("116312023", var_95_6)
						arg_92_1:RecordAudio("116312023", var_95_6)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_116312", "116312023", "story_v_out_116312.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_116312", "116312023", "story_v_out_116312.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_7 = math.max(var_95_0, arg_92_1.talkMaxDuration)

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_7 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - 0) / var_95_7

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= 0 + var_95_7 and arg_92_1.time_ < 0 + var_95_7 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play116312024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 116312024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play116312025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0.85

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_1 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(116312024).content)

				arg_96_1.text_.text = var_99_1

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_3 = 34 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_1) / 34)

				if (34 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_1) / 34)) > 0 and var_99_0 < var_99_3 then
					arg_96_1.talkMaxDuration = var_99_3

					if var_99_3 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_3 + 0
					end
				end

				arg_96_1.text_.text = var_99_1
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_4 = math.max(var_99_0, arg_96_1.talkMaxDuration)

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_4 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - 0) / var_99_4

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= 0 + var_99_4 and arg_96_1.time_ < 0 + var_99_4 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play116312025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 116312025
		arg_100_1.duration_ = 9.07

		local var_100_0 = {
			zh = 7.3,
			ja = 9.066
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play116312026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0.625

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4031")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_1 = arg_100_1:GetWordFromCfg(116312025)
				local var_103_2 = arg_100_1:FormatText(var_103_1.content)

				arg_100_1.text_.text = var_103_2

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_4 = 25 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_2) / 25)

				if (25 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_2) / 25)) > 0 and var_103_0 < var_103_4 then
					arg_100_1.talkMaxDuration = var_103_4

					if var_103_4 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_4 + 0
					end
				end

				arg_100_1.text_.text = var_103_2
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312025", "story_v_out_116312.awb") ~= 0 then
					local var_103_5 = manager.audio:GetVoiceLength("story_v_out_116312", "116312025", "story_v_out_116312.awb") / 1000

					if var_103_5 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + 0
					end

					if var_103_1.prefab_name ~= "" and arg_100_1.actors_[var_103_1.prefab_name] ~= nil then
						local var_103_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_1.prefab_name].transform, "story_v_out_116312", "116312025", "story_v_out_116312.awb")

						arg_100_1:RecordAudio("116312025", var_103_6)
						arg_100_1:RecordAudio("116312025", var_103_6)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_116312", "116312025", "story_v_out_116312.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_116312", "116312025", "story_v_out_116312.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_7 = math.max(var_103_0, arg_100_1.talkMaxDuration)

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_7 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - 0) / var_103_7

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= 0 + var_103_7 and arg_100_1.time_ < 0 + var_103_7 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play116312026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 116312026
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play116312027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0.325

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_1 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(116312026).content)

				arg_104_1.text_.text = var_107_1

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_3 = 13 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 13)

				if (13 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 13)) > 0 and var_107_0 < var_107_3 then
					arg_104_1.talkMaxDuration = var_107_3

					if var_107_3 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_3 + 0
					end
				end

				arg_104_1.text_.text = var_107_1
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_4 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_4

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play116312027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 116312027
		arg_108_1.duration_ = 5.15

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play116312028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if arg_108_1.bgs_.STblack == nil then
				local var_111_0 = Object.Instantiate(arg_108_1.paintGo_)

				var_111_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_111_0.name = "STblack"
				var_111_0.transform.parent = arg_108_1.stage_.transform
				var_111_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_108_1.bgs_.STblack = var_111_0
			end

			if 1 < arg_108_1.time_ and arg_108_1.time_ <= 1 + arg_111_0 then
				local var_111_1 = arg_108_1.bgs_.STblack

				arg_108_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_111_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_111_2 = var_111_1:GetComponent("SpriteRenderer")

				if var_111_2 and var_111_2.sprite then
					local var_111_3 = 2 * (var_111_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_111_1.transform.localScale = Vector3.New(var_111_3 / var_111_2.sprite.bounds.size.y < var_111_3 * manager.ui.mainCameraCom_.aspect / var_111_2.sprite.bounds.size.x and var_111_3 * manager.ui.mainCameraCom_.aspect / var_111_2.sprite.bounds.size.x or var_111_3 / var_111_2.sprite.bounds.size.y, var_111_3 / var_111_2.sprite.bounds.size.y < var_111_3 * manager.ui.mainCameraCom_.aspect / var_111_2.sprite.bounds.size.x and var_111_3 * manager.ui.mainCameraCom_.aspect / var_111_2.sprite.bounds.size.x or var_111_3 / var_111_2.sprite.bounds.size.y, 0)
				end

				for iter_111_0, iter_111_1 in pairs(arg_108_1.bgs_) do
					if iter_111_0 ~= "STblack" then
						iter_111_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_111_4 = 0

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_4 + arg_111_0 then
				arg_108_1.mask_.enabled = true
				arg_108_1.mask_.raycastTarget = false

				arg_108_1:SetGaussion(false)
			end

			local var_111_5 = 1

			if var_111_4 <= arg_108_1.time_ and arg_108_1.time_ < var_111_4 + var_111_5 then
				local var_111_6 = Color.New(0, 0, 0)

				var_111_6.a = Mathf.Lerp(0, 1, (arg_108_1.time_ - var_111_4) / var_111_5)
				arg_108_1.mask_.color = var_111_6
			end

			if arg_108_1.time_ >= var_111_4 + var_111_5 and arg_108_1.time_ < var_111_4 + var_111_5 + arg_111_0 then
				local var_111_7 = Color.New(0, 0, 0)

				var_111_7.a = 1
				arg_108_1.mask_.color = var_111_7
			end

			local var_111_8 = 1

			if 1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_8 + arg_111_0 then
				arg_108_1.mask_.enabled = true
				arg_108_1.mask_.raycastTarget = false

				arg_108_1:SetGaussion(false)
			end

			local var_111_9 = 2

			if var_111_8 <= arg_108_1.time_ and arg_108_1.time_ < var_111_8 + var_111_9 then
				local var_111_10 = Color.New(0, 0, 0)

				var_111_10.a = Mathf.Lerp(1, 0, (arg_108_1.time_ - var_111_8) / var_111_9)
				arg_108_1.mask_.color = var_111_10
			end

			if arg_108_1.time_ >= var_111_8 + var_111_9 and arg_108_1.time_ < var_111_8 + var_111_9 + arg_111_0 then
				local var_111_11 = Color.New(0, 0, 0)

				arg_108_1.mask_.enabled = false
				var_111_11.a = 0
				arg_108_1.mask_.color = var_111_11
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:AudioAction("play", "effect", "se_story_6", "se_story_6_black_fog02", "")
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.fswbg_:SetActive(true)
				arg_108_1.dialog_:SetActive(false)

				arg_108_1.fswtw_.percent = 0
				arg_108_1.fswt_.text = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(116312027).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.fswt_)

				arg_108_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_108_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_108_1.fswtw_:SetDirty()

				arg_108_1.typewritterCharCountI18N = 0

				SetActive(arg_108_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_108_1:ShowNextGo(false)
			end

			local var_111_13 = 3

			if 3 < arg_108_1.time_ and arg_108_1.time_ <= var_111_13 + arg_111_0 then
				arg_108_1.var_.oldValueTypewriter = arg_108_1.fswtw_.percent

				SetActive(arg_108_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_108_1:ShowNextGo(false)
			end

			local var_111_14 = 32
			local var_111_15 = 2.13333333333333
			local var_111_16, var_111_17 = arg_108_1:GetPercentByPara(arg_108_1:FormatText(arg_108_1:GetWordFromCfg(116312027).content), 1)

			if var_111_13 < arg_108_1.time_ and arg_108_1.time_ <= var_111_13 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0

				local var_111_18 = var_111_14 <= 0 and var_111_15 or var_111_15 * ((var_111_17 - arg_108_1.typewritterCharCountI18N) / var_111_14)

				if (var_111_14 <= 0 and var_111_15 or var_111_15 * ((var_111_17 - arg_108_1.typewritterCharCountI18N) / var_111_14)) > 0 and var_111_15 < var_111_18 then
					arg_108_1.talkMaxDuration = var_111_18

					if var_111_18 + var_111_13 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_18 + var_111_13
					end
				end
			end

			local var_111_19 = math.max(2.13333333333333, arg_108_1.talkMaxDuration)

			if var_111_13 <= arg_108_1.time_ and arg_108_1.time_ < var_111_13 + var_111_19 then
				arg_108_1.fswtw_.percent = Mathf.Lerp(arg_108_1.var_.oldValueTypewriter, var_111_16, (arg_108_1.time_ - var_111_13) / var_111_19)
				arg_108_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_108_1.fswtw_:SetDirty()
			end

			if arg_108_1.time_ >= var_111_13 + var_111_19 and arg_108_1.time_ < var_111_13 + var_111_19 + arg_111_0 then
				arg_108_1.fswtw_.percent = var_111_16

				arg_108_1.fswtw_:SetDirty()
				arg_108_1:ShowNextGo(true)

				arg_108_1.typewritterCharCountI18N = var_111_17
			end

			local var_111_20 = 0

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_20 + arg_111_0 then
				arg_108_1.allBtn_.enabled = false
			end

			if arg_108_1.time_ >= var_111_20 + 5.15 and arg_108_1.time_ < var_111_20 + 5.15 + arg_111_0 then
				arg_108_1.allBtn_.enabled = true
			end

			if 3.01666666666667 < arg_108_1.time_ and arg_108_1.time_ <= 3.01666666666667 + arg_111_0 then
				local var_111_21 = arg_108_1.fswbg_.transform:Find("textbox/adapt/content") or arg_108_1.fswbg_.transform:Find("textbox/content")
				local var_111_22 = arg_108_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_111_23 = var_111_21:GetComponent("RectTransform")

				var_111_21:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_111_23.offsetMin = Vector2.New(0, 0)
				var_111_23.offsetMax = Vector2.New(0, 0)
			end

			local var_111_24 = 3.01666666666667

			if 3.01666666666667 < arg_108_1.time_ and arg_108_1.time_ <= var_111_24 + arg_111_0 then
				arg_108_1.allBtn_.enabled = false
			end

			if arg_108_1.time_ >= var_111_24 + 2.13333333333333 and arg_108_1.time_ < var_111_24 + 2.13333333333333 + arg_111_0 then
				arg_108_1.allBtn_.enabled = true
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play116312028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 116312028
		arg_112_1.duration_ = 2.75

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play116312029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.fswbg_:SetActive(true)
				arg_112_1.dialog_:SetActive(false)

				arg_112_1.fswtw_.percent = 0
				arg_112_1.fswt_.text = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(116312028).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.fswt_)

				arg_112_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_112_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_112_1.fswtw_:SetDirty()

				arg_112_1.typewritterCharCountI18N = 0

				SetActive(arg_112_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_112_1:ShowNextGo(false)
			end

			local var_115_0 = 0.0166666666666666

			if 0.0166666666666666 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.var_.oldValueTypewriter = arg_112_1.fswtw_.percent

				SetActive(arg_112_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_112_1:ShowNextGo(false)
			end

			local var_115_1 = 41
			local var_115_2 = 2.73333333333333
			local var_115_3, var_115_4 = arg_112_1:GetPercentByPara(arg_112_1:FormatText(arg_112_1:GetWordFromCfg(116312028).content), 1)

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0

				local var_115_5 = var_115_1 <= 0 and var_115_2 or var_115_2 * ((var_115_4 - arg_112_1.typewritterCharCountI18N) / var_115_1)

				if (var_115_1 <= 0 and var_115_2 or var_115_2 * ((var_115_4 - arg_112_1.typewritterCharCountI18N) / var_115_1)) > 0 and var_115_2 < var_115_5 then
					arg_112_1.talkMaxDuration = var_115_5

					if var_115_5 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_5 + var_115_0
					end
				end
			end

			local var_115_6 = math.max(2.73333333333333, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_6 then
				arg_112_1.fswtw_.percent = Mathf.Lerp(arg_112_1.var_.oldValueTypewriter, var_115_3, (arg_112_1.time_ - var_115_0) / var_115_6)
				arg_112_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_112_1.fswtw_:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_6 and arg_112_1.time_ < var_115_0 + var_115_6 + arg_115_0 then
				arg_112_1.fswtw_.percent = var_115_3

				arg_112_1.fswtw_:SetDirty()
				arg_112_1:ShowNextGo(true)

				arg_112_1.typewritterCharCountI18N = var_115_4
			end

			local var_115_7 = 0

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_7 + arg_115_0 then
				arg_112_1.allBtn_.enabled = false
			end

			if arg_112_1.time_ >= var_115_7 + 2.75 and arg_112_1.time_ < var_115_7 + 2.75 + arg_115_0 then
				arg_112_1.allBtn_.enabled = true
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				local var_115_8 = arg_112_1.fswbg_.transform:Find("textbox/adapt/content") or arg_112_1.fswbg_.transform:Find("textbox/content")
				local var_115_9 = arg_112_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_115_10 = var_115_8:GetComponent("RectTransform")

				var_115_8:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_115_10.offsetMin = Vector2.New(0, 0)
				var_115_10.offsetMax = Vector2.New(0, 0)
			end

			local var_115_11 = 0

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_11 + arg_115_0 then
				arg_112_1.allBtn_.enabled = false
			end

			if arg_112_1.time_ >= var_115_11 + 2.75 and arg_112_1.time_ < var_115_11 + 2.75 + arg_115_0 then
				arg_112_1.allBtn_.enabled = true
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play116312029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 116312029
		arg_116_1.duration_ = 3.15

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play116312030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.fswbg_:SetActive(true)
				arg_116_1.dialog_:SetActive(false)

				arg_116_1.fswtw_.percent = 0
				arg_116_1.fswt_.text = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(116312029).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.fswt_)

				arg_116_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_116_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_116_1.fswtw_:SetDirty()

				arg_116_1.typewritterCharCountI18N = 0

				SetActive(arg_116_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_116_1:ShowNextGo(false)
			end

			local var_119_0 = 0.0166666666666666

			if 0.0166666666666666 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.var_.oldValueTypewriter = arg_116_1.fswtw_.percent

				SetActive(arg_116_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_116_1:ShowNextGo(false)
			end

			local var_119_1 = 47
			local var_119_2 = 3.13333333333333
			local var_119_3, var_119_4 = arg_116_1:GetPercentByPara(arg_116_1:FormatText(arg_116_1:GetWordFromCfg(116312029).content), 1)

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0

				local var_119_5 = var_119_1 <= 0 and var_119_2 or var_119_2 * ((var_119_4 - arg_116_1.typewritterCharCountI18N) / var_119_1)

				if (var_119_1 <= 0 and var_119_2 or var_119_2 * ((var_119_4 - arg_116_1.typewritterCharCountI18N) / var_119_1)) > 0 and var_119_2 < var_119_5 then
					arg_116_1.talkMaxDuration = var_119_5

					if var_119_5 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + var_119_0
					end
				end
			end

			local var_119_6 = math.max(3.13333333333333, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_6 then
				arg_116_1.fswtw_.percent = Mathf.Lerp(arg_116_1.var_.oldValueTypewriter, var_119_3, (arg_116_1.time_ - var_119_0) / var_119_6)
				arg_116_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_116_1.fswtw_:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_6 and arg_116_1.time_ < var_119_0 + var_119_6 + arg_119_0 then
				arg_116_1.fswtw_.percent = var_119_3

				arg_116_1.fswtw_:SetDirty()
				arg_116_1:ShowNextGo(true)

				arg_116_1.typewritterCharCountI18N = var_119_4
			end

			local var_119_7 = 0

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_7 + arg_119_0 then
				arg_116_1.allBtn_.enabled = false
			end

			if arg_116_1.time_ >= var_119_7 + 3.15 and arg_116_1.time_ < var_119_7 + 3.15 + arg_119_0 then
				arg_116_1.allBtn_.enabled = true
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				local var_119_8 = arg_116_1.fswbg_.transform:Find("textbox/adapt/content") or arg_116_1.fswbg_.transform:Find("textbox/content")
				local var_119_9 = arg_116_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_119_10 = var_119_8:GetComponent("RectTransform")

				var_119_8:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_119_10.offsetMin = Vector2.New(0, 0)
				var_119_10.offsetMax = Vector2.New(0, 0)
			end

			local var_119_11 = 0

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_11 + arg_119_0 then
				arg_116_1.allBtn_.enabled = false
			end

			if arg_116_1.time_ >= var_119_11 + 3.15 and arg_116_1.time_ < var_119_11 + 3.15 + arg_119_0 then
				arg_116_1.allBtn_.enabled = true
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play116312030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 116312030
		arg_120_1.duration_ = 2.02

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play116312031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.fswbg_:SetActive(true)
				arg_120_1.dialog_:SetActive(false)

				arg_120_1.fswtw_.percent = 0
				arg_120_1.fswt_.text = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(116312030).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.fswt_)

				arg_120_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_120_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_120_1.fswtw_:SetDirty()

				arg_120_1.typewritterCharCountI18N = 0

				SetActive(arg_120_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_120_1:ShowNextGo(false)
			end

			local var_123_0 = 0.0166666666666666

			if 0.0166666666666666 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.var_.oldValueTypewriter = arg_120_1.fswtw_.percent

				SetActive(arg_120_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_120_1:ShowNextGo(false)
			end

			local var_123_1 = 30
			local var_123_2 = 2
			local var_123_3, var_123_4 = arg_120_1:GetPercentByPara(arg_120_1:FormatText(arg_120_1:GetWordFromCfg(116312030).content), 1)

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0

				local var_123_5 = var_123_1 <= 0 and var_123_2 or var_123_2 * ((var_123_4 - arg_120_1.typewritterCharCountI18N) / var_123_1)

				if (var_123_1 <= 0 and var_123_2 or var_123_2 * ((var_123_4 - arg_120_1.typewritterCharCountI18N) / var_123_1)) > 0 and var_123_2 < var_123_5 then
					arg_120_1.talkMaxDuration = var_123_5

					if var_123_5 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_5 + var_123_0
					end
				end
			end

			local var_123_6 = math.max(2, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_6 then
				arg_120_1.fswtw_.percent = Mathf.Lerp(arg_120_1.var_.oldValueTypewriter, var_123_3, (arg_120_1.time_ - var_123_0) / var_123_6)
				arg_120_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_120_1.fswtw_:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_6 and arg_120_1.time_ < var_123_0 + var_123_6 + arg_123_0 then
				arg_120_1.fswtw_.percent = var_123_3

				arg_120_1.fswtw_:SetDirty()
				arg_120_1:ShowNextGo(true)

				arg_120_1.typewritterCharCountI18N = var_123_4
			end

			local var_123_7 = 0

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_7 + arg_123_0 then
				arg_120_1.allBtn_.enabled = false
			end

			if arg_120_1.time_ >= var_123_7 + 2.01666666666667 and arg_120_1.time_ < var_123_7 + 2.01666666666667 + arg_123_0 then
				arg_120_1.allBtn_.enabled = true
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				local var_123_8 = arg_120_1.fswbg_.transform:Find("textbox/adapt/content") or arg_120_1.fswbg_.transform:Find("textbox/content")
				local var_123_9 = arg_120_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_123_10 = var_123_8:GetComponent("RectTransform")

				var_123_8:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_123_10.offsetMin = Vector2.New(0, 0)
				var_123_10.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_123_13 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_120_1.bgmTxt_.text ~= var_123_13 and arg_120_1.bgmTxt_.text ~= "" then
						if arg_120_1.bgmTxt2_.text ~= "" then
							arg_120_1.bgmTxt_.text = arg_120_1.bgmTxt2_.text
						end

						arg_120_1.bgmTxt2_.text = var_123_13

						arg_120_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_120_1.bgmTxt_.text = var_123_13
						arg_120_1.bgmTxt2_.text = var_123_13
					end

					if arg_120_1.bgmTimer then
						arg_120_1.bgmTimer:Stop()

						arg_120_1.bgmTimer = nil
					end

					if arg_120_1.settingData.show_music_name == 1 then
						arg_120_1.musicController:SetSelectedState("show")
						arg_120_1.musicAnimator_:Play("open", 0, 0)

						if arg_120_1.settingData.music_time ~= 0 then
							arg_120_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_120_1.settingData.music_time), function()
								if arg_120_1 == nil or isNil(arg_120_1.bgmTxt_) then
									return
								end

								arg_120_1.musicController:SetSelectedState("hide")
								arg_120_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_123_14 = 0

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_14 + arg_123_0 then
				arg_120_1.allBtn_.enabled = false
			end

			if arg_120_1.time_ >= var_123_14 + 2.01666666666667 and arg_120_1.time_ < var_123_14 + 2.01666666666667 + arg_123_0 then
				arg_120_1.allBtn_.enabled = true
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play116312031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 116312031
		arg_125_1.duration_ = 4.13

		local var_125_0 = {
			zh = 4.133,
			ja = 3.066
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play116312032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.fswbg_:SetActive(false)
				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_125_1:ShowNextGo(false)
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_128_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_125_1.bgmTxt_.text ~= var_128_2 and arg_125_1.bgmTxt_.text ~= "" then
						if arg_125_1.bgmTxt2_.text ~= "" then
							arg_125_1.bgmTxt_.text = arg_125_1.bgmTxt2_.text
						end

						arg_125_1.bgmTxt2_.text = var_128_2

						arg_125_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_125_1.bgmTxt_.text = var_128_2
						arg_125_1.bgmTxt2_.text = var_128_2
					end

					if arg_125_1.bgmTimer then
						arg_125_1.bgmTimer:Stop()

						arg_125_1.bgmTimer = nil
					end

					if arg_125_1.settingData.show_music_name == 1 then
						arg_125_1.musicController:SetSelectedState("show")
						arg_125_1.musicAnimator_:Play("open", 0, 0)

						if arg_125_1.settingData.music_time ~= 0 then
							arg_125_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_125_1.settingData.music_time), function()
								if arg_125_1 == nil or isNil(arg_125_1.bgmTxt_) then
									return
								end

								arg_125_1.musicController:SetSelectedState("hide")
								arg_125_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.266666666666667 < arg_125_1.time_ and arg_125_1.time_ <= 0.266666666666667 + arg_128_0 then
				arg_125_1:AudioAction("play", "music", "bgm_activity_1_1_hel_story_warm", "bgm_activity_1_1_hel_story_warm", "bgm_activity_1_1_hel_story_warm.awb")

				local var_128_5 = manager.audio:GetAudioName("bgm_activity_1_1_hel_story_warm", "bgm_activity_1_1_hel_story_warm")

				if "" ~= "" then
					if arg_125_1.bgmTxt_.text ~= var_128_5 and arg_125_1.bgmTxt_.text ~= "" then
						if arg_125_1.bgmTxt2_.text ~= "" then
							arg_125_1.bgmTxt_.text = arg_125_1.bgmTxt2_.text
						end

						arg_125_1.bgmTxt2_.text = var_128_5

						arg_125_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_125_1.bgmTxt_.text = var_128_5
						arg_125_1.bgmTxt2_.text = var_128_5
					end

					if arg_125_1.bgmTimer then
						arg_125_1.bgmTimer:Stop()

						arg_125_1.bgmTimer = nil
					end

					if arg_125_1.settingData.show_music_name == 1 then
						arg_125_1.musicController:SetSelectedState("show")
						arg_125_1.musicAnimator_:Play("open", 0, 0)

						if arg_125_1.settingData.music_time ~= 0 then
							arg_125_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_125_1.settingData.music_time), function()
								if arg_125_1 == nil or isNil(arg_125_1.bgmTxt_) then
									return
								end

								arg_125_1.musicController:SetSelectedState("hide")
								arg_125_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_128_6 = 0
			local var_128_7 = 0.15

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_6 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_8 = arg_125_1:GetWordFromCfg(116312031)
				local var_128_9 = arg_125_1:FormatText(var_128_8.content)

				arg_125_1.text_.text = var_128_9

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_11 = 5 <= 0 and var_128_7 or var_128_7 * (utf8.len(var_128_9) / 5)

				if (5 <= 0 and var_128_7 or var_128_7 * (utf8.len(var_128_9) / 5)) > 0 and var_128_7 < var_128_11 then
					arg_125_1.talkMaxDuration = var_128_11

					if var_128_11 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_11 + var_128_6
					end
				end

				arg_125_1.text_.text = var_128_9
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312031", "story_v_out_116312.awb") ~= 0 then
					local var_128_12 = manager.audio:GetVoiceLength("story_v_out_116312", "116312031", "story_v_out_116312.awb") / 1000

					if var_128_12 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_12 + var_128_6
					end

					if var_128_8.prefab_name ~= "" and arg_125_1.actors_[var_128_8.prefab_name] ~= nil then
						local var_128_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_8.prefab_name].transform, "story_v_out_116312", "116312031", "story_v_out_116312.awb")

						arg_125_1:RecordAudio("116312031", var_128_13)
						arg_125_1:RecordAudio("116312031", var_128_13)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_116312", "116312031", "story_v_out_116312.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_116312", "116312031", "story_v_out_116312.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_14 = math.max(var_128_7, arg_125_1.talkMaxDuration)

			if var_128_6 <= arg_125_1.time_ and arg_125_1.time_ < var_128_6 + var_128_14 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_6) / var_128_14

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_6 + var_128_14 and arg_125_1.time_ < var_128_6 + var_128_14 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play116312032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 116312032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play116312033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.6

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(116312032).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 24 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 24)

				if (24 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 24)) > 0 and var_134_0 < var_134_3 then
					arg_131_1.talkMaxDuration = var_134_3

					if var_134_3 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_3 + 0
					end
				end

				arg_131_1.text_.text = var_134_1
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_4 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_4

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play116312033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 116312033
		arg_135_1.duration_ = 7

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play116312034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				local var_138_0 = arg_135_1.bgs_.B13c

				arg_135_1.bgs_.B13c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_138_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_138_1 = var_138_0:GetComponent("SpriteRenderer")

				if var_138_1 and var_138_1.sprite then
					local var_138_2 = 2 * (var_138_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_138_0.transform.localScale = Vector3.New(var_138_2 / var_138_1.sprite.bounds.size.y < var_138_2 * manager.ui.mainCameraCom_.aspect / var_138_1.sprite.bounds.size.x and var_138_2 * manager.ui.mainCameraCom_.aspect / var_138_1.sprite.bounds.size.x or var_138_2 / var_138_1.sprite.bounds.size.y, var_138_2 / var_138_1.sprite.bounds.size.y < var_138_2 * manager.ui.mainCameraCom_.aspect / var_138_1.sprite.bounds.size.x and var_138_2 * manager.ui.mainCameraCom_.aspect / var_138_1.sprite.bounds.size.x or var_138_2 / var_138_1.sprite.bounds.size.y, 0)
				end

				for iter_138_0, iter_138_1 in pairs(arg_135_1.bgs_) do
					if iter_138_0 ~= "B13c" then
						iter_138_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_138_3 = 0

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_3 + arg_138_0 then
				arg_135_1.mask_.enabled = true
				arg_135_1.mask_.raycastTarget = true

				arg_135_1:SetGaussion(false)
			end

			local var_138_4 = 2

			if var_138_3 <= arg_135_1.time_ and arg_135_1.time_ < var_138_3 + var_138_4 then
				local var_138_5 = Color.New(1, 1, 1)

				var_138_5.a = Mathf.Lerp(1, 0, (arg_135_1.time_ - var_138_3) / var_138_4)
				arg_135_1.mask_.color = var_138_5
			end

			if arg_135_1.time_ >= var_138_3 + var_138_4 and arg_135_1.time_ < var_138_3 + var_138_4 + arg_138_0 then
				local var_138_6 = Color.New(1, 1, 1)

				arg_135_1.mask_.enabled = false
				var_138_6.a = 0
				arg_135_1.mask_.color = var_138_6
			end

			if arg_135_1.frameCnt_ <= 1 then
				arg_135_1.dialog_:SetActive(false)
			end

			local var_138_7 = 2
			local var_138_8 = 0.15

			if 2 < arg_135_1.time_ and arg_135_1.time_ <= var_138_7 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0

				arg_135_1.dialog_:SetActive(true)

				arg_135_1.dialogCg_.alpha = 0

				local var_138_9 = LeanTween.value(arg_135_1.dialog_, 0, 1, 0.3)

				var_138_9:setOnUpdate(LuaHelper.FloatAction(function(arg_139_0)
					arg_135_1.dialogCg_.alpha = arg_139_0
				end))
				var_138_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_135_1.dialog_)
					var_138_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_135_1.duration_ = arg_135_1.duration_ + 0.3

				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_10 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(116312033).content)

				arg_135_1.text_.text = var_138_10

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_12 = 6 <= 0 and var_138_8 or var_138_8 * (utf8.len(var_138_10) / 6)

				if (6 <= 0 and var_138_8 or var_138_8 * (utf8.len(var_138_10) / 6)) > 0 and var_138_8 < var_138_12 then
					arg_135_1.talkMaxDuration = var_138_12
					var_138_7 = var_138_7 + 0.3

					if var_138_12 + var_138_7 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_12 + var_138_7
					end
				end

				arg_135_1.text_.text = var_138_10
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_13 = var_138_7 + 0.3
			local var_138_14 = math.max(var_138_8, arg_135_1.talkMaxDuration)

			if var_138_7 + 0.3 <= arg_135_1.time_ and arg_135_1.time_ < var_138_13 + var_138_14 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_13) / var_138_14

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_13 + var_138_14 and arg_135_1.time_ < var_138_13 + var_138_14 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play116312034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 116312034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play116312035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.525

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_1 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(116312034).content)

				arg_141_1.text_.text = var_144_1

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_3 = 21 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 21)

				if (21 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 21)) > 0 and var_144_0 < var_144_3 then
					arg_141_1.talkMaxDuration = var_144_3

					if var_144_3 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_3 + 0
					end
				end

				arg_141_1.text_.text = var_144_1
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_4 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_4

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play116312035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 116312035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play116312036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 1.15

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(116312035).content)

				arg_145_1.text_.text = var_148_1

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_3 = 46 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 46)

				if (46 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 46)) > 0 and var_148_0 < var_148_3 then
					arg_145_1.talkMaxDuration = var_148_3

					if var_148_3 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_3 + 0
					end
				end

				arg_145_1.text_.text = var_148_1
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_4 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_4

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play116312036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 116312036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play116312037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.575

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(116312036).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 23 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 23)

				if (23 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 23)) > 0 and var_152_0 < var_152_3 then
					arg_149_1.talkMaxDuration = var_152_3

					if var_152_3 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_3 + 0
					end
				end

				arg_149_1.text_.text = var_152_1
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_4 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_4

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play116312037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 116312037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play116312038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 1.1

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_1 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(116312037).content)

				arg_153_1.text_.text = var_156_1

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_3 = 43 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 43)

				if (43 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 43)) > 0 and var_156_0 < var_156_3 then
					arg_153_1.talkMaxDuration = var_156_3

					if var_156_3 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_3 + 0
					end
				end

				arg_153_1.text_.text = var_156_1
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_4 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_4

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play116312038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 116312038
		arg_157_1.duration_ = 3.3

		local var_157_0 = {
			zh = 3.3,
			ja = 2.333333333332
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play116312039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if arg_157_1.actors_["10025ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10025ui_story"))) then
				local var_160_0 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_157_1.stage_.transform)

				var_160_0.name = "10025ui_story"
				var_160_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_157_1.actors_["10025ui_story"] = var_160_0

				local var_160_1 = var_160_0:GetComponentInChildren(typeof(CharacterEffect))

				var_160_1.enabled = true

				local var_160_2 = GameObjectTools.GetOrAddComponent(var_160_0, typeof(DynamicBoneHelper))

				if var_160_2 then
					var_160_2:EnableDynamicBone(false)
				end

				arg_157_1:ShowWeapon(var_160_1.transform, false)

				arg_157_1.var_["10025ui_story" .. "Animator"] = var_160_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_157_1.var_["10025ui_story" .. "Animator"].applyRootMotion = true
				arg_157_1.var_["10025ui_story" .. "LipSync"] = var_160_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_160_3 = arg_157_1.actors_["10025ui_story"].transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos10025ui_story = var_160_3.localPosition
			end

			local var_160_4 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				var_160_3.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_157_1.time_ - 0) / var_160_4)
				var_160_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_3.position).x, (manager.ui.mainCamera.transform.position - var_160_3.position).y, (manager.ui.mainCamera.transform.position - var_160_3.position).z)
				var_160_3.localEulerAngles.z = 0
				var_160_3.localEulerAngles.x = 0
				var_160_3.localEulerAngles = var_160_3.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				var_160_3.localPosition = Vector3.New(0, -1.1, -5.9)
				var_160_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_3.position).x, (manager.ui.mainCamera.transform.position - var_160_3.position).y, (manager.ui.mainCamera.transform.position - var_160_3.position).z)
				var_160_3.localEulerAngles.z = 0
				var_160_3.localEulerAngles.x = 0
				var_160_3.localEulerAngles = var_160_3.localEulerAngles
			end

			local var_160_5 = arg_157_1.actors_["10025ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_5) and arg_157_1.var_.characterEffect10025ui_story == nil then
				arg_157_1.var_.characterEffect10025ui_story = var_160_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_6 = 0.2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_6 and not isNil(var_160_5) then
				if arg_157_1.var_.characterEffect10025ui_story and not isNil(var_160_5) then
					arg_157_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_6 and arg_157_1.time_ < 0 + var_160_6 + arg_160_0 and not isNil(var_160_5) and arg_157_1.var_.characterEffect10025ui_story then
				arg_157_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action1_1")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_160_8 = 0
			local var_160_9 = 0.25

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_10 = arg_157_1:GetWordFromCfg(116312038)
				local var_160_11 = arg_157_1:FormatText(var_160_10.content)

				arg_157_1.text_.text = var_160_11

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_13 = 10 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 10)

				if (10 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 10)) > 0 and var_160_9 < var_160_13 then
					arg_157_1.talkMaxDuration = var_160_13

					if var_160_13 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_13 + var_160_8
					end
				end

				arg_157_1.text_.text = var_160_11
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312038", "story_v_out_116312.awb") ~= 0 then
					local var_160_14 = manager.audio:GetVoiceLength("story_v_out_116312", "116312038", "story_v_out_116312.awb") / 1000

					if var_160_14 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_14 + var_160_8
					end

					if var_160_10.prefab_name ~= "" and arg_157_1.actors_[var_160_10.prefab_name] ~= nil then
						local var_160_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_10.prefab_name].transform, "story_v_out_116312", "116312038", "story_v_out_116312.awb")

						arg_157_1:RecordAudio("116312038", var_160_15)
						arg_157_1:RecordAudio("116312038", var_160_15)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_116312", "116312038", "story_v_out_116312.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_116312", "116312038", "story_v_out_116312.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_16 = math.max(var_160_9, arg_157_1.talkMaxDuration)

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_16 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_8) / var_160_16

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_8 + var_160_16 and arg_157_1.time_ < var_160_8 + var_160_16 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play116312039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 116312039
		arg_161_1.duration_ = 8.97

		local var_161_0 = {
			zh = 8.966,
			ja = 7.1
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play116312040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_164_0 = 0
			local var_164_1 = 0.8

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_2 = arg_161_1:GetWordFromCfg(116312039)
				local var_164_3 = arg_161_1:FormatText(var_164_2.content)

				arg_161_1.text_.text = var_164_3

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 32 <= 0 and var_164_1 or var_164_1 * (utf8.len(var_164_3) / 32)

				if (32 <= 0 and var_164_1 or var_164_1 * (utf8.len(var_164_3) / 32)) > 0 and var_164_1 < var_164_5 then
					arg_161_1.talkMaxDuration = var_164_5

					if var_164_5 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_3
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312039", "story_v_out_116312.awb") ~= 0 then
					local var_164_6 = manager.audio:GetVoiceLength("story_v_out_116312", "116312039", "story_v_out_116312.awb") / 1000

					if var_164_6 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_6 + var_164_0
					end

					if var_164_2.prefab_name ~= "" and arg_161_1.actors_[var_164_2.prefab_name] ~= nil then
						local var_164_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_2.prefab_name].transform, "story_v_out_116312", "116312039", "story_v_out_116312.awb")

						arg_161_1:RecordAudio("116312039", var_164_7)
						arg_161_1:RecordAudio("116312039", var_164_7)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_116312", "116312039", "story_v_out_116312.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_116312", "116312039", "story_v_out_116312.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_8 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_8 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_8

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_8 and arg_161_1.time_ < var_164_0 + var_164_8 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play116312040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 116312040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play116312041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["10025ui_story"]) and arg_165_1.var_.characterEffect10025ui_story == nil then
				arg_165_1.var_.characterEffect10025ui_story = arg_165_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["10025ui_story"]) then
				if arg_165_1.var_.characterEffect10025ui_story and not isNil(arg_165_1.actors_["10025ui_story"]) then
					arg_165_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_165_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_0)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["10025ui_story"]) and arg_165_1.var_.characterEffect10025ui_story then
				arg_165_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_165_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_168_1 = 0
			local var_168_2 = 0.1

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_3 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(116312040).content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 4 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 4)

				if (4 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 4)) > 0 and var_168_2 < var_168_5 then
					arg_165_1.talkMaxDuration = var_168_5

					if var_168_5 + var_168_1 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + var_168_1
					end
				end

				arg_165_1.text_.text = var_168_3
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_6 = math.max(var_168_2, arg_165_1.talkMaxDuration)

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_6 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_1) / var_168_6

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_1 + var_168_6 and arg_165_1.time_ < var_168_1 + var_168_6 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play116312041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 116312041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play116312042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos10025ui_story = arg_169_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10025ui_story"].transform.position).z)
				arg_169_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["10025ui_story"].transform.localEulerAngles = arg_169_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_169_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10025ui_story"].transform.position).z)
				arg_169_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["10025ui_story"].transform.localEulerAngles = arg_169_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_172_1 = 0
			local var_172_2 = 1.15

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_3 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(116312041).content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 46 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_3) / 46)

				if (46 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_3) / 46)) > 0 and var_172_2 < var_172_5 then
					arg_169_1.talkMaxDuration = var_172_5

					if var_172_5 + var_172_1 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + var_172_1
					end
				end

				arg_169_1.text_.text = var_172_3
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_6 = math.max(var_172_2, arg_169_1.talkMaxDuration)

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_6 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_1) / var_172_6

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_1 + var_172_6 and arg_169_1.time_ < var_172_1 + var_172_6 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play116312042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 116312042
		arg_173_1.duration_ = 11.77

		local var_173_0 = {
			zh = 8.166,
			ja = 11.766
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play116312043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos10025ui_story = arg_173_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10025ui_story"].transform.position).z)
				arg_173_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["10025ui_story"].transform.localEulerAngles = arg_173_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_173_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10025ui_story"].transform.position).z)
				arg_173_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["10025ui_story"].transform.localEulerAngles = arg_173_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["10025ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect10025ui_story == nil then
				arg_173_1.var_.characterEffect10025ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect10025ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect10025ui_story then
				arg_173_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action454")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_176_4 = 0
			local var_176_5 = 0.675

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:GetWordFromCfg(116312042)
				local var_176_7 = arg_173_1:FormatText(var_176_6.content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 27 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 27)

				if (27 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 27)) > 0 and var_176_5 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312042", "story_v_out_116312.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_116312", "116312042", "story_v_out_116312.awb") / 1000

					if var_176_10 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_4
					end

					if var_176_6.prefab_name ~= "" and arg_173_1.actors_[var_176_6.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_6.prefab_name].transform, "story_v_out_116312", "116312042", "story_v_out_116312.awb")

						arg_173_1:RecordAudio("116312042", var_176_11)
						arg_173_1:RecordAudio("116312042", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_116312", "116312042", "story_v_out_116312.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_116312", "116312042", "story_v_out_116312.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_12 = math.max(var_176_5, arg_173_1.talkMaxDuration)

			if var_176_4 <= arg_173_1.time_ and arg_173_1.time_ < var_176_4 + var_176_12 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_4) / var_176_12

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_4 + var_176_12 and arg_173_1.time_ < var_176_4 + var_176_12 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play116312043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 116312043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play116312044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["10025ui_story"]) and arg_177_1.var_.characterEffect10025ui_story == nil then
				arg_177_1.var_.characterEffect10025ui_story = arg_177_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["10025ui_story"]) then
				if arg_177_1.var_.characterEffect10025ui_story and not isNil(arg_177_1.actors_["10025ui_story"]) then
					arg_177_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_177_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_0)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["10025ui_story"]) and arg_177_1.var_.characterEffect10025ui_story then
				arg_177_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_177_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_180_1 = 0
			local var_180_2 = 0.65

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_3 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(116312043).content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 26 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 26)

				if (26 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 26)) > 0 and var_180_2 < var_180_5 then
					arg_177_1.talkMaxDuration = var_180_5

					if var_180_5 + var_180_1 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + var_180_1
					end
				end

				arg_177_1.text_.text = var_180_3
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_6 = math.max(var_180_2, arg_177_1.talkMaxDuration)

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_6 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_1) / var_180_6

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_1 + var_180_6 and arg_177_1.time_ < var_180_1 + var_180_6 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play116312044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 116312044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play116312045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.775

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(116312044).content)

				arg_181_1.text_.text = var_184_1

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_3 = 31 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 31)

				if (31 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 31)) > 0 and var_184_0 < var_184_3 then
					arg_181_1.talkMaxDuration = var_184_3

					if var_184_3 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_3 + 0
					end
				end

				arg_181_1.text_.text = var_184_1
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_4 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_4

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play116312045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 116312045
		arg_185_1.duration_ = 4.73

		local var_185_0 = {
			zh = 4.733,
			ja = 4.2
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play116312046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["10025ui_story"]) and arg_185_1.var_.characterEffect10025ui_story == nil then
				arg_185_1.var_.characterEffect10025ui_story = arg_185_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_0 = 0.2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["10025ui_story"]) then
				if arg_185_1.var_.characterEffect10025ui_story and not isNil(arg_185_1.actors_["10025ui_story"]) then
					arg_185_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["10025ui_story"]) and arg_185_1.var_.characterEffect10025ui_story then
				arg_185_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_2")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_188_2 = 0
			local var_188_3 = 0.4

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_2 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_4 = arg_185_1:GetWordFromCfg(116312045)
				local var_188_5 = arg_185_1:FormatText(var_188_4.content)

				arg_185_1.text_.text = var_188_5

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_7 = 16 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_5) / 16)

				if (16 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_5) / 16)) > 0 and var_188_3 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_2 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_2
					end
				end

				arg_185_1.text_.text = var_188_5
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312045", "story_v_out_116312.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_out_116312", "116312045", "story_v_out_116312.awb") / 1000

					if var_188_8 + var_188_2 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_2
					end

					if var_188_4.prefab_name ~= "" and arg_185_1.actors_[var_188_4.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_4.prefab_name].transform, "story_v_out_116312", "116312045", "story_v_out_116312.awb")

						arg_185_1:RecordAudio("116312045", var_188_9)
						arg_185_1:RecordAudio("116312045", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_116312", "116312045", "story_v_out_116312.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_116312", "116312045", "story_v_out_116312.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_3, arg_185_1.talkMaxDuration)

			if var_188_2 <= arg_185_1.time_ and arg_185_1.time_ < var_188_2 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_2) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_2 + var_188_10 and arg_185_1.time_ < var_188_2 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play116312046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 116312046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play116312047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["10025ui_story"]) and arg_189_1.var_.characterEffect10025ui_story == nil then
				arg_189_1.var_.characterEffect10025ui_story = arg_189_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["10025ui_story"]) then
				if arg_189_1.var_.characterEffect10025ui_story and not isNil(arg_189_1.actors_["10025ui_story"]) then
					arg_189_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_189_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_0)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["10025ui_story"]) and arg_189_1.var_.characterEffect10025ui_story then
				arg_189_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_189_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_192_1 = 0
			local var_192_2 = 0.65

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_3 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(116312046).content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 26 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 26)

				if (26 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 26)) > 0 and var_192_2 < var_192_5 then
					arg_189_1.talkMaxDuration = var_192_5

					if var_192_5 + var_192_1 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + var_192_1
					end
				end

				arg_189_1.text_.text = var_192_3
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_6 = math.max(var_192_2, arg_189_1.talkMaxDuration)

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_6 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_1) / var_192_6

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_1 + var_192_6 and arg_189_1.time_ < var_192_1 + var_192_6 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play116312047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 116312047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play116312048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos10025ui_story = arg_193_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10025ui_story"].transform.position).z)
				arg_193_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["10025ui_story"].transform.localEulerAngles = arg_193_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_193_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10025ui_story"].transform.position).z)
				arg_193_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["10025ui_story"].transform.localEulerAngles = arg_193_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_196_1 = 0
			local var_196_2 = 0.8

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_3 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(116312047).content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 32 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_3) / 32)

				if (32 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_3) / 32)) > 0 and var_196_2 < var_196_5 then
					arg_193_1.talkMaxDuration = var_196_5

					if var_196_5 + var_196_1 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + var_196_1
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_6 = math.max(var_196_2, arg_193_1.talkMaxDuration)

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_6 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_1) / var_196_6

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_1 + var_196_6 and arg_193_1.time_ < var_196_1 + var_196_6 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play116312048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 116312048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play116312049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.7

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_1 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(116312048).content)

				arg_197_1.text_.text = var_200_1

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_3 = 28 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_1) / 28)

				if (28 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_1) / 28)) > 0 and var_200_0 < var_200_3 then
					arg_197_1.talkMaxDuration = var_200_3

					if var_200_3 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_3 + 0
					end
				end

				arg_197_1.text_.text = var_200_1
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_4 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_4 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_4

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_4 and arg_197_1.time_ < 0 + var_200_4 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play116312049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 116312049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play116312050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.575

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(116312049).content)

				arg_201_1.text_.text = var_204_1

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_3 = 23 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 23)

				if (23 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 23)) > 0 and var_204_0 < var_204_3 then
					arg_201_1.talkMaxDuration = var_204_3

					if var_204_3 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_3 + 0
					end
				end

				arg_201_1.text_.text = var_204_1
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_4 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_4

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play116312050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 116312050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play116312051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.35

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(116312050).content)

				arg_205_1.text_.text = var_208_1

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_3 = 14 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 14)

				if (14 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 14)) > 0 and var_208_0 < var_208_3 then
					arg_205_1.talkMaxDuration = var_208_3

					if var_208_3 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_3 + 0
					end
				end

				arg_205_1.text_.text = var_208_1
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_4 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_4

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play116312051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 116312051
		arg_209_1.duration_ = 8.43

		local var_209_0 = {
			zh = 8.233333333332,
			ja = 8.433
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play116312052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if arg_209_1.bgs_.SK0206 == nil then
				local var_212_0 = Object.Instantiate(arg_209_1.paintGo_)

				var_212_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SK0206")
				var_212_0.name = "SK0206"
				var_212_0.transform.parent = arg_209_1.stage_.transform
				var_212_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.bgs_.SK0206 = var_212_0
			end

			if 2 < arg_209_1.time_ and arg_209_1.time_ <= 2 + arg_212_0 then
				local var_212_1 = arg_209_1.bgs_.SK0206

				arg_209_1.bgs_.SK0206.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_212_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_212_2 = var_212_1:GetComponent("SpriteRenderer")

				if var_212_2 and var_212_2.sprite then
					local var_212_3 = 2 * (var_212_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_212_1.transform.localScale = Vector3.New(var_212_3 / var_212_2.sprite.bounds.size.y < var_212_3 * manager.ui.mainCameraCom_.aspect / var_212_2.sprite.bounds.size.x and var_212_3 * manager.ui.mainCameraCom_.aspect / var_212_2.sprite.bounds.size.x or var_212_3 / var_212_2.sprite.bounds.size.y, var_212_3 / var_212_2.sprite.bounds.size.y < var_212_3 * manager.ui.mainCameraCom_.aspect / var_212_2.sprite.bounds.size.x and var_212_3 * manager.ui.mainCameraCom_.aspect / var_212_2.sprite.bounds.size.x or var_212_3 / var_212_2.sprite.bounds.size.y, 0)
				end

				for iter_212_0, iter_212_1 in pairs(arg_209_1.bgs_) do
					if iter_212_0 ~= "SK0206" then
						iter_212_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_212_4 = 0

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_5 = 2

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_5 then
				local var_212_6 = Color.New(0, 0, 0)

				var_212_6.a = Mathf.Lerp(0, 1, (arg_209_1.time_ - var_212_4) / var_212_5)
				arg_209_1.mask_.color = var_212_6
			end

			if arg_209_1.time_ >= var_212_4 + var_212_5 and arg_209_1.time_ < var_212_4 + var_212_5 + arg_212_0 then
				local var_212_7 = Color.New(0, 0, 0)

				var_212_7.a = 1
				arg_209_1.mask_.color = var_212_7
			end

			local var_212_8 = 2

			if 2 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_9 = 2

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_9 then
				local var_212_10 = Color.New(0, 0, 0)

				var_212_10.a = Mathf.Lerp(1, 0, (arg_209_1.time_ - var_212_8) / var_212_9)
				arg_209_1.mask_.color = var_212_10
			end

			if arg_209_1.time_ >= var_212_8 + var_212_9 and arg_209_1.time_ < var_212_8 + var_212_9 + arg_212_0 then
				local var_212_11 = Color.New(0, 0, 0)

				arg_209_1.mask_.enabled = false
				var_212_11.a = 0
				arg_209_1.mask_.color = var_212_11
			end

			local var_212_12 = arg_209_1.bgs_.SK0206.transform

			if 2 < arg_209_1.time_ and arg_209_1.time_ <= 2 + arg_212_0 then
				arg_209_1.var_.moveOldPosSK0206 = var_212_12.localPosition
			end

			local var_212_13 = 0.001

			if 2 <= arg_209_1.time_ and arg_209_1.time_ < 2 + var_212_13 then
				var_212_12.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPosSK0206, Vector3.New(0.34, 2.04, 1), (arg_209_1.time_ - 2) / var_212_13)
			end

			if arg_209_1.time_ >= 2 + var_212_13 and arg_209_1.time_ < 2 + var_212_13 + arg_212_0 then
				var_212_12.localPosition = Vector3.New(0.34, 2.04, 1)
			end

			local var_212_14 = arg_209_1.bgs_.SK0206.transform

			if 2.01666666666667 < arg_209_1.time_ and arg_209_1.time_ <= 2.01666666666667 + arg_212_0 then
				arg_209_1.var_.moveOldPosSK0206 = var_212_14.localPosition
			end

			local var_212_15 = 5.266667

			if 2.01666666666667 <= arg_209_1.time_ and arg_209_1.time_ < 2.01666666666667 + var_212_15 then
				var_212_14.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPosSK0206, Vector3.New(0.75, 2.31, 3), (arg_209_1.time_ - 2.01666666666667) / var_212_15)
			end

			if arg_209_1.time_ >= 2.01666666666667 + var_212_15 and arg_209_1.time_ < 2.01666666666667 + var_212_15 + arg_212_0 then
				var_212_14.localPosition = Vector3.New(0.75, 2.31, 3)
			end

			if arg_209_1.frameCnt_ <= 1 then
				arg_209_1.dialog_:SetActive(false)
			end

			local var_212_16 = 4
			local var_212_17 = 0.25

			if 4 < arg_209_1.time_ and arg_209_1.time_ <= var_212_16 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0

				arg_209_1.dialog_:SetActive(true)

				arg_209_1.dialogCg_.alpha = 0

				local var_212_18 = LeanTween.value(arg_209_1.dialog_, 0, 1, 0.3)

				var_212_18:setOnUpdate(LuaHelper.FloatAction(function(arg_213_0)
					arg_209_1.dialogCg_.alpha = arg_213_0
				end))
				var_212_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_209_1.dialog_)
					var_212_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_209_1.duration_ = arg_209_1.duration_ + 0.3

				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_19 = arg_209_1:GetWordFromCfg(116312051)
				local var_212_20 = arg_209_1:FormatText(var_212_19.content)

				arg_209_1.text_.text = var_212_20

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_22 = 10 <= 0 and var_212_17 or var_212_17 * (utf8.len(var_212_20) / 10)

				if (10 <= 0 and var_212_17 or var_212_17 * (utf8.len(var_212_20) / 10)) > 0 and var_212_17 < var_212_22 then
					arg_209_1.talkMaxDuration = var_212_22
					var_212_16 = var_212_16 + 0.3

					if var_212_22 + var_212_16 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_22 + var_212_16
					end
				end

				arg_209_1.text_.text = var_212_20
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312051", "story_v_out_116312.awb") ~= 0 then
					local var_212_23 = manager.audio:GetVoiceLength("story_v_out_116312", "116312051", "story_v_out_116312.awb") / 1000

					if var_212_23 + var_212_16 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_23 + var_212_16
					end

					if var_212_19.prefab_name ~= "" and arg_209_1.actors_[var_212_19.prefab_name] ~= nil then
						local var_212_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_19.prefab_name].transform, "story_v_out_116312", "116312051", "story_v_out_116312.awb")

						arg_209_1:RecordAudio("116312051", var_212_24)
						arg_209_1:RecordAudio("116312051", var_212_24)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_116312", "116312051", "story_v_out_116312.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_116312", "116312051", "story_v_out_116312.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_25 = var_212_16 + 0.3
			local var_212_26 = math.max(var_212_17, arg_209_1.talkMaxDuration)

			if var_212_16 + 0.3 <= arg_209_1.time_ and arg_209_1.time_ < var_212_25 + var_212_26 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_25) / var_212_26

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_25 + var_212_26 and arg_209_1.time_ < var_212_25 + var_212_26 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SK0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5.266667,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play116312052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 116312052
		arg_215_1.duration_ = 4.3

		local var_215_0 = {
			zh = 4.166,
			ja = 4.3
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play116312053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.3

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_1 = arg_215_1:GetWordFromCfg(116312052)
				local var_218_2 = arg_215_1:FormatText(var_218_1.content)

				arg_215_1.text_.text = var_218_2

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 12 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 12)

				if (12 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 12)) > 0 and var_218_0 < var_218_4 then
					arg_215_1.talkMaxDuration = var_218_4

					if var_218_4 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_4 + 0
					end
				end

				arg_215_1.text_.text = var_218_2
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312052", "story_v_out_116312.awb") ~= 0 then
					local var_218_5 = manager.audio:GetVoiceLength("story_v_out_116312", "116312052", "story_v_out_116312.awb") / 1000

					if var_218_5 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + 0
					end

					if var_218_1.prefab_name ~= "" and arg_215_1.actors_[var_218_1.prefab_name] ~= nil then
						local var_218_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_1.prefab_name].transform, "story_v_out_116312", "116312052", "story_v_out_116312.awb")

						arg_215_1:RecordAudio("116312052", var_218_6)
						arg_215_1:RecordAudio("116312052", var_218_6)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_116312", "116312052", "story_v_out_116312.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_116312", "116312052", "story_v_out_116312.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_7 and arg_215_1.time_ < 0 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play116312053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 116312053
		arg_219_1.duration_ = 7

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play116312054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_0 = 2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				local var_222_1 = Color.New(1, 1, 1)

				var_222_1.a = Mathf.Lerp(1, 0, (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.mask_.color = var_222_1
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				local var_222_2 = Color.New(1, 1, 1)

				arg_219_1.mask_.enabled = false
				var_222_2.a = 0
				arg_219_1.mask_.color = var_222_2
			end

			local var_222_3 = arg_219_1.bgs_.SK0206.transform

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPosSK0206 = var_222_3.localPosition
			end

			local var_222_4 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_4 then
				var_222_3.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPosSK0206, Vector3.New(0, 1, 9), (arg_219_1.time_ - 0) / var_222_4)
			end

			if arg_219_1.time_ >= 0 + var_222_4 and arg_219_1.time_ < 0 + var_222_4 + arg_222_0 then
				var_222_3.localPosition = Vector3.New(0, 1, 9)
			end

			local var_222_5 = arg_219_1.bgs_.SK0206.transform

			if 0.034 < arg_219_1.time_ and arg_219_1.time_ <= 0.034 + arg_222_0 then
				arg_219_1.var_.moveOldPosSK0206 = var_222_5.localPosition
			end

			local var_222_6 = 4

			if 0.034 <= arg_219_1.time_ and arg_219_1.time_ < 0.034 + var_222_6 then
				var_222_5.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPosSK0206, Vector3.New(-0.5, 1, 9), (arg_219_1.time_ - 0.034) / var_222_6)
			end

			if arg_219_1.time_ >= 0.034 + var_222_6 and arg_219_1.time_ < 0.034 + var_222_6 + arg_222_0 then
				var_222_5.localPosition = Vector3.New(-0.5, 1, 9)
			end

			local var_222_7 = 2

			if 2 < arg_219_1.time_ and arg_219_1.time_ <= var_222_7 + arg_222_0 then
				arg_219_1.allBtn_.enabled = false
			end

			if arg_219_1.time_ >= var_222_7 + 2.034 and arg_219_1.time_ < var_222_7 + 2.034 + arg_222_0 then
				arg_219_1.allBtn_.enabled = true
			end

			if arg_219_1.frameCnt_ <= 1 then
				arg_219_1.dialog_:SetActive(false)
			end

			local var_222_8 = 2
			local var_222_9 = 0.675

			if 2 < arg_219_1.time_ and arg_219_1.time_ <= var_222_8 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				arg_219_1.dialog_:SetActive(true)

				arg_219_1.dialogCg_.alpha = 0

				local var_222_10 = LeanTween.value(arg_219_1.dialog_, 0, 1, 0.3)

				var_222_10:setOnUpdate(LuaHelper.FloatAction(function(arg_223_0)
					arg_219_1.dialogCg_.alpha = arg_223_0
				end))
				var_222_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_219_1.dialog_)
					var_222_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_219_1.duration_ = arg_219_1.duration_ + 0.3

				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_11 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(116312053).content)

				arg_219_1.text_.text = var_222_11

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_13 = 27 <= 0 and var_222_9 or var_222_9 * (utf8.len(var_222_11) / 27)

				if (27 <= 0 and var_222_9 or var_222_9 * (utf8.len(var_222_11) / 27)) > 0 and var_222_9 < var_222_13 then
					arg_219_1.talkMaxDuration = var_222_13
					var_222_8 = var_222_8 + 0.3

					if var_222_13 + var_222_8 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_13 + var_222_8
					end
				end

				arg_219_1.text_.text = var_222_11
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_14 = var_222_8 + 0.3
			local var_222_15 = math.max(var_222_9, arg_219_1.talkMaxDuration)

			if var_222_8 + 0.3 <= arg_219_1.time_ and arg_219_1.time_ < var_222_14 + var_222_15 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_14) / var_222_15

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_14 + var_222_15 and arg_219_1.time_ < var_222_14 + var_222_15 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SK0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play116312054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 116312054
		arg_225_1.duration_ = 8.73

		local var_225_0 = {
			zh = 8.733,
			ja = 7.1
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play116312055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.575

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_1 = arg_225_1:GetWordFromCfg(116312054)
				local var_228_2 = arg_225_1:FormatText(var_228_1.content)

				arg_225_1.text_.text = var_228_2

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 23 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 23)

				if (23 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 23)) > 0 and var_228_0 < var_228_4 then
					arg_225_1.talkMaxDuration = var_228_4

					if var_228_4 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_4 + 0
					end
				end

				arg_225_1.text_.text = var_228_2
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312054", "story_v_out_116312.awb") ~= 0 then
					local var_228_5 = manager.audio:GetVoiceLength("story_v_out_116312", "116312054", "story_v_out_116312.awb") / 1000

					if var_228_5 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + 0
					end

					if var_228_1.prefab_name ~= "" and arg_225_1.actors_[var_228_1.prefab_name] ~= nil then
						local var_228_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_1.prefab_name].transform, "story_v_out_116312", "116312054", "story_v_out_116312.awb")

						arg_225_1:RecordAudio("116312054", var_228_6)
						arg_225_1:RecordAudio("116312054", var_228_6)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_116312", "116312054", "story_v_out_116312.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_116312", "116312054", "story_v_out_116312.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_7 and arg_225_1.time_ < 0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play116312055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 116312055
		arg_229_1.duration_ = 8.4

		local var_229_0 = {
			zh = 8.4,
			ja = 7.6
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play116312056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.7

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_1 = arg_229_1:GetWordFromCfg(116312055)
				local var_232_2 = arg_229_1:FormatText(var_232_1.content)

				arg_229_1.text_.text = var_232_2

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 28 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 28)

				if (28 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 28)) > 0 and var_232_0 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end

				arg_229_1.text_.text = var_232_2
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312055", "story_v_out_116312.awb") ~= 0 then
					local var_232_5 = manager.audio:GetVoiceLength("story_v_out_116312", "116312055", "story_v_out_116312.awb") / 1000

					if var_232_5 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + 0
					end

					if var_232_1.prefab_name ~= "" and arg_229_1.actors_[var_232_1.prefab_name] ~= nil then
						local var_232_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_1.prefab_name].transform, "story_v_out_116312", "116312055", "story_v_out_116312.awb")

						arg_229_1:RecordAudio("116312055", var_232_6)
						arg_229_1:RecordAudio("116312055", var_232_6)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_116312", "116312055", "story_v_out_116312.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_116312", "116312055", "story_v_out_116312.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_7 and arg_229_1.time_ < 0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play116312056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 116312056
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play116312057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0.375

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_1 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(116312056).content)

				arg_233_1.text_.text = var_236_1

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_3 = 15 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 15)

				if (15 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 15)) > 0 and var_236_0 < var_236_3 then
					arg_233_1.talkMaxDuration = var_236_3

					if var_236_3 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_3 + 0
					end
				end

				arg_233_1.text_.text = var_236_1
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_4 = math.max(var_236_0, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - 0) / var_236_4

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play116312057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 116312057
		arg_237_1.duration_ = 5.7

		local var_237_0 = {
			zh = 5.7,
			ja = 5.166
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play116312058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0.5

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_1 = arg_237_1:GetWordFromCfg(116312057)
				local var_240_2 = arg_237_1:FormatText(var_240_1.content)

				arg_237_1.text_.text = var_240_2

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_4 = 20 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_2) / 20)

				if (20 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_2) / 20)) > 0 and var_240_0 < var_240_4 then
					arg_237_1.talkMaxDuration = var_240_4

					if var_240_4 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_4 + 0
					end
				end

				arg_237_1.text_.text = var_240_2
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312057", "story_v_out_116312.awb") ~= 0 then
					local var_240_5 = manager.audio:GetVoiceLength("story_v_out_116312", "116312057", "story_v_out_116312.awb") / 1000

					if var_240_5 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + 0
					end

					if var_240_1.prefab_name ~= "" and arg_237_1.actors_[var_240_1.prefab_name] ~= nil then
						local var_240_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_1.prefab_name].transform, "story_v_out_116312", "116312057", "story_v_out_116312.awb")

						arg_237_1:RecordAudio("116312057", var_240_6)
						arg_237_1:RecordAudio("116312057", var_240_6)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_116312", "116312057", "story_v_out_116312.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_116312", "116312057", "story_v_out_116312.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_7 = math.max(var_240_0, arg_237_1.talkMaxDuration)

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_7 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - 0) / var_240_7

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= 0 + var_240_7 and arg_237_1.time_ < 0 + var_240_7 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play116312058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 116312058
		arg_241_1.duration_ = 5.6

		local var_241_0 = {
			zh = 4.7,
			ja = 5.6
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play116312059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0.35

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_1 = arg_241_1:GetWordFromCfg(116312058)
				local var_244_2 = arg_241_1:FormatText(var_244_1.content)

				arg_241_1.text_.text = var_244_2

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_4 = 14 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 14)

				if (14 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 14)) > 0 and var_244_0 < var_244_4 then
					arg_241_1.talkMaxDuration = var_244_4

					if var_244_4 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_4 + 0
					end
				end

				arg_241_1.text_.text = var_244_2
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312058", "story_v_out_116312.awb") ~= 0 then
					local var_244_5 = manager.audio:GetVoiceLength("story_v_out_116312", "116312058", "story_v_out_116312.awb") / 1000

					if var_244_5 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + 0
					end

					if var_244_1.prefab_name ~= "" and arg_241_1.actors_[var_244_1.prefab_name] ~= nil then
						local var_244_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_1.prefab_name].transform, "story_v_out_116312", "116312058", "story_v_out_116312.awb")

						arg_241_1:RecordAudio("116312058", var_244_6)
						arg_241_1:RecordAudio("116312058", var_244_6)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_116312", "116312058", "story_v_out_116312.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_116312", "116312058", "story_v_out_116312.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_7 = math.max(var_244_0, arg_241_1.talkMaxDuration)

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_7 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - 0) / var_244_7

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= 0 + var_244_7 and arg_241_1.time_ < 0 + var_244_7 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play116312059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 116312059
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play116312060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.2

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_1 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(116312059).content)

				arg_245_1.text_.text = var_248_1

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_3 = 8 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 8)

				if (8 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 8)) > 0 and var_248_0 < var_248_3 then
					arg_245_1.talkMaxDuration = var_248_3

					if var_248_3 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_3 + 0
					end
				end

				arg_245_1.text_.text = var_248_1
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_4 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_4 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_4

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_4 and arg_245_1.time_ < 0 + var_248_4 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play116312060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 116312060
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play116312061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0.325

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_1 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(116312060).content)

				arg_249_1.text_.text = var_252_1

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_3 = 13 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 13)

				if (13 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 13)) > 0 and var_252_0 < var_252_3 then
					arg_249_1.talkMaxDuration = var_252_3

					if var_252_3 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_3 + 0
					end
				end

				arg_249_1.text_.text = var_252_1
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_4 = math.max(var_252_0, arg_249_1.talkMaxDuration)

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - 0) / var_252_4

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play116312061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 116312061
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play116312062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0.5

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_1 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(116312061).content)

				arg_253_1.text_.text = var_256_1

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_3 = 20 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 20)

				if (20 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 20)) > 0 and var_256_0 < var_256_3 then
					arg_253_1.talkMaxDuration = var_256_3

					if var_256_3 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_3 + 0
					end
				end

				arg_253_1.text_.text = var_256_1
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_4 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_4 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_4

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_4 and arg_253_1.time_ < 0 + var_256_4 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play116312062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 116312062
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play116312063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 1.375

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_1 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(116312062).content)

				arg_257_1.text_.text = var_260_1

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_3 = 55 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 55)

				if (55 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 55)) > 0 and var_260_0 < var_260_3 then
					arg_257_1.talkMaxDuration = var_260_3

					if var_260_3 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_3 + 0
					end
				end

				arg_257_1.text_.text = var_260_1
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_4 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_4

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play116312063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 116312063
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play116312064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.425

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_1 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(116312063).content)

				arg_261_1.text_.text = var_264_1

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_3 = 17 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 17)

				if (17 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 17)) > 0 and var_264_0 < var_264_3 then
					arg_261_1.talkMaxDuration = var_264_3

					if var_264_3 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_3 + 0
					end
				end

				arg_261_1.text_.text = var_264_1
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_4 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_4

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play116312064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 116312064
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play116312065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0.925

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_1 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(116312064).content)

				arg_265_1.text_.text = var_268_1

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_3 = 37 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 37)

				if (37 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 37)) > 0 and var_268_0 < var_268_3 then
					arg_265_1.talkMaxDuration = var_268_3

					if var_268_3 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_3 + 0
					end
				end

				arg_265_1.text_.text = var_268_1
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_4 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_4 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_4

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_4 and arg_265_1.time_ < 0 + var_268_4 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play116312065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 116312065
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play116312066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPosSK0206 = arg_269_1.bgs_.SK0206.transform.localPosition
			end

			local var_272_0 = 5

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 then
				arg_269_1.bgs_.SK0206.transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPosSK0206, Vector3.New(0, 1, 10), (arg_269_1.time_ - 0) / var_272_0)
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 then
				arg_269_1.bgs_.SK0206.transform.localPosition = Vector3.New(0, 1, 10)
			end

			local var_272_1 = 0

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.allBtn_.enabled = false
			end

			if arg_269_1.time_ >= var_272_1 + 5 and arg_269_1.time_ < var_272_1 + 5 + arg_272_0 then
				arg_269_1.allBtn_.enabled = true
			end

			local var_272_2 = 0
			local var_272_3 = 0.75

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_2 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_4 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(116312065).content)

				arg_269_1.text_.text = var_272_4

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_6 = 30 <= 0 and var_272_3 or var_272_3 * (utf8.len(var_272_4) / 30)

				if (30 <= 0 and var_272_3 or var_272_3 * (utf8.len(var_272_4) / 30)) > 0 and var_272_3 < var_272_6 then
					arg_269_1.talkMaxDuration = var_272_6

					if var_272_6 + var_272_2 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_6 + var_272_2
					end
				end

				arg_269_1.text_.text = var_272_4
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_7 = math.max(var_272_3, arg_269_1.talkMaxDuration)

			if var_272_2 <= arg_269_1.time_ and arg_269_1.time_ < var_272_2 + var_272_7 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_2) / var_272_7

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_2 + var_272_7 and arg_269_1.time_ < var_272_2 + var_272_7 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play116312066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 116312066
		arg_273_1.duration_ = 5.17

		local var_273_0 = {
			zh = 2.333,
			ja = 5.166
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play116312067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0.225

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_1 = arg_273_1:GetWordFromCfg(116312066)
				local var_276_2 = arg_273_1:FormatText(var_276_1.content)

				arg_273_1.text_.text = var_276_2

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_4 = 9 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 9)

				if (9 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 9)) > 0 and var_276_0 < var_276_4 then
					arg_273_1.talkMaxDuration = var_276_4

					if var_276_4 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_4 + 0
					end
				end

				arg_273_1.text_.text = var_276_2
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312066", "story_v_out_116312.awb") ~= 0 then
					local var_276_5 = manager.audio:GetVoiceLength("story_v_out_116312", "116312066", "story_v_out_116312.awb") / 1000

					if var_276_5 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + 0
					end

					if var_276_1.prefab_name ~= "" and arg_273_1.actors_[var_276_1.prefab_name] ~= nil then
						local var_276_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_1.prefab_name].transform, "story_v_out_116312", "116312066", "story_v_out_116312.awb")

						arg_273_1:RecordAudio("116312066", var_276_6)
						arg_273_1:RecordAudio("116312066", var_276_6)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_116312", "116312066", "story_v_out_116312.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_116312", "116312066", "story_v_out_116312.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_7 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_7 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_7

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_7 and arg_273_1.time_ < 0 + var_276_7 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play116312067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 116312067
		arg_277_1.duration_ = 9.9

		local var_277_0 = {
			zh = 9.9,
			ja = 9.566
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play116312068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0.9

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_1 = arg_277_1:GetWordFromCfg(116312067)
				local var_280_2 = arg_277_1:FormatText(var_280_1.content)

				arg_277_1.text_.text = var_280_2

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 36 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 36)

				if (36 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 36)) > 0 and var_280_0 < var_280_4 then
					arg_277_1.talkMaxDuration = var_280_4

					if var_280_4 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_4 + 0
					end
				end

				arg_277_1.text_.text = var_280_2
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312067", "story_v_out_116312.awb") ~= 0 then
					local var_280_5 = manager.audio:GetVoiceLength("story_v_out_116312", "116312067", "story_v_out_116312.awb") / 1000

					if var_280_5 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + 0
					end

					if var_280_1.prefab_name ~= "" and arg_277_1.actors_[var_280_1.prefab_name] ~= nil then
						local var_280_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_1.prefab_name].transform, "story_v_out_116312", "116312067", "story_v_out_116312.awb")

						arg_277_1:RecordAudio("116312067", var_280_6)
						arg_277_1:RecordAudio("116312067", var_280_6)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_116312", "116312067", "story_v_out_116312.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_116312", "116312067", "story_v_out_116312.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_7 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_7 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_7

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_7 and arg_277_1.time_ < 0 + var_280_7 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play116312068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 116312068
		arg_281_1.duration_ = 11.13

		local var_281_0 = {
			zh = 8.233,
			ja = 11.133
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play116312069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0.75

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_1 = arg_281_1:GetWordFromCfg(116312068)
				local var_284_2 = arg_281_1:FormatText(var_284_1.content)

				arg_281_1.text_.text = var_284_2

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 30 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 30)

				if (30 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 30)) > 0 and var_284_0 < var_284_4 then
					arg_281_1.talkMaxDuration = var_284_4

					if var_284_4 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_4 + 0
					end
				end

				arg_281_1.text_.text = var_284_2
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312068", "story_v_out_116312.awb") ~= 0 then
					local var_284_5 = manager.audio:GetVoiceLength("story_v_out_116312", "116312068", "story_v_out_116312.awb") / 1000

					if var_284_5 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + 0
					end

					if var_284_1.prefab_name ~= "" and arg_281_1.actors_[var_284_1.prefab_name] ~= nil then
						local var_284_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_1.prefab_name].transform, "story_v_out_116312", "116312068", "story_v_out_116312.awb")

						arg_281_1:RecordAudio("116312068", var_284_6)
						arg_281_1:RecordAudio("116312068", var_284_6)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_116312", "116312068", "story_v_out_116312.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_116312", "116312068", "story_v_out_116312.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_7 = math.max(var_284_0, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_7 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - 0) / var_284_7

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_7 and arg_281_1.time_ < 0 + var_284_7 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play116312069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 116312069
		arg_285_1.duration_ = 12.37

		local var_285_0 = {
			zh = 7.6,
			ja = 12.366
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play116312070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0.675

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_1 = arg_285_1:GetWordFromCfg(116312069)
				local var_288_2 = arg_285_1:FormatText(var_288_1.content)

				arg_285_1.text_.text = var_288_2

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_4 = 27 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 27)

				if (27 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 27)) > 0 and var_288_0 < var_288_4 then
					arg_285_1.talkMaxDuration = var_288_4

					if var_288_4 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_4 + 0
					end
				end

				arg_285_1.text_.text = var_288_2
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312069", "story_v_out_116312.awb") ~= 0 then
					local var_288_5 = manager.audio:GetVoiceLength("story_v_out_116312", "116312069", "story_v_out_116312.awb") / 1000

					if var_288_5 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + 0
					end

					if var_288_1.prefab_name ~= "" and arg_285_1.actors_[var_288_1.prefab_name] ~= nil then
						local var_288_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_1.prefab_name].transform, "story_v_out_116312", "116312069", "story_v_out_116312.awb")

						arg_285_1:RecordAudio("116312069", var_288_6)
						arg_285_1:RecordAudio("116312069", var_288_6)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_116312", "116312069", "story_v_out_116312.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_116312", "116312069", "story_v_out_116312.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_7 = math.max(var_288_0, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_7 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - 0) / var_288_7

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_7 and arg_285_1.time_ < 0 + var_288_7 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play116312070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 116312070
		arg_289_1.duration_ = 6.6

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play116312071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if arg_289_1.bgs_.STwhite == nil then
				local var_292_0 = Object.Instantiate(arg_289_1.paintGo_)

				var_292_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_292_0.name = "STwhite"
				var_292_0.transform.parent = arg_289_1.stage_.transform
				var_292_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_289_1.bgs_.STwhite = var_292_0
			end

			if 2.00000000000001 < arg_289_1.time_ and arg_289_1.time_ <= 2.00000000000001 + arg_292_0 then
				local var_292_1 = arg_289_1.bgs_.STwhite

				arg_289_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_292_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_292_2 = var_292_1:GetComponent("SpriteRenderer")

				if var_292_2 and var_292_2.sprite then
					local var_292_3 = 2 * (var_292_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_292_1.transform.localScale = Vector3.New(var_292_3 / var_292_2.sprite.bounds.size.y < var_292_3 * manager.ui.mainCameraCom_.aspect / var_292_2.sprite.bounds.size.x and var_292_3 * manager.ui.mainCameraCom_.aspect / var_292_2.sprite.bounds.size.x or var_292_3 / var_292_2.sprite.bounds.size.y, var_292_3 / var_292_2.sprite.bounds.size.y < var_292_3 * manager.ui.mainCameraCom_.aspect / var_292_2.sprite.bounds.size.x and var_292_3 * manager.ui.mainCameraCom_.aspect / var_292_2.sprite.bounds.size.x or var_292_3 / var_292_2.sprite.bounds.size.y, 0)
				end

				for iter_292_0, iter_292_1 in pairs(arg_289_1.bgs_) do
					if iter_292_0 ~= "STwhite" then
						iter_292_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_292_4 = 0

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_4 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_5 = 2

			if var_292_4 <= arg_289_1.time_ and arg_289_1.time_ < var_292_4 + var_292_5 then
				local var_292_6 = Color.New(1, 1, 1)

				var_292_6.a = Mathf.Lerp(0, 1, (arg_289_1.time_ - var_292_4) / var_292_5)
				arg_289_1.mask_.color = var_292_6
			end

			if arg_289_1.time_ >= var_292_4 + var_292_5 and arg_289_1.time_ < var_292_4 + var_292_5 + arg_292_0 then
				local var_292_7 = Color.New(1, 1, 1)

				var_292_7.a = 1
				arg_289_1.mask_.color = var_292_7
			end

			local var_292_8 = 2.00000000000001

			if 2.00000000000001 < arg_289_1.time_ and arg_289_1.time_ <= var_292_8 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_9 = 2

			if var_292_8 <= arg_289_1.time_ and arg_289_1.time_ < var_292_8 + var_292_9 then
				local var_292_10 = Color.New(1, 1, 1)

				var_292_10.a = Mathf.Lerp(1, 0, (arg_289_1.time_ - var_292_8) / var_292_9)
				arg_289_1.mask_.color = var_292_10
			end

			if arg_289_1.time_ >= var_292_8 + var_292_9 and arg_289_1.time_ < var_292_8 + var_292_9 + arg_292_0 then
				local var_292_11 = Color.New(1, 1, 1)

				arg_289_1.mask_.enabled = false
				var_292_11.a = 0
				arg_289_1.mask_.color = var_292_11
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.fswbg_:SetActive(true)
				arg_289_1.dialog_:SetActive(false)

				arg_289_1.fswtw_.percent = 0
				arg_289_1.fswt_.text = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(116312070).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.fswt_)

				arg_289_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_289_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_289_1.fswtw_:SetDirty()

				arg_289_1.typewritterCharCountI18N = 0

				SetActive(arg_289_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_289_1:ShowNextGo(false)
			end

			local var_292_12 = 4

			if 4 < arg_289_1.time_ and arg_289_1.time_ <= var_292_12 + arg_292_0 then
				arg_289_1.var_.oldValueTypewriter = arg_289_1.fswtw_.percent

				SetActive(arg_289_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_289_1:ShowNextGo(false)
			end

			local var_292_13 = 9
			local var_292_14 = 2
			local var_292_15, var_292_16 = arg_289_1:GetPercentByPara(arg_289_1:FormatText(arg_289_1:GetWordFromCfg(116312070).content), 1)

			if var_292_12 < arg_289_1.time_ and arg_289_1.time_ <= var_292_12 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0

				local var_292_17 = var_292_13 <= 0 and var_292_14 or var_292_14 * ((var_292_16 - arg_289_1.typewritterCharCountI18N) / var_292_13)

				if (var_292_13 <= 0 and var_292_14 or var_292_14 * ((var_292_16 - arg_289_1.typewritterCharCountI18N) / var_292_13)) > 0 and var_292_14 < var_292_17 then
					arg_289_1.talkMaxDuration = var_292_17

					if var_292_17 + var_292_12 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_17 + var_292_12
					end
				end
			end

			local var_292_18 = math.max(2, arg_289_1.talkMaxDuration)

			if var_292_12 <= arg_289_1.time_ and arg_289_1.time_ < var_292_12 + var_292_18 then
				arg_289_1.fswtw_.percent = Mathf.Lerp(arg_289_1.var_.oldValueTypewriter, var_292_15, (arg_289_1.time_ - var_292_12) / var_292_18)
				arg_289_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_289_1.fswtw_:SetDirty()
			end

			if arg_289_1.time_ >= var_292_12 + var_292_18 and arg_289_1.time_ < var_292_12 + var_292_18 + arg_292_0 then
				arg_289_1.fswtw_.percent = var_292_15

				arg_289_1.fswtw_:SetDirty()
				arg_289_1:ShowNextGo(true)

				arg_289_1.typewritterCharCountI18N = var_292_16
			end

			if 3.96666666666667 < arg_289_1.time_ and arg_289_1.time_ <= 3.96666666666667 + arg_292_0 then
				local var_292_19 = arg_289_1.fswbg_.transform:Find("textbox/adapt/content") or arg_289_1.fswbg_.transform:Find("textbox/content")
				local var_292_20 = arg_289_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_292_21 = var_292_19:GetComponent("RectTransform")

				var_292_19:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_292_21.offsetMin = Vector2.New(0, 0)
				var_292_21.offsetMax = Vector2.New(0, 0)
			end

			local var_292_22 = 0

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_22 + arg_292_0 then
				arg_289_1.allBtn_.enabled = false
			end

			if arg_289_1.time_ >= var_292_22 + 6.599999999999 and arg_289_1.time_ < var_292_22 + 6.599999999999 + arg_292_0 then
				arg_289_1.allBtn_.enabled = true
			end

			local var_292_23 = 3.96666666666667

			if 3.96666666666667 < arg_289_1.time_ and arg_289_1.time_ <= var_292_23 + arg_292_0 then
				arg_289_1.allBtn_.enabled = false
			end

			if arg_289_1.time_ >= var_292_23 + 2.03333333333333 and arg_289_1.time_ < var_292_23 + 2.03333333333333 + arg_292_0 then
				arg_289_1.allBtn_.enabled = true
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play116312071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 116312071
		arg_293_1.duration_ = 1.97

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play116312072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.fswbg_:SetActive(true)
				arg_293_1.dialog_:SetActive(false)

				arg_293_1.fswtw_.percent = 0
				arg_293_1.fswt_.text = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(116312071).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.fswt_)

				arg_293_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_293_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_293_1.fswtw_:SetDirty()

				arg_293_1.typewritterCharCountI18N = 0

				SetActive(arg_293_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_293_1:ShowNextGo(false)
			end

			local var_296_0 = 0.0333333333333332

			if 0.0333333333333332 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.var_.oldValueTypewriter = arg_293_1.fswtw_.percent

				SetActive(arg_293_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_293_1:ShowNextGo(false)
			end

			local var_296_1 = 29
			local var_296_2 = 1.93333333333333
			local var_296_3, var_296_4 = arg_293_1:GetPercentByPara(arg_293_1:FormatText(arg_293_1:GetWordFromCfg(116312071).content), 1)

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0

				local var_296_5 = var_296_1 <= 0 and var_296_2 or var_296_2 * ((var_296_4 - arg_293_1.typewritterCharCountI18N) / var_296_1)

				if (var_296_1 <= 0 and var_296_2 or var_296_2 * ((var_296_4 - arg_293_1.typewritterCharCountI18N) / var_296_1)) > 0 and var_296_2 < var_296_5 then
					arg_293_1.talkMaxDuration = var_296_5

					if var_296_5 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + var_296_0
					end
				end
			end

			local var_296_6 = math.max(1.93333333333333, arg_293_1.talkMaxDuration)

			if var_296_0 <= arg_293_1.time_ and arg_293_1.time_ < var_296_0 + var_296_6 then
				arg_293_1.fswtw_.percent = Mathf.Lerp(arg_293_1.var_.oldValueTypewriter, var_296_3, (arg_293_1.time_ - var_296_0) / var_296_6)
				arg_293_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_293_1.fswtw_:SetDirty()
			end

			if arg_293_1.time_ >= var_296_0 + var_296_6 and arg_293_1.time_ < var_296_0 + var_296_6 + arg_296_0 then
				arg_293_1.fswtw_.percent = var_296_3

				arg_293_1.fswtw_:SetDirty()
				arg_293_1:ShowNextGo(true)

				arg_293_1.typewritterCharCountI18N = var_296_4
			end

			local var_296_7 = 0

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_7 + arg_296_0 then
				arg_293_1.allBtn_.enabled = false
			end

			if arg_293_1.time_ >= var_296_7 + 1.96666666666667 and arg_293_1.time_ < var_296_7 + 1.96666666666667 + arg_296_0 then
				arg_293_1.allBtn_.enabled = true
			end

			local var_296_8 = 0

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_8 + arg_296_0 then
				arg_293_1.allBtn_.enabled = false
			end

			if arg_293_1.time_ >= var_296_8 + 1.96666666666667 and arg_293_1.time_ < var_296_8 + 1.96666666666667 + arg_296_0 then
				arg_293_1.allBtn_.enabled = true
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play116312072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 116312072
		arg_297_1.duration_ = 11.04

		local var_297_0 = {
			zh = 11.041,
			ja = 10.841
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play116312073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.fswbg_:SetActive(false)
				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_297_1:ShowNextGo(false)
			end

			local var_300_0 = 0

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.mask_.enabled = true
				arg_297_1.mask_.raycastTarget = true

				arg_297_1:SetGaussion(false)
			end

			local var_300_1 = 2

			if var_300_0 <= arg_297_1.time_ and arg_297_1.time_ < var_300_0 + var_300_1 then
				local var_300_2 = Color.New(1, 1, 1)

				var_300_2.a = Mathf.Lerp(1, 0, (arg_297_1.time_ - var_300_0) / var_300_1)
				arg_297_1.mask_.color = var_300_2
			end

			if arg_297_1.time_ >= var_300_0 + var_300_1 and arg_297_1.time_ < var_300_0 + var_300_1 + arg_300_0 then
				local var_300_3 = Color.New(1, 1, 1)

				arg_297_1.mask_.enabled = false
				var_300_3.a = 0
				arg_297_1.mask_.color = var_300_3
			end

			local var_300_4 = 0

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_4 + arg_300_0 then
				arg_297_1.allBtn_.enabled = false
			end

			if arg_297_1.time_ >= var_300_4 + 9.539 and arg_297_1.time_ < var_300_4 + 9.539 + arg_300_0 then
				arg_297_1.allBtn_.enabled = true
			end

			if arg_297_1.frameCnt_ <= 1 then
				arg_297_1.dialog_:SetActive(false)
			end

			local var_300_5 = 1.175
			local var_300_6 = 0.825

			if 1.175 < arg_297_1.time_ and arg_297_1.time_ <= var_300_5 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0

				arg_297_1.dialog_:SetActive(true)

				arg_297_1.dialogCg_.alpha = 0

				local var_300_7 = LeanTween.value(arg_297_1.dialog_, 0, 1, 0.3)

				var_300_7:setOnUpdate(LuaHelper.FloatAction(function(arg_301_0)
					arg_297_1.dialogCg_.alpha = arg_301_0
				end))
				var_300_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_297_1.dialog_)
					var_300_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_297_1.duration_ = arg_297_1.duration_ + 0.3

				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_8 = arg_297_1:GetWordFromCfg(116312072)
				local var_300_9 = arg_297_1:FormatText(var_300_8.content)

				arg_297_1.text_.text = var_300_9

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_11 = 33 <= 0 and var_300_6 or var_300_6 * (utf8.len(var_300_9) / 33)

				if (33 <= 0 and var_300_6 or var_300_6 * (utf8.len(var_300_9) / 33)) > 0 and var_300_6 < var_300_11 then
					arg_297_1.talkMaxDuration = var_300_11
					var_300_5 = var_300_5 + 0.3

					if var_300_11 + var_300_5 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_11 + var_300_5
					end
				end

				arg_297_1.text_.text = var_300_9
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312072", "story_v_out_116312.awb") ~= 0 then
					local var_300_12 = manager.audio:GetVoiceLength("story_v_out_116312", "116312072", "story_v_out_116312.awb") / 1000

					if var_300_12 + var_300_5 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_12 + var_300_5
					end

					if var_300_8.prefab_name ~= "" and arg_297_1.actors_[var_300_8.prefab_name] ~= nil then
						local var_300_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_8.prefab_name].transform, "story_v_out_116312", "116312072", "story_v_out_116312.awb")

						arg_297_1:RecordAudio("116312072", var_300_13)
						arg_297_1:RecordAudio("116312072", var_300_13)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_116312", "116312072", "story_v_out_116312.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_116312", "116312072", "story_v_out_116312.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_14 = var_300_5 + 0.3
			local var_300_15 = math.max(var_300_6, arg_297_1.talkMaxDuration)

			if var_300_5 + 0.3 <= arg_297_1.time_ and arg_297_1.time_ < var_300_14 + var_300_15 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_14) / var_300_15

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_14 + var_300_15 and arg_297_1.time_ < var_300_14 + var_300_15 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play116312073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 116312073
		arg_303_1.duration_ = 6.37

		local var_303_0 = {
			zh = 6.366,
			ja = 5.792999999999
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play116312074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.allBtn_.enabled = false
			end

			if arg_303_1.time_ >= 0 + 5.793 and arg_303_1.time_ < 0 + 5.793 + arg_306_0 then
				arg_303_1.allBtn_.enabled = true
			end

			local var_306_0 = 0
			local var_306_1 = 0.275

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_2 = arg_303_1:GetWordFromCfg(116312073)
				local var_306_3 = arg_303_1:FormatText(var_306_2.content)

				arg_303_1.text_.text = var_306_3

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 11 <= 0 and var_306_1 or var_306_1 * (utf8.len(var_306_3) / 11)

				if (11 <= 0 and var_306_1 or var_306_1 * (utf8.len(var_306_3) / 11)) > 0 and var_306_1 < var_306_5 then
					arg_303_1.talkMaxDuration = var_306_5

					if var_306_5 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + var_306_0
					end
				end

				arg_303_1.text_.text = var_306_3
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312073", "story_v_out_116312.awb") ~= 0 then
					local var_306_6 = manager.audio:GetVoiceLength("story_v_out_116312", "116312073", "story_v_out_116312.awb") / 1000

					if var_306_6 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_6 + var_306_0
					end

					if var_306_2.prefab_name ~= "" and arg_303_1.actors_[var_306_2.prefab_name] ~= nil then
						local var_306_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_2.prefab_name].transform, "story_v_out_116312", "116312073", "story_v_out_116312.awb")

						arg_303_1:RecordAudio("116312073", var_306_7)
						arg_303_1:RecordAudio("116312073", var_306_7)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_116312", "116312073", "story_v_out_116312.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_116312", "116312073", "story_v_out_116312.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_8 = math.max(var_306_1, arg_303_1.talkMaxDuration)

			if var_306_0 <= arg_303_1.time_ and arg_303_1.time_ < var_306_0 + var_306_8 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_0) / var_306_8

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_0 + var_306_8 and arg_303_1.time_ < var_306_0 + var_306_8 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play116312074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 116312074
		arg_307_1.duration_ = 9.83

		local var_307_0 = {
			zh = 7.933,
			ja = 9.833
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play116312075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.allBtn_.enabled = false
			end

			if arg_307_1.time_ >= 0 + 7.631 and arg_307_1.time_ < 0 + 7.631 + arg_310_0 then
				arg_307_1.allBtn_.enabled = true
			end

			local var_310_0 = 0
			local var_310_1 = 0.675

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_2 = arg_307_1:GetWordFromCfg(116312074)
				local var_310_3 = arg_307_1:FormatText(var_310_2.content)

				arg_307_1.text_.text = var_310_3

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_5 = 28 <= 0 and var_310_1 or var_310_1 * (utf8.len(var_310_3) / 28)

				if (28 <= 0 and var_310_1 or var_310_1 * (utf8.len(var_310_3) / 28)) > 0 and var_310_1 < var_310_5 then
					arg_307_1.talkMaxDuration = var_310_5

					if var_310_5 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_5 + var_310_0
					end
				end

				arg_307_1.text_.text = var_310_3
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312074", "story_v_out_116312.awb") ~= 0 then
					local var_310_6 = manager.audio:GetVoiceLength("story_v_out_116312", "116312074", "story_v_out_116312.awb") / 1000

					if var_310_6 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_6 + var_310_0
					end

					if var_310_2.prefab_name ~= "" and arg_307_1.actors_[var_310_2.prefab_name] ~= nil then
						local var_310_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_2.prefab_name].transform, "story_v_out_116312", "116312074", "story_v_out_116312.awb")

						arg_307_1:RecordAudio("116312074", var_310_7)
						arg_307_1:RecordAudio("116312074", var_310_7)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_116312", "116312074", "story_v_out_116312.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_116312", "116312074", "story_v_out_116312.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_8 = math.max(var_310_1, arg_307_1.talkMaxDuration)

			if var_310_0 <= arg_307_1.time_ and arg_307_1.time_ < var_310_0 + var_310_8 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_0) / var_310_8

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_0 + var_310_8 and arg_307_1.time_ < var_310_0 + var_310_8 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play116312075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 116312075
		arg_311_1.duration_ = 11.4

		local var_311_0 = {
			zh = 6.6,
			ja = 11.4
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
			arg_311_1.auto_ = false
		end

		function arg_311_1.playNext_(arg_313_0)
			arg_311_1.onStoryFinished_()
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.var_.moveOldPos10025ui_story = arg_311_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_314_0 = 0.001

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 then
				arg_311_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_311_1.time_ - 0) / var_314_0)
				arg_311_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["10025ui_story"].transform.position).z)
				arg_311_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["10025ui_story"].transform.localEulerAngles = arg_311_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 then
				arg_311_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_311_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["10025ui_story"].transform.position).z)
				arg_311_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["10025ui_story"].transform.localEulerAngles = arg_311_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_314_1 = arg_311_1.actors_["10025ui_story"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect10025ui_story == nil then
				arg_311_1.var_.characterEffect10025ui_story = var_314_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.2

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_2 and not isNil(var_314_1) then
				if arg_311_1.var_.characterEffect10025ui_story and not isNil(var_314_1) then
					arg_311_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= 0 + var_314_2 and arg_311_1.time_ < 0 + var_314_2 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect10025ui_story then
				arg_311_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_314_4 = 0

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_4 + arg_314_0 then
				arg_311_1.allBtn_.enabled = false
			end

			if arg_311_1.time_ >= var_314_4 + 6.565 and arg_311_1.time_ < var_314_4 + 6.565 + arg_314_0 then
				arg_311_1.allBtn_.enabled = true
			end

			local var_314_5 = 0
			local var_314_6 = 0.4

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_5 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_7 = arg_311_1:GetWordFromCfg(116312075)
				local var_314_8 = arg_311_1:FormatText(var_314_7.content)

				arg_311_1.text_.text = var_314_8

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_10 = 16 <= 0 and var_314_6 or var_314_6 * (utf8.len(var_314_8) / 16)

				if (16 <= 0 and var_314_6 or var_314_6 * (utf8.len(var_314_8) / 16)) > 0 and var_314_6 < var_314_10 then
					arg_311_1.talkMaxDuration = var_314_10

					if var_314_10 + var_314_5 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_10 + var_314_5
					end
				end

				arg_311_1.text_.text = var_314_8
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116312", "116312075", "story_v_out_116312.awb") ~= 0 then
					local var_314_11 = manager.audio:GetVoiceLength("story_v_out_116312", "116312075", "story_v_out_116312.awb") / 1000

					if var_314_11 + var_314_5 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_11 + var_314_5
					end

					if var_314_7.prefab_name ~= "" and arg_311_1.actors_[var_314_7.prefab_name] ~= nil then
						local var_314_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_7.prefab_name].transform, "story_v_out_116312", "116312075", "story_v_out_116312.awb")

						arg_311_1:RecordAudio("116312075", var_314_12)
						arg_311_1:RecordAudio("116312075", var_314_12)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_116312", "116312075", "story_v_out_116312.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_116312", "116312075", "story_v_out_116312.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_13 = math.max(var_314_6, arg_311_1.talkMaxDuration)

			if var_314_5 <= arg_311_1.time_ and arg_311_1.time_ < var_314_5 + var_314_13 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_5) / var_314_13

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_5 + var_314_13 and arg_311_1.time_ < var_314_5 + var_314_13 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13c",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/SK0206",
		"TextureConfig/Background/STwhite"
	},
	voices = {
		"story_v_out_116312.awb"
	}
}
