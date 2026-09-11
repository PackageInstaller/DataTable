return {
	Play111122001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 111122001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play111122002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.D10 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D10")
				var_4_0.name = "D10"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.D10 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.D10

				arg_1_1.bgs_.D10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "D10" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.D10:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueD10 = var_4_4.color.a
					arg_1_1.var_.alphaMatValueD10 = var_4_4
				end

				arg_1_1.var_.alphaOldValueD10 = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueD10 then
					arg_1_1.var_.alphaMatValueD10.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueD10, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueD10.color = arg_1_1.var_.alphaMatValueD10.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueD10 then
				arg_1_1.var_.alphaMatValueD10.color.a = 1
				arg_1_1.var_.alphaMatValueD10.color = arg_1_1.var_.alphaMatValueD10.color
			end

			local var_4_6 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_6 + 2 and arg_1_1.time_ < var_4_6 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_9 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_9 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_9

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_9
						arg_1_1.bgmTxt2_.text = var_4_9
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_10 = 2
			local var_4_11 = 0.875

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_12 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_12:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
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

				local var_4_13 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(111122001).content)

				arg_1_1.text_.text = var_4_13

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_15 = 35 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_13) / 35)

				if (35 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_13) / 35)) > 0 and var_4_11 < var_4_15 then
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
	Play111122002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 111122002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play111122003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.4

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(111122002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 16 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 16)

				if (16 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 16)) > 0 and var_11_0 < var_11_3 then
					arg_8_1.talkMaxDuration = var_11_3

					if var_11_3 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_3 + 0
					end
				end

				arg_8_1.text_.text = var_11_1
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_4 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_4

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play111122003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 111122003
		arg_12_1.duration_ = 3.97

		local var_12_0 = {
			ja = 3.966,
			ko = 3.266,
			zh = 3.766,
			en = 3.733
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play111122004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["1094ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1094ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "1094ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "1094ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1094ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["1094ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["1094ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["1094ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["1094ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1094ui_story = var_15_3.localPosition
			end

			local var_15_4 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				var_15_3.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_12_1.time_ - 0) / var_15_4)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				var_15_3.localPosition = Vector3.New(0, -0.84, -6.1)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_15_5 = arg_12_1.actors_["1094ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1094ui_story == nil then
				arg_12_1.var_.characterEffect1094ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_6 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_6 and not isNil(var_15_5) then
				if arg_12_1.var_.characterEffect1094ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_6 and arg_12_1.time_ < 0 + var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1094ui_story then
				arg_12_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_15_8 = 0
			local var_15_9 = 0.35

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_8 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_10 = arg_12_1:GetWordFromCfg(111122003)
				local var_15_11 = arg_12_1:FormatText(var_15_10.content)

				arg_12_1.text_.text = var_15_11

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_13 = 14 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 14)

				if (14 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 14)) > 0 and var_15_9 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_8
					end
				end

				arg_12_1.text_.text = var_15_11
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111122", "111122003", "story_v_out_111122.awb") ~= 0 then
					local var_15_14 = manager.audio:GetVoiceLength("story_v_out_111122", "111122003", "story_v_out_111122.awb") / 1000

					if var_15_14 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_8
					end

					if var_15_10.prefab_name ~= "" and arg_12_1.actors_[var_15_10.prefab_name] ~= nil then
						local var_15_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_10.prefab_name].transform, "story_v_out_111122", "111122003", "story_v_out_111122.awb")

						arg_12_1:RecordAudio("111122003", var_15_15)
						arg_12_1:RecordAudio("111122003", var_15_15)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_111122", "111122003", "story_v_out_111122.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_111122", "111122003", "story_v_out_111122.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_16 = math.max(var_15_9, arg_12_1.talkMaxDuration)

			if var_15_8 <= arg_12_1.time_ and arg_12_1.time_ < var_15_8 + var_15_16 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_8) / var_15_16

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_8 + var_15_16 and arg_12_1.time_ < var_15_8 + var_15_16 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play111122004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 111122004
		arg_16_1.duration_ = 6.53

		local var_16_0 = {
			ja = 6.4,
			ko = 5.066,
			zh = 6.366,
			en = 6.533
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play111122005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["1094ui_story"]) and arg_16_1.var_.characterEffect1094ui_story == nil then
				arg_16_1.var_.characterEffect1094ui_story = arg_16_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.2

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["1094ui_story"]) then
				if arg_16_1.var_.characterEffect1094ui_story and not isNil(arg_16_1.actors_["1094ui_story"]) then
					arg_16_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_0)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["1094ui_story"]) and arg_16_1.var_.characterEffect1094ui_story then
				arg_16_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_19_1 = 0
			local var_19_2 = 0.575

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(111122004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_6 = 23 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_4) / 23)

				if (23 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_4) / 23)) > 0 and var_19_2 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_1
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111122", "111122004", "story_v_out_111122.awb") ~= 0 then
					local var_19_7 = manager.audio:GetVoiceLength("story_v_out_111122", "111122004", "story_v_out_111122.awb") / 1000

					if var_19_7 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_1
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_111122", "111122004", "story_v_out_111122.awb")

						arg_16_1:RecordAudio("111122004", var_19_8)
						arg_16_1:RecordAudio("111122004", var_19_8)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_111122", "111122004", "story_v_out_111122.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_111122", "111122004", "story_v_out_111122.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_9 = math.max(var_19_2, arg_16_1.talkMaxDuration)

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_9 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_1) / var_19_9

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_1 + var_19_9 and arg_16_1.time_ < var_19_1 + var_19_9 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play111122005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 111122005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play111122006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.575

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_1 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(111122005).content)

				arg_20_1.text_.text = var_23_1

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_3 = 23 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 23)

				if (23 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 23)) > 0 and var_23_0 < var_23_3 then
					arg_20_1.talkMaxDuration = var_23_3

					if var_23_3 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_3 + 0
					end
				end

				arg_20_1.text_.text = var_23_1
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_4 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_4

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play111122006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 111122006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play111122007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.825

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_1 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(111122006).content)

				arg_24_1.text_.text = var_27_1

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_3 = 33 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 33)

				if (33 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 33)) > 0 and var_27_0 < var_27_3 then
					arg_24_1.talkMaxDuration = var_27_3

					if var_27_3 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_3 + 0
					end
				end

				arg_24_1.text_.text = var_27_1
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_4 = math.max(var_27_0, arg_24_1.talkMaxDuration)

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - 0) / var_27_4

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play111122007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 111122007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play111122008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.625

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_1 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(111122007).content)

				arg_28_1.text_.text = var_31_1

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_3 = 25 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 25)

				if (25 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 25)) > 0 and var_31_0 < var_31_3 then
					arg_28_1.talkMaxDuration = var_31_3

					if var_31_3 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_3 + 0
					end
				end

				arg_28_1.text_.text = var_31_1
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_4 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_4

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play111122008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 111122008
		arg_32_1.duration_ = 5.3

		local var_32_0 = {
			ja = 2.033,
			ko = 5.1,
			zh = 5.033,
			en = 5.3
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play111122009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.7

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_1 = arg_32_1:GetWordFromCfg(111122008)
				local var_35_2 = arg_32_1:FormatText(var_35_1.content)

				arg_32_1.text_.text = var_35_2

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 28 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 28)

				if (28 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 28)) > 0 and var_35_0 < var_35_4 then
					arg_32_1.talkMaxDuration = var_35_4

					if var_35_4 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_4 + 0
					end
				end

				arg_32_1.text_.text = var_35_2
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111122", "111122008", "story_v_out_111122.awb") ~= 0 then
					local var_35_5 = manager.audio:GetVoiceLength("story_v_out_111122", "111122008", "story_v_out_111122.awb") / 1000

					if var_35_5 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + 0
					end

					if var_35_1.prefab_name ~= "" and arg_32_1.actors_[var_35_1.prefab_name] ~= nil then
						local var_35_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_1.prefab_name].transform, "story_v_out_111122", "111122008", "story_v_out_111122.awb")

						arg_32_1:RecordAudio("111122008", var_35_6)
						arg_32_1:RecordAudio("111122008", var_35_6)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_111122", "111122008", "story_v_out_111122.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_111122", "111122008", "story_v_out_111122.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_0, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - 0) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play111122009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 111122009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play111122010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.525

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_1 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(111122009).content)

				arg_36_1.text_.text = var_39_1

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_3 = 21 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_1) / 21)

				if (21 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_1) / 21)) > 0 and var_39_0 < var_39_3 then
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
	Play111122010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 111122010
		arg_40_1.duration_ = 5.67

		local var_40_0 = {
			ja = 5.666,
			ko = 2.9,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_40_0:Play111122011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_2")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_43_0 = arg_40_1.actors_["1094ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1094ui_story == nil then
				arg_40_1.var_.characterEffect1094ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_1 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_1 and not isNil(var_43_0) then
				if arg_40_1.var_.characterEffect1094ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_1 and arg_40_1.time_ < 0 + var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1094ui_story then
				arg_40_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_43_3 = 0
			local var_43_4 = 0.25

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_3 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_5 = arg_40_1:GetWordFromCfg(111122010)
				local var_43_6 = arg_40_1:FormatText(var_43_5.content)

				arg_40_1.text_.text = var_43_6

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_8 = 7 <= 0 and var_43_4 or var_43_4 * (utf8.len(var_43_6) / 7)

				if (7 <= 0 and var_43_4 or var_43_4 * (utf8.len(var_43_6) / 7)) > 0 and var_43_4 < var_43_8 then
					arg_40_1.talkMaxDuration = var_43_8

					if var_43_8 + var_43_3 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_3
					end
				end

				arg_40_1.text_.text = var_43_6
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111122", "111122010", "story_v_out_111122.awb") ~= 0 then
					local var_43_9 = manager.audio:GetVoiceLength("story_v_out_111122", "111122010", "story_v_out_111122.awb") / 1000

					if var_43_9 + var_43_3 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_3
					end

					if var_43_5.prefab_name ~= "" and arg_40_1.actors_[var_43_5.prefab_name] ~= nil then
						local var_43_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_5.prefab_name].transform, "story_v_out_111122", "111122010", "story_v_out_111122.awb")

						arg_40_1:RecordAudio("111122010", var_43_10)
						arg_40_1:RecordAudio("111122010", var_43_10)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_111122", "111122010", "story_v_out_111122.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_111122", "111122010", "story_v_out_111122.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_11 = math.max(var_43_4, arg_40_1.talkMaxDuration)

			if var_43_3 <= arg_40_1.time_ and arg_40_1.time_ < var_43_3 + var_43_11 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_3) / var_43_11

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_3 + var_43_11 and arg_40_1.time_ < var_43_3 + var_43_11 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play111122011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 111122011
		arg_44_1.duration_ = 5.9

		local var_44_0 = {
			ja = 5.9,
			ko = 3.6,
			zh = 2.866,
			en = 3.566
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
				arg_44_0:Play111122012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1094ui_story"]) and arg_44_1.var_.characterEffect1094ui_story == nil then
				arg_44_1.var_.characterEffect1094ui_story = arg_44_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1094ui_story"]) then
				if arg_44_1.var_.characterEffect1094ui_story and not isNil(arg_44_1.actors_["1094ui_story"]) then
					arg_44_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_0)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1094ui_story"]) and arg_44_1.var_.characterEffect1094ui_story then
				arg_44_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_47_1 = 0
			local var_47_2 = 0.425

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_3 = arg_44_1:GetWordFromCfg(111122011)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_6 = 15 <= 0 and var_47_2 or var_47_2 * (utf8.len(var_47_4) / 15)

				if (15 <= 0 and var_47_2 or var_47_2 * (utf8.len(var_47_4) / 15)) > 0 and var_47_2 < var_47_6 then
					arg_44_1.talkMaxDuration = var_47_6

					if var_47_6 + var_47_1 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_6 + var_47_1
					end
				end

				arg_44_1.text_.text = var_47_4
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111122", "111122011", "story_v_out_111122.awb") ~= 0 then
					local var_47_7 = manager.audio:GetVoiceLength("story_v_out_111122", "111122011", "story_v_out_111122.awb") / 1000

					if var_47_7 + var_47_1 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_1
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_out_111122", "111122011", "story_v_out_111122.awb")

						arg_44_1:RecordAudio("111122011", var_47_8)
						arg_44_1:RecordAudio("111122011", var_47_8)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_111122", "111122011", "story_v_out_111122.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_111122", "111122011", "story_v_out_111122.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_9 = math.max(var_47_2, arg_44_1.talkMaxDuration)

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_9 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_1) / var_47_9

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_1 + var_47_9 and arg_44_1.time_ < var_47_1 + var_47_9 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play111122012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 111122012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play111122013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0.75

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_1 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(111122012).content)

				arg_48_1.text_.text = var_51_1

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_3 = 30 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 30)

				if (30 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 30)) > 0 and var_51_0 < var_51_3 then
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
	Play111122013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 111122013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play111122014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0.45

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_1 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(111122013).content)

				arg_52_1.text_.text = var_55_1

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_3 = 18 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 18)

				if (18 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 18)) > 0 and var_55_0 < var_55_3 then
					arg_52_1.talkMaxDuration = var_55_3

					if var_55_3 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_3 + 0
					end
				end

				arg_52_1.text_.text = var_55_1
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_4 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_4

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play111122014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 111122014
		arg_56_1.duration_ = 13.83

		local var_56_0 = {
			ja = 12.666,
			ko = 9.2,
			zh = 10.3,
			en = 13.833
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
				arg_56_0:Play111122015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0.975

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_1 = arg_56_1:GetWordFromCfg(111122014)
				local var_59_2 = arg_56_1:FormatText(var_59_1.content)

				arg_56_1.text_.text = var_59_2

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_4 = 39 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_2) / 39)

				if (39 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_2) / 39)) > 0 and var_59_0 < var_59_4 then
					arg_56_1.talkMaxDuration = var_59_4

					if var_59_4 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_4 + 0
					end
				end

				arg_56_1.text_.text = var_59_2
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111122", "111122014", "story_v_out_111122.awb") ~= 0 then
					local var_59_5 = manager.audio:GetVoiceLength("story_v_out_111122", "111122014", "story_v_out_111122.awb") / 1000

					if var_59_5 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + 0
					end

					if var_59_1.prefab_name ~= "" and arg_56_1.actors_[var_59_1.prefab_name] ~= nil then
						local var_59_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_1.prefab_name].transform, "story_v_out_111122", "111122014", "story_v_out_111122.awb")

						arg_56_1:RecordAudio("111122014", var_59_6)
						arg_56_1:RecordAudio("111122014", var_59_6)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_111122", "111122014", "story_v_out_111122.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_111122", "111122014", "story_v_out_111122.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_7 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_7 and arg_56_1.time_ < 0 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play111122015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 111122015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play111122016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 1

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_1 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(111122015).content)

				arg_60_1.text_.text = var_63_1

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_3 = 40 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 40)

				if (40 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 40)) > 0 and var_63_0 < var_63_3 then
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
	Play111122016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 111122016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play111122017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 1.025

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_1 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(111122016).content)

				arg_64_1.text_.text = var_67_1

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_3 = 41 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_1) / 41)

				if (41 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_1) / 41)) > 0 and var_67_0 < var_67_3 then
					arg_64_1.talkMaxDuration = var_67_3

					if var_67_3 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_3 + 0
					end
				end

				arg_64_1.text_.text = var_67_1
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_4 = math.max(var_67_0, arg_64_1.talkMaxDuration)

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_4 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - 0) / var_67_4

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= 0 + var_67_4 and arg_64_1.time_ < 0 + var_67_4 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play111122017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 111122017
		arg_68_1.duration_ = 3.8

		local var_68_0 = {
			ja = 3.8,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_68_0:Play111122018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094actionlink/1094action435")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_71_0 = arg_68_1.actors_["1094ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1094ui_story == nil then
				arg_68_1.var_.characterEffect1094ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_1 = 0.2

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_1 and not isNil(var_71_0) then
				if arg_68_1.var_.characterEffect1094ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_1 and arg_68_1.time_ < 0 + var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1094ui_story then
				arg_68_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_71_3 = 0
			local var_71_4 = 0.125

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_3 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_5 = arg_68_1:GetWordFromCfg(111122017)
				local var_71_6 = arg_68_1:FormatText(var_71_5.content)

				arg_68_1.text_.text = var_71_6

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_8 = 5 <= 0 and var_71_4 or var_71_4 * (utf8.len(var_71_6) / 5)

				if (5 <= 0 and var_71_4 or var_71_4 * (utf8.len(var_71_6) / 5)) > 0 and var_71_4 < var_71_8 then
					arg_68_1.talkMaxDuration = var_71_8

					if var_71_8 + var_71_3 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_3
					end
				end

				arg_68_1.text_.text = var_71_6
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111122", "111122017", "story_v_out_111122.awb") ~= 0 then
					local var_71_9 = manager.audio:GetVoiceLength("story_v_out_111122", "111122017", "story_v_out_111122.awb") / 1000

					if var_71_9 + var_71_3 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_3
					end

					if var_71_5.prefab_name ~= "" and arg_68_1.actors_[var_71_5.prefab_name] ~= nil then
						local var_71_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_5.prefab_name].transform, "story_v_out_111122", "111122017", "story_v_out_111122.awb")

						arg_68_1:RecordAudio("111122017", var_71_10)
						arg_68_1:RecordAudio("111122017", var_71_10)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_111122", "111122017", "story_v_out_111122.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_111122", "111122017", "story_v_out_111122.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_11 = math.max(var_71_4, arg_68_1.talkMaxDuration)

			if var_71_3 <= arg_68_1.time_ and arg_68_1.time_ < var_71_3 + var_71_11 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_3) / var_71_11

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_3 + var_71_11 and arg_68_1.time_ < var_71_3 + var_71_11 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play111122018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 111122018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play111122019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1094ui_story"]) and arg_72_1.var_.characterEffect1094ui_story == nil then
				arg_72_1.var_.characterEffect1094ui_story = arg_72_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1094ui_story"]) then
				if arg_72_1.var_.characterEffect1094ui_story and not isNil(arg_72_1.actors_["1094ui_story"]) then
					arg_72_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_0)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1094ui_story"]) and arg_72_1.var_.characterEffect1094ui_story then
				arg_72_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_75_1 = 0
			local var_75_2 = 0.55

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_3 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(111122018).content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 22 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 22)

				if (22 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 22)) > 0 and var_75_2 < var_75_5 then
					arg_72_1.talkMaxDuration = var_75_5

					if var_75_5 + var_75_1 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + var_75_1
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_6 = math.max(var_75_2, arg_72_1.talkMaxDuration)

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_6 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_1) / var_75_6

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_1 + var_75_6 and arg_72_1.time_ < var_75_1 + var_75_6 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play111122019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 111122019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play111122020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0.725

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_1 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(111122019).content)

				arg_76_1.text_.text = var_79_1

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_3 = 29 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 29)

				if (29 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 29)) > 0 and var_79_0 < var_79_3 then
					arg_76_1.talkMaxDuration = var_79_3

					if var_79_3 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_3 + 0
					end
				end

				arg_76_1.text_.text = var_79_1
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_4 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_4 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_4

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_4 and arg_76_1.time_ < 0 + var_79_4 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play111122020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 111122020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
			arg_80_1.auto_ = false
		end

		function arg_80_1.playNext_(arg_82_0)
			arg_80_1.onStoryFinished_()
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0.075

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_1 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(111122020).content)

				arg_80_1.text_.text = var_83_1

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_3 = 3 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 3)

				if (3 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 3)) > 0 and var_83_0 < var_83_3 then
					arg_80_1.talkMaxDuration = var_83_3

					if var_83_3 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_3 + 0
					end
				end

				arg_80_1.text_.text = var_83_1
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_4 = math.max(var_83_0, arg_80_1.talkMaxDuration)

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - 0) / var_83_4

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D10"
	},
	voices = {
		"story_v_out_111122.awb"
	}
}
