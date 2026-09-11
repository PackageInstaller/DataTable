return {
	Play108071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 108071001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play108071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.C07_1 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "C07_1")
				var_4_0.name = "C07_1"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.C07_1 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.C07_1

				arg_1_1.bgs_.C07_1.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "C07_1" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.C07_1:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueC07_1 = var_4_4.color.a
					arg_1_1.var_.alphaMatValueC07_1 = var_4_4
				end

				arg_1_1.var_.alphaOldValueC07_1 = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueC07_1 then
					arg_1_1.var_.alphaMatValueC07_1.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueC07_1, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueC07_1.color = arg_1_1.var_.alphaMatValueC07_1.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueC07_1 then
				arg_1_1.var_.alphaMatValueC07_1.color.a = 1
				arg_1_1.var_.alphaMatValueC07_1.color = arg_1_1.var_.alphaMatValueC07_1.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_8 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_8 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_8

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_8
						arg_1_1.bgmTxt2_.text = var_4_8
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
			local var_4_11 = 0.65

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

				local var_4_13 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(108071001).content)

				arg_1_1.text_.text = var_4_13

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_15 = 26 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_13) / 26)

				if (26 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_13) / 26)) > 0 and var_4_11 < var_4_15 then
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
	Play108071002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 108071002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play108071003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.95

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(108071002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 38 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 38)

				if (38 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 38)) > 0 and var_11_0 < var_11_3 then
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
	Play108071003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 108071003
		arg_12_1.duration_ = 8.1

		local var_12_0 = {
			ja = 5.966,
			ko = 6,
			zh = 8.1,
			en = 7.033
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
				arg_12_0:Play108071004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["3014_tpose"] == nil and not isNil((Asset.Load("Char/" .. "3014_tpose"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "3014_tpose"), arg_12_1.stage_.transform)

				var_15_0.name = "3014_tpose"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["3014_tpose"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["3014_tpose" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["3014_tpose" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["3014_tpose" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["3014_tpose"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect3014_tpose == nil then
				arg_12_1.var_.characterEffect3014_tpose = var_15_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_4 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 and not isNil(var_15_3) then
				if arg_12_1.var_.characterEffect3014_tpose and not isNil(var_15_3) then
					arg_12_1.var_.characterEffect3014_tpose.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect3014_tpose then
				arg_12_1.var_.characterEffect3014_tpose.fillFlat = false
			end

			local var_15_6 = arg_12_1.actors_["3014_tpose"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos3014_tpose = var_15_6.localPosition

				local var_15_7 = GameObjectTools.GetOrAddComponent(var_15_6.gameObject, typeof(DynamicBoneHelper))

				if var_15_7 then
					var_15_7:EnableDynamicBone(false)
				end
			end

			local var_15_8 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_8 then
				var_15_6.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos3014_tpose, Vector3.New(0, -2.35, -2.9), (arg_12_1.time_ - 0) / var_15_8)
				var_15_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_6.position).x, (manager.ui.mainCamera.transform.position - var_15_6.position).y, (manager.ui.mainCamera.transform.position - var_15_6.position).z)
				var_15_6.localEulerAngles.z = 0
				var_15_6.localEulerAngles.x = 0
				var_15_6.localEulerAngles = var_15_6.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_8 and arg_12_1.time_ < 0 + var_15_8 + arg_15_0 then
				var_15_6.localPosition = Vector3.New(0, -2.35, -2.9)
				var_15_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_6.position).x, (manager.ui.mainCamera.transform.position - var_15_6.position).y, (manager.ui.mainCamera.transform.position - var_15_6.position).z)
				var_15_6.localEulerAngles.z = 0
				var_15_6.localEulerAngles.x = 0
				var_15_6.localEulerAngles = var_15_6.localEulerAngles

				local var_15_9 = GameObjectTools.GetOrAddComponent(var_15_6.gameObject, typeof(DynamicBoneHelper))

				if var_15_9 then
					var_15_9:EnableDynamicBone(true)
				end
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("3014_tpose", "StoryTimeline/CharAction/story3014/story3014action/3014action1_1")
			end

			local var_15_10 = 0
			local var_15_11 = 0.55

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_12 = arg_12_1:GetWordFromCfg(108071003)
				local var_15_13 = arg_12_1:FormatText(var_15_12.content)

				arg_12_1.text_.text = var_15_13

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_15 = 22 <= 0 and var_15_11 or var_15_11 * (utf8.len(var_15_13) / 22)

				if (22 <= 0 and var_15_11 or var_15_11 * (utf8.len(var_15_13) / 22)) > 0 and var_15_11 < var_15_15 then
					arg_12_1.talkMaxDuration = var_15_15

					if var_15_15 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_15 + var_15_10
					end
				end

				arg_12_1.text_.text = var_15_13
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071003", "story_v_out_108071.awb") ~= 0 then
					local var_15_16 = manager.audio:GetVoiceLength("story_v_out_108071", "108071003", "story_v_out_108071.awb") / 1000

					if var_15_16 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_16 + var_15_10
					end

					if var_15_12.prefab_name ~= "" and arg_12_1.actors_[var_15_12.prefab_name] ~= nil then
						local var_15_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_12.prefab_name].transform, "story_v_out_108071", "108071003", "story_v_out_108071.awb")

						arg_12_1:RecordAudio("108071003", var_15_17)
						arg_12_1:RecordAudio("108071003", var_15_17)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_108071", "108071003", "story_v_out_108071.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_108071", "108071003", "story_v_out_108071.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_18 = math.max(var_15_11, arg_12_1.talkMaxDuration)

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_18 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_10) / var_15_18

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_10 + var_15_18 and arg_12_1.time_ < var_15_10 + var_15_18 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play108071004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 108071004
		arg_16_1.duration_ = 12.3

		local var_16_0 = {
			ja = 11.6,
			ko = 7.1,
			zh = 6.7,
			en = 12.3
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
				arg_16_0:Play108071005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos3014_tpose = arg_16_1.actors_["3014_tpose"].transform.localPosition

				local var_19_0 = GameObjectTools.GetOrAddComponent(arg_16_1.actors_["3014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_19_0 then
					var_19_0:EnableDynamicBone(false)
				end
			end

			local var_19_1 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_1 then
				arg_16_1.actors_["3014_tpose"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos3014_tpose, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_1)
				arg_16_1.actors_["3014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["3014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["3014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["3014_tpose"].transform.position).z)
				arg_16_1.actors_["3014_tpose"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["3014_tpose"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["3014_tpose"].transform.localEulerAngles = arg_16_1.actors_["3014_tpose"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_1 and arg_16_1.time_ < 0 + var_19_1 + arg_19_0 then
				arg_16_1.actors_["3014_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["3014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["3014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["3014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["3014_tpose"].transform.position).z)
				arg_16_1.actors_["3014_tpose"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["3014_tpose"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["3014_tpose"].transform.localEulerAngles = arg_16_1.actors_["3014_tpose"].transform.localEulerAngles

				local var_19_2 = GameObjectTools.GetOrAddComponent(arg_16_1.actors_["3014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(true)
				end
			end

			local var_19_3 = "1099ui_story"

			if arg_16_1.actors_["1099ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1099ui_story"))) then
				local var_19_4 = Object.Instantiate(Asset.Load("Char/" .. "1099ui_story"), arg_16_1.stage_.transform)

				var_19_4.name = var_19_3
				var_19_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_[var_19_3] = var_19_4

				local var_19_5 = var_19_4:GetComponentInChildren(typeof(CharacterEffect))

				var_19_5.enabled = true

				local var_19_6 = GameObjectTools.GetOrAddComponent(var_19_4, typeof(DynamicBoneHelper))

				if var_19_6 then
					var_19_6:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_5.transform, false)

				arg_16_1.var_[var_19_3 .. "Animator"] = var_19_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_[var_19_3 .. "Animator"].applyRootMotion = true
				arg_16_1.var_[var_19_3 .. "LipSync"] = var_19_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_7 = arg_16_1.actors_["1099ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1099ui_story = var_19_7.localPosition
			end

			local var_19_8 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_8 then
				var_19_7.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1099ui_story, Vector3.New(0, -1.08, -5.9), (arg_16_1.time_ - 0) / var_19_8)
				var_19_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_7.position).x, (manager.ui.mainCamera.transform.position - var_19_7.position).y, (manager.ui.mainCamera.transform.position - var_19_7.position).z)
				var_19_7.localEulerAngles.z = 0
				var_19_7.localEulerAngles.x = 0
				var_19_7.localEulerAngles = var_19_7.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_8 and arg_16_1.time_ < 0 + var_19_8 + arg_19_0 then
				var_19_7.localPosition = Vector3.New(0, -1.08, -5.9)
				var_19_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_7.position).x, (manager.ui.mainCamera.transform.position - var_19_7.position).y, (manager.ui.mainCamera.transform.position - var_19_7.position).z)
				var_19_7.localEulerAngles.z = 0
				var_19_7.localEulerAngles.x = 0
				var_19_7.localEulerAngles = var_19_7.localEulerAngles
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_1")
			end

			local var_19_9 = arg_16_1.actors_["1099ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect1099ui_story == nil then
				arg_16_1.var_.characterEffect1099ui_story = var_19_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_10 = 0.2

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_10 and not isNil(var_19_9) then
				if arg_16_1.var_.characterEffect1099ui_story and not isNil(var_19_9) then
					arg_16_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_10 and arg_16_1.time_ < 0 + var_19_10 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect1099ui_story then
				arg_16_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_19_12 = 0
			local var_19_13 = 0.75

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_14 = arg_16_1:GetWordFromCfg(108071004)
				local var_19_15 = arg_16_1:FormatText(var_19_14.content)

				arg_16_1.text_.text = var_19_15

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_17 = 37 <= 0 and var_19_13 or var_19_13 * (utf8.len(var_19_15) / 37)

				if (37 <= 0 and var_19_13 or var_19_13 * (utf8.len(var_19_15) / 37)) > 0 and var_19_13 < var_19_17 then
					arg_16_1.talkMaxDuration = var_19_17

					if var_19_17 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_17 + var_19_12
					end
				end

				arg_16_1.text_.text = var_19_15
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071004", "story_v_out_108071.awb") ~= 0 then
					local var_19_18 = manager.audio:GetVoiceLength("story_v_out_108071", "108071004", "story_v_out_108071.awb") / 1000

					if var_19_18 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_18 + var_19_12
					end

					if var_19_14.prefab_name ~= "" and arg_16_1.actors_[var_19_14.prefab_name] ~= nil then
						local var_19_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_14.prefab_name].transform, "story_v_out_108071", "108071004", "story_v_out_108071.awb")

						arg_16_1:RecordAudio("108071004", var_19_19)
						arg_16_1:RecordAudio("108071004", var_19_19)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_108071", "108071004", "story_v_out_108071.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_108071", "108071004", "story_v_out_108071.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_20 = math.max(var_19_13, arg_16_1.talkMaxDuration)

			if var_19_12 <= arg_16_1.time_ and arg_16_1.time_ < var_19_12 + var_19_20 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_12) / var_19_20

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_12 + var_19_20 and arg_16_1.time_ < var_19_12 + var_19_20 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play108071005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 108071005
		arg_20_1.duration_ = 6.57

		local var_20_0 = {
			ja = 4.6,
			ko = 5.633,
			zh = 6.566,
			en = 5.633
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play108071006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1099ui_story = arg_20_1.actors_["1099ui_story"].transform.localPosition
			end

			local var_23_0 = 0.5

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 then
				arg_20_1.actors_["1099ui_story"].transform.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1099ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_20_1.time_ - 0) / var_23_0)
				arg_20_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1099ui_story"].transform.position).z)
				arg_20_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["1099ui_story"].transform.localEulerAngles = arg_20_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 then
				arg_20_1.actors_["1099ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				arg_20_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1099ui_story"].transform.position).z)
				arg_20_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["1099ui_story"].transform.localEulerAngles = arg_20_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			local var_23_1 = "1050ui_story"

			if arg_20_1.actors_["1050ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1050ui_story"))) then
				local var_23_2 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_20_1.stage_.transform)

				var_23_2.name = var_23_1
				var_23_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_[var_23_1] = var_23_2

				local var_23_3 = var_23_2:GetComponentInChildren(typeof(CharacterEffect))

				var_23_3.enabled = true

				local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_2, typeof(DynamicBoneHelper))

				if var_23_4 then
					var_23_4:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_3.transform, false)

				arg_20_1.var_[var_23_1 .. "Animator"] = var_23_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_[var_23_1 .. "Animator"].applyRootMotion = true
				arg_20_1.var_[var_23_1 .. "LipSync"] = var_23_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_5 = arg_20_1.actors_["1050ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1050ui_story = var_23_5.localPosition
			end

			local var_23_6 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_6 then
				var_23_5.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1050ui_story, Vector3.New(0.7, -1, -6.1), (arg_20_1.time_ - 0) / var_23_6)
				var_23_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_5.position).x, (manager.ui.mainCamera.transform.position - var_23_5.position).y, (manager.ui.mainCamera.transform.position - var_23_5.position).z)
				var_23_5.localEulerAngles.z = 0
				var_23_5.localEulerAngles.x = 0
				var_23_5.localEulerAngles = var_23_5.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_6 and arg_20_1.time_ < 0 + var_23_6 + arg_23_0 then
				var_23_5.localPosition = Vector3.New(0.7, -1, -6.1)
				var_23_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_5.position).x, (manager.ui.mainCamera.transform.position - var_23_5.position).y, (manager.ui.mainCamera.transform.position - var_23_5.position).z)
				var_23_5.localEulerAngles.z = 0
				var_23_5.localEulerAngles.x = 0
				var_23_5.localEulerAngles = var_23_5.localEulerAngles
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action4_1")
			end

			local var_23_7 = arg_20_1.actors_["1050ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_7) and arg_20_1.var_.characterEffect1050ui_story == nil then
				arg_20_1.var_.characterEffect1050ui_story = var_23_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_8 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_8 and not isNil(var_23_7) then
				if arg_20_1.var_.characterEffect1050ui_story and not isNil(var_23_7) then
					arg_20_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_8 and arg_20_1.time_ < 0 + var_23_8 + arg_23_0 and not isNil(var_23_7) and arg_20_1.var_.characterEffect1050ui_story then
				arg_20_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_23_10 = arg_20_1.actors_["1099ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_10) and arg_20_1.var_.characterEffect1099ui_story == nil then
				arg_20_1.var_.characterEffect1099ui_story = var_23_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_11 = 0.0166666666666667

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_11 and not isNil(var_23_10) then
				if arg_20_1.var_.characterEffect1099ui_story and not isNil(var_23_10) then
					arg_20_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_11)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_11 and arg_20_1.time_ < 0 + var_23_11 + arg_23_0 and not isNil(var_23_10) and arg_20_1.var_.characterEffect1099ui_story then
				arg_20_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_23_12 = 0
			local var_23_13 = 0.625

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_12 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_14 = arg_20_1:GetWordFromCfg(108071005)
				local var_23_15 = arg_20_1:FormatText(var_23_14.content)

				arg_20_1.text_.text = var_23_15

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_17 = 25 <= 0 and var_23_13 or var_23_13 * (utf8.len(var_23_15) / 25)

				if (25 <= 0 and var_23_13 or var_23_13 * (utf8.len(var_23_15) / 25)) > 0 and var_23_13 < var_23_17 then
					arg_20_1.talkMaxDuration = var_23_17

					if var_23_17 + var_23_12 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_17 + var_23_12
					end
				end

				arg_20_1.text_.text = var_23_15
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071005", "story_v_out_108071.awb") ~= 0 then
					local var_23_18 = manager.audio:GetVoiceLength("story_v_out_108071", "108071005", "story_v_out_108071.awb") / 1000

					if var_23_18 + var_23_12 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_18 + var_23_12
					end

					if var_23_14.prefab_name ~= "" and arg_20_1.actors_[var_23_14.prefab_name] ~= nil then
						local var_23_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_14.prefab_name].transform, "story_v_out_108071", "108071005", "story_v_out_108071.awb")

						arg_20_1:RecordAudio("108071005", var_23_19)
						arg_20_1:RecordAudio("108071005", var_23_19)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_108071", "108071005", "story_v_out_108071.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_108071", "108071005", "story_v_out_108071.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_20 = math.max(var_23_13, arg_20_1.talkMaxDuration)

			if var_23_12 <= arg_20_1.time_ and arg_20_1.time_ < var_23_12 + var_23_20 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_12) / var_23_20

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_12 + var_23_20 and arg_20_1.time_ < var_23_12 + var_23_20 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play108071006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 108071006
		arg_24_1.duration_ = 21.97

		local var_24_0 = {
			ja = 21.966,
			ko = 15.4,
			zh = 18.333,
			en = 21.033
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play108071007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1099ui_story = arg_24_1.actors_["1099ui_story"].transform.localPosition
			end

			local var_27_0 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 then
				arg_24_1.actors_["1099ui_story"].transform.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_0)
				arg_24_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1099ui_story"].transform.position).z)
				arg_24_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["1099ui_story"].transform.localEulerAngles = arg_24_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 then
				arg_24_1.actors_["1099ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1099ui_story"].transform.position).z)
				arg_24_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["1099ui_story"].transform.localEulerAngles = arg_24_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			local var_27_1 = arg_24_1.actors_["1050ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1050ui_story = var_27_1.localPosition
			end

			local var_27_2 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_2 then
				var_27_1.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_2)
				var_27_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_1.position).x, (manager.ui.mainCamera.transform.position - var_27_1.position).y, (manager.ui.mainCamera.transform.position - var_27_1.position).z)
				var_27_1.localEulerAngles.z = 0
				var_27_1.localEulerAngles.x = 0
				var_27_1.localEulerAngles = var_27_1.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_2 and arg_24_1.time_ < 0 + var_27_2 + arg_27_0 then
				var_27_1.localPosition = Vector3.New(0, 100, 0)
				var_27_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_1.position).x, (manager.ui.mainCamera.transform.position - var_27_1.position).y, (manager.ui.mainCamera.transform.position - var_27_1.position).z)
				var_27_1.localEulerAngles.z = 0
				var_27_1.localEulerAngles.x = 0
				var_27_1.localEulerAngles = var_27_1.localEulerAngles
			end

			local var_27_3 = arg_24_1.actors_["3014_tpose"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos3014_tpose = var_27_3.localPosition

				local var_27_4 = GameObjectTools.GetOrAddComponent(var_27_3.gameObject, typeof(DynamicBoneHelper))

				if var_27_4 then
					var_27_4:EnableDynamicBone(false)
				end
			end

			local var_27_5 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_5 then
				var_27_3.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos3014_tpose, Vector3.New(0, -2.35, -2.9), (arg_24_1.time_ - 0) / var_27_5)
				var_27_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_3.position).x, (manager.ui.mainCamera.transform.position - var_27_3.position).y, (manager.ui.mainCamera.transform.position - var_27_3.position).z)
				var_27_3.localEulerAngles.z = 0
				var_27_3.localEulerAngles.x = 0
				var_27_3.localEulerAngles = var_27_3.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_5 and arg_24_1.time_ < 0 + var_27_5 + arg_27_0 then
				var_27_3.localPosition = Vector3.New(0, -2.35, -2.9)
				var_27_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_3.position).x, (manager.ui.mainCamera.transform.position - var_27_3.position).y, (manager.ui.mainCamera.transform.position - var_27_3.position).z)
				var_27_3.localEulerAngles.z = 0
				var_27_3.localEulerAngles.x = 0
				var_27_3.localEulerAngles = var_27_3.localEulerAngles

				local var_27_6 = GameObjectTools.GetOrAddComponent(var_27_3.gameObject, typeof(DynamicBoneHelper))

				if var_27_6 then
					var_27_6:EnableDynamicBone(true)
				end
			end

			local var_27_7 = arg_24_1.actors_["3014_tpose"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_7) and arg_24_1.var_.characterEffect3014_tpose == nil then
				arg_24_1.var_.characterEffect3014_tpose = var_27_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_8 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_8 and not isNil(var_27_7) then
				if arg_24_1.var_.characterEffect3014_tpose and not isNil(var_27_7) then
					arg_24_1.var_.characterEffect3014_tpose.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_8 and arg_24_1.time_ < 0 + var_27_8 + arg_27_0 and not isNil(var_27_7) and arg_24_1.var_.characterEffect3014_tpose then
				arg_24_1.var_.characterEffect3014_tpose.fillFlat = false
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("3014_tpose", "StoryTimeline/CharAction/story3014/story3014action/3014action1_1")
			end

			local var_27_10 = 0
			local var_27_11 = 1.375

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_12 = arg_24_1:GetWordFromCfg(108071006)
				local var_27_13 = arg_24_1:FormatText(var_27_12.content)

				arg_24_1.text_.text = var_27_13

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_15 = 55 <= 0 and var_27_11 or var_27_11 * (utf8.len(var_27_13) / 55)

				if (55 <= 0 and var_27_11 or var_27_11 * (utf8.len(var_27_13) / 55)) > 0 and var_27_11 < var_27_15 then
					arg_24_1.talkMaxDuration = var_27_15

					if var_27_15 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_15 + var_27_10
					end
				end

				arg_24_1.text_.text = var_27_13
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071006", "story_v_out_108071.awb") ~= 0 then
					local var_27_16 = manager.audio:GetVoiceLength("story_v_out_108071", "108071006", "story_v_out_108071.awb") / 1000

					if var_27_16 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_16 + var_27_10
					end

					if var_27_12.prefab_name ~= "" and arg_24_1.actors_[var_27_12.prefab_name] ~= nil then
						local var_27_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_12.prefab_name].transform, "story_v_out_108071", "108071006", "story_v_out_108071.awb")

						arg_24_1:RecordAudio("108071006", var_27_17)
						arg_24_1:RecordAudio("108071006", var_27_17)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_108071", "108071006", "story_v_out_108071.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_108071", "108071006", "story_v_out_108071.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_18 = math.max(var_27_11, arg_24_1.talkMaxDuration)

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_18 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_10) / var_27_18

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_10 + var_27_18 and arg_24_1.time_ < var_27_10 + var_27_18 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play108071007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 108071007
		arg_28_1.duration_ = 7.2

		local var_28_0 = {
			ja = 6.666,
			ko = 6.1,
			zh = 5.2,
			en = 7.2
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play108071008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos3014_tpose = arg_28_1.actors_["3014_tpose"].transform.localPosition

				local var_31_0 = GameObjectTools.GetOrAddComponent(arg_28_1.actors_["3014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_31_0 then
					var_31_0:EnableDynamicBone(false)
				end
			end

			local var_31_1 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_1 then
				arg_28_1.actors_["3014_tpose"].transform.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos3014_tpose, Vector3.New(0, 100, 0), (arg_28_1.time_ - 0) / var_31_1)
				arg_28_1.actors_["3014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["3014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["3014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["3014_tpose"].transform.position).z)
				arg_28_1.actors_["3014_tpose"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["3014_tpose"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["3014_tpose"].transform.localEulerAngles = arg_28_1.actors_["3014_tpose"].transform.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_1 and arg_28_1.time_ < 0 + var_31_1 + arg_31_0 then
				arg_28_1.actors_["3014_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_["3014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["3014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["3014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["3014_tpose"].transform.position).z)
				arg_28_1.actors_["3014_tpose"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["3014_tpose"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["3014_tpose"].transform.localEulerAngles = arg_28_1.actors_["3014_tpose"].transform.localEulerAngles

				local var_31_2 = GameObjectTools.GetOrAddComponent(arg_28_1.actors_["3014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(true)
				end
			end

			local var_31_3 = arg_28_1.actors_["1050ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1050ui_story = var_31_3.localPosition
			end

			local var_31_4 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				var_31_3.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_28_1.time_ - 0) / var_31_4)
				var_31_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_3.position).x, (manager.ui.mainCamera.transform.position - var_31_3.position).y, (manager.ui.mainCamera.transform.position - var_31_3.position).z)
				var_31_3.localEulerAngles.z = 0
				var_31_3.localEulerAngles.x = 0
				var_31_3.localEulerAngles = var_31_3.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				var_31_3.localPosition = Vector3.New(0, -1, -6.1)
				var_31_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_3.position).x, (manager.ui.mainCamera.transform.position - var_31_3.position).y, (manager.ui.mainCamera.transform.position - var_31_3.position).z)
				var_31_3.localEulerAngles.z = 0
				var_31_3.localEulerAngles.x = 0
				var_31_3.localEulerAngles = var_31_3.localEulerAngles
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action5_1")
			end

			local var_31_5 = arg_28_1.actors_["1050ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect1050ui_story == nil then
				arg_28_1.var_.characterEffect1050ui_story = var_31_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_6 and not isNil(var_31_5) then
				if arg_28_1.var_.characterEffect1050ui_story and not isNil(var_31_5) then
					arg_28_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_6 and arg_28_1.time_ < 0 + var_31_6 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect1050ui_story then
				arg_28_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_31_8 = 0
			local var_31_9 = 0.65

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_8 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_10 = arg_28_1:GetWordFromCfg(108071007)
				local var_31_11 = arg_28_1:FormatText(var_31_10.content)

				arg_28_1.text_.text = var_31_11

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_13 = 26 <= 0 and var_31_9 or var_31_9 * (utf8.len(var_31_11) / 26)

				if (26 <= 0 and var_31_9 or var_31_9 * (utf8.len(var_31_11) / 26)) > 0 and var_31_9 < var_31_13 then
					arg_28_1.talkMaxDuration = var_31_13

					if var_31_13 + var_31_8 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_13 + var_31_8
					end
				end

				arg_28_1.text_.text = var_31_11
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071007", "story_v_out_108071.awb") ~= 0 then
					local var_31_14 = manager.audio:GetVoiceLength("story_v_out_108071", "108071007", "story_v_out_108071.awb") / 1000

					if var_31_14 + var_31_8 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_14 + var_31_8
					end

					if var_31_10.prefab_name ~= "" and arg_28_1.actors_[var_31_10.prefab_name] ~= nil then
						local var_31_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_10.prefab_name].transform, "story_v_out_108071", "108071007", "story_v_out_108071.awb")

						arg_28_1:RecordAudio("108071007", var_31_15)
						arg_28_1:RecordAudio("108071007", var_31_15)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_108071", "108071007", "story_v_out_108071.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_108071", "108071007", "story_v_out_108071.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_16 = math.max(var_31_9, arg_28_1.talkMaxDuration)

			if var_31_8 <= arg_28_1.time_ and arg_28_1.time_ < var_31_8 + var_31_16 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_8) / var_31_16

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_8 + var_31_16 and arg_28_1.time_ < var_31_8 + var_31_16 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play108071008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 108071008
		arg_32_1.duration_ = 15.7

		local var_32_0 = {
			ja = 15.7,
			ko = 9.7,
			zh = 10.533,
			en = 10.866
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
				arg_32_0:Play108071009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1050ui_story = arg_32_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_35_0 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 then
				arg_32_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0) / var_35_0)
				arg_32_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1050ui_story"].transform.position).z)
				arg_32_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1050ui_story"].transform.localEulerAngles = arg_32_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 then
				arg_32_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1050ui_story"].transform.position).z)
				arg_32_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1050ui_story"].transform.localEulerAngles = arg_32_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_35_1 = arg_32_1.actors_["3014_tpose"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos3014_tpose = var_35_1.localPosition

				local var_35_2 = GameObjectTools.GetOrAddComponent(var_35_1.gameObject, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(false)
				end
			end

			local var_35_3 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 then
				var_35_1.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos3014_tpose, Vector3.New(0, -2.35, -2.9), (arg_32_1.time_ - 0) / var_35_3)
				var_35_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_1.position).x, (manager.ui.mainCamera.transform.position - var_35_1.position).y, (manager.ui.mainCamera.transform.position - var_35_1.position).z)
				var_35_1.localEulerAngles.z = 0
				var_35_1.localEulerAngles.x = 0
				var_35_1.localEulerAngles = var_35_1.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 then
				var_35_1.localPosition = Vector3.New(0, -2.35, -2.9)
				var_35_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_1.position).x, (manager.ui.mainCamera.transform.position - var_35_1.position).y, (manager.ui.mainCamera.transform.position - var_35_1.position).z)
				var_35_1.localEulerAngles.z = 0
				var_35_1.localEulerAngles.x = 0
				var_35_1.localEulerAngles = var_35_1.localEulerAngles

				local var_35_4 = GameObjectTools.GetOrAddComponent(var_35_1.gameObject, typeof(DynamicBoneHelper))

				if var_35_4 then
					var_35_4:EnableDynamicBone(true)
				end
			end

			local var_35_5 = arg_32_1.actors_["3014_tpose"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect3014_tpose == nil then
				arg_32_1.var_.characterEffect3014_tpose = var_35_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_6 and not isNil(var_35_5) then
				if arg_32_1.var_.characterEffect3014_tpose and not isNil(var_35_5) then
					arg_32_1.var_.characterEffect3014_tpose.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_6 and arg_32_1.time_ < 0 + var_35_6 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect3014_tpose then
				arg_32_1.var_.characterEffect3014_tpose.fillFlat = false
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("3014_tpose", "StoryTimeline/CharAction/story3014/story3014action/3014action1_1")
			end

			local var_35_8 = 0
			local var_35_9 = 0.875

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_8 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_10 = arg_32_1:GetWordFromCfg(108071008)
				local var_35_11 = arg_32_1:FormatText(var_35_10.content)

				arg_32_1.text_.text = var_35_11

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_13 = 34 <= 0 and var_35_9 or var_35_9 * (utf8.len(var_35_11) / 34)

				if (34 <= 0 and var_35_9 or var_35_9 * (utf8.len(var_35_11) / 34)) > 0 and var_35_9 < var_35_13 then
					arg_32_1.talkMaxDuration = var_35_13

					if var_35_13 + var_35_8 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_13 + var_35_8
					end
				end

				arg_32_1.text_.text = var_35_11
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071008", "story_v_out_108071.awb") ~= 0 then
					local var_35_14 = manager.audio:GetVoiceLength("story_v_out_108071", "108071008", "story_v_out_108071.awb") / 1000

					if var_35_14 + var_35_8 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_14 + var_35_8
					end

					if var_35_10.prefab_name ~= "" and arg_32_1.actors_[var_35_10.prefab_name] ~= nil then
						local var_35_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_10.prefab_name].transform, "story_v_out_108071", "108071008", "story_v_out_108071.awb")

						arg_32_1:RecordAudio("108071008", var_35_15)
						arg_32_1:RecordAudio("108071008", var_35_15)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_108071", "108071008", "story_v_out_108071.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_108071", "108071008", "story_v_out_108071.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_16 = math.max(var_35_9, arg_32_1.talkMaxDuration)

			if var_35_8 <= arg_32_1.time_ and arg_32_1.time_ < var_35_8 + var_35_16 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_8) / var_35_16

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_8 + var_35_16 and arg_32_1.time_ < var_35_8 + var_35_16 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play108071009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 108071009
		arg_36_1.duration_ = 21.03

		local var_36_0 = {
			ja = 21.033,
			ko = 9.533,
			zh = 12.566,
			en = 12.3
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play108071010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 1.15

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_1 = arg_36_1:GetWordFromCfg(108071009)
				local var_39_2 = arg_36_1:FormatText(var_39_1.content)

				arg_36_1.text_.text = var_39_2

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 44 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 44)

				if (44 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 44)) > 0 and var_39_0 < var_39_4 then
					arg_36_1.talkMaxDuration = var_39_4

					if var_39_4 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_4 + 0
					end
				end

				arg_36_1.text_.text = var_39_2
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071009", "story_v_out_108071.awb") ~= 0 then
					local var_39_5 = manager.audio:GetVoiceLength("story_v_out_108071", "108071009", "story_v_out_108071.awb") / 1000

					if var_39_5 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + 0
					end

					if var_39_1.prefab_name ~= "" and arg_36_1.actors_[var_39_1.prefab_name] ~= nil then
						local var_39_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_1.prefab_name].transform, "story_v_out_108071", "108071009", "story_v_out_108071.awb")

						arg_36_1:RecordAudio("108071009", var_39_6)
						arg_36_1:RecordAudio("108071009", var_39_6)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_108071", "108071009", "story_v_out_108071.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_108071", "108071009", "story_v_out_108071.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_7 = math.max(var_39_0, arg_36_1.talkMaxDuration)

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_7 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - 0) / var_39_7

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= 0 + var_39_7 and arg_36_1.time_ < 0 + var_39_7 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play108071010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 108071010
		arg_40_1.duration_ = 19.17

		local var_40_0 = {
			ja = 19.166,
			ko = 14.266,
			zh = 12.8,
			en = 11.666
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
				arg_40_0:Play108071011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 1.25

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_1 = arg_40_1:GetWordFromCfg(108071010)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.text_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 47 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 47)

				if (47 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 47)) > 0 and var_43_0 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end

				arg_40_1.text_.text = var_43_2
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071010", "story_v_out_108071.awb") ~= 0 then
					local var_43_5 = manager.audio:GetVoiceLength("story_v_out_108071", "108071010", "story_v_out_108071.awb") / 1000

					if var_43_5 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + 0
					end

					if var_43_1.prefab_name ~= "" and arg_40_1.actors_[var_43_1.prefab_name] ~= nil then
						local var_43_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_1.prefab_name].transform, "story_v_out_108071", "108071010", "story_v_out_108071.awb")

						arg_40_1:RecordAudio("108071010", var_43_6)
						arg_40_1:RecordAudio("108071010", var_43_6)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_108071", "108071010", "story_v_out_108071.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_108071", "108071010", "story_v_out_108071.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_7 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_7 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_7

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_7 and arg_40_1.time_ < 0 + var_43_7 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play108071011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 108071011
		arg_44_1.duration_ = 4.5

		local var_44_0 = {
			ja = 2.9,
			ko = 3.566,
			zh = 4.233,
			en = 4.5
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
				arg_44_0:Play108071012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos3014_tpose = arg_44_1.actors_["3014_tpose"].transform.localPosition

				local var_47_0 = GameObjectTools.GetOrAddComponent(arg_44_1.actors_["3014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_47_0 then
					var_47_0:EnableDynamicBone(false)
				end
			end

			local var_47_1 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_1 then
				arg_44_1.actors_["3014_tpose"].transform.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos3014_tpose, Vector3.New(0, 100, 0), (arg_44_1.time_ - 0) / var_47_1)
				arg_44_1.actors_["3014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["3014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["3014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["3014_tpose"].transform.position).z)
				arg_44_1.actors_["3014_tpose"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["3014_tpose"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["3014_tpose"].transform.localEulerAngles = arg_44_1.actors_["3014_tpose"].transform.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_1 and arg_44_1.time_ < 0 + var_47_1 + arg_47_0 then
				arg_44_1.actors_["3014_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.actors_["3014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["3014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["3014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["3014_tpose"].transform.position).z)
				arg_44_1.actors_["3014_tpose"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["3014_tpose"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["3014_tpose"].transform.localEulerAngles = arg_44_1.actors_["3014_tpose"].transform.localEulerAngles

				local var_47_2 = GameObjectTools.GetOrAddComponent(arg_44_1.actors_["3014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_47_2 then
					var_47_2:EnableDynamicBone(true)
				end
			end

			local var_47_3 = arg_44_1.actors_["1050ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1050ui_story = var_47_3.localPosition
			end

			local var_47_4 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 then
				var_47_3.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_44_1.time_ - 0) / var_47_4)
				var_47_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_3.position).x, (manager.ui.mainCamera.transform.position - var_47_3.position).y, (manager.ui.mainCamera.transform.position - var_47_3.position).z)
				var_47_3.localEulerAngles.z = 0
				var_47_3.localEulerAngles.x = 0
				var_47_3.localEulerAngles = var_47_3.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 then
				var_47_3.localPosition = Vector3.New(0, -1, -6.1)
				var_47_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_3.position).x, (manager.ui.mainCamera.transform.position - var_47_3.position).y, (manager.ui.mainCamera.transform.position - var_47_3.position).z)
				var_47_3.localEulerAngles.z = 0
				var_47_3.localEulerAngles.x = 0
				var_47_3.localEulerAngles = var_47_3.localEulerAngles
			end

			local var_47_5 = arg_44_1.actors_["1050ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_5) and arg_44_1.var_.characterEffect1050ui_story == nil then
				arg_44_1.var_.characterEffect1050ui_story = var_47_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_6 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_6 and not isNil(var_47_5) then
				if arg_44_1.var_.characterEffect1050ui_story and not isNil(var_47_5) then
					arg_44_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_6 and arg_44_1.time_ < 0 + var_47_6 + arg_47_0 and not isNil(var_47_5) and arg_44_1.var_.characterEffect1050ui_story then
				arg_44_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_47_8 = 0
			local var_47_9 = 0.45

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_8 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_10 = arg_44_1:GetWordFromCfg(108071011)
				local var_47_11 = arg_44_1:FormatText(var_47_10.content)

				arg_44_1.text_.text = var_47_11

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_13 = 18 <= 0 and var_47_9 or var_47_9 * (utf8.len(var_47_11) / 18)

				if (18 <= 0 and var_47_9 or var_47_9 * (utf8.len(var_47_11) / 18)) > 0 and var_47_9 < var_47_13 then
					arg_44_1.talkMaxDuration = var_47_13

					if var_47_13 + var_47_8 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_13 + var_47_8
					end
				end

				arg_44_1.text_.text = var_47_11
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071011", "story_v_out_108071.awb") ~= 0 then
					local var_47_14 = manager.audio:GetVoiceLength("story_v_out_108071", "108071011", "story_v_out_108071.awb") / 1000

					if var_47_14 + var_47_8 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_14 + var_47_8
					end

					if var_47_10.prefab_name ~= "" and arg_44_1.actors_[var_47_10.prefab_name] ~= nil then
						local var_47_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_10.prefab_name].transform, "story_v_out_108071", "108071011", "story_v_out_108071.awb")

						arg_44_1:RecordAudio("108071011", var_47_15)
						arg_44_1:RecordAudio("108071011", var_47_15)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_108071", "108071011", "story_v_out_108071.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_108071", "108071011", "story_v_out_108071.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_16 = math.max(var_47_9, arg_44_1.talkMaxDuration)

			if var_47_8 <= arg_44_1.time_ and arg_44_1.time_ < var_47_8 + var_47_16 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_8) / var_47_16

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_8 + var_47_16 and arg_44_1.time_ < var_47_8 + var_47_16 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play108071012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 108071012
		arg_48_1.duration_ = 8.67

		local var_48_0 = {
			ja = 8.566,
			ko = 5.033,
			zh = 5.133,
			en = 8.666
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
				arg_48_0:Play108071013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1050ui_story = arg_48_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_51_0 = 0.5

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 then
				arg_48_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1050ui_story, Vector3.New(-0.7, -1, -6.1), (arg_48_1.time_ - 0) / var_51_0)
				arg_48_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1050ui_story"].transform.position).z)
				arg_48_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["1050ui_story"].transform.localEulerAngles = arg_48_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 then
				arg_48_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6.1)
				arg_48_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1050ui_story"].transform.position).z)
				arg_48_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["1050ui_story"].transform.localEulerAngles = arg_48_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_51_1 = arg_48_1.actors_["1099ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1099ui_story = var_51_1.localPosition
			end

			local var_51_2 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_2 then
				var_51_1.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1099ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_48_1.time_ - 0) / var_51_2)
				var_51_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_1.position).x, (manager.ui.mainCamera.transform.position - var_51_1.position).y, (manager.ui.mainCamera.transform.position - var_51_1.position).z)
				var_51_1.localEulerAngles.z = 0
				var_51_1.localEulerAngles.x = 0
				var_51_1.localEulerAngles = var_51_1.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_2 and arg_48_1.time_ < 0 + var_51_2 + arg_51_0 then
				var_51_1.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_51_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_1.position).x, (manager.ui.mainCamera.transform.position - var_51_1.position).y, (manager.ui.mainCamera.transform.position - var_51_1.position).z)
				var_51_1.localEulerAngles.z = 0
				var_51_1.localEulerAngles.x = 0
				var_51_1.localEulerAngles = var_51_1.localEulerAngles
			end

			local var_51_3 = arg_48_1.actors_["1099ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_3) and arg_48_1.var_.characterEffect1099ui_story == nil then
				arg_48_1.var_.characterEffect1099ui_story = var_51_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_4 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 and not isNil(var_51_3) then
				if arg_48_1.var_.characterEffect1099ui_story and not isNil(var_51_3) then
					arg_48_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 and not isNil(var_51_3) and arg_48_1.var_.characterEffect1099ui_story then
				arg_48_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_51_6 = arg_48_1.actors_["1050ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_6) and arg_48_1.var_.characterEffect1050ui_story == nil then
				arg_48_1.var_.characterEffect1050ui_story = var_51_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_7 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_7 and not isNil(var_51_6) then
				if arg_48_1.var_.characterEffect1050ui_story and not isNil(var_51_6) then
					arg_48_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_7)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_7 and arg_48_1.time_ < 0 + var_51_7 + arg_51_0 and not isNil(var_51_6) and arg_48_1.var_.characterEffect1050ui_story then
				arg_48_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_1")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_51_8 = 0
			local var_51_9 = 0.65

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_8 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_10 = arg_48_1:GetWordFromCfg(108071012)
				local var_51_11 = arg_48_1:FormatText(var_51_10.content)

				arg_48_1.text_.text = var_51_11

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_13 = 26 <= 0 and var_51_9 or var_51_9 * (utf8.len(var_51_11) / 26)

				if (26 <= 0 and var_51_9 or var_51_9 * (utf8.len(var_51_11) / 26)) > 0 and var_51_9 < var_51_13 then
					arg_48_1.talkMaxDuration = var_51_13

					if var_51_13 + var_51_8 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_13 + var_51_8
					end
				end

				arg_48_1.text_.text = var_51_11
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071012", "story_v_out_108071.awb") ~= 0 then
					local var_51_14 = manager.audio:GetVoiceLength("story_v_out_108071", "108071012", "story_v_out_108071.awb") / 1000

					if var_51_14 + var_51_8 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_14 + var_51_8
					end

					if var_51_10.prefab_name ~= "" and arg_48_1.actors_[var_51_10.prefab_name] ~= nil then
						local var_51_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_10.prefab_name].transform, "story_v_out_108071", "108071012", "story_v_out_108071.awb")

						arg_48_1:RecordAudio("108071012", var_51_15)
						arg_48_1:RecordAudio("108071012", var_51_15)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_108071", "108071012", "story_v_out_108071.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_108071", "108071012", "story_v_out_108071.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_16 = math.max(var_51_9, arg_48_1.talkMaxDuration)

			if var_51_8 <= arg_48_1.time_ and arg_48_1.time_ < var_51_8 + var_51_16 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_8) / var_51_16

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_8 + var_51_16 and arg_48_1.time_ < var_51_8 + var_51_16 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play108071013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 108071013
		arg_52_1.duration_ = 10.43

		local var_52_0 = {
			ja = 10.066,
			ko = 8.366,
			zh = 7.733,
			en = 10.433
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play108071014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_55_0 = 0
			local var_55_1 = 1.025

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_2 = arg_52_1:GetWordFromCfg(108071013)
				local var_55_3 = arg_52_1:FormatText(var_55_2.content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 41 <= 0 and var_55_1 or var_55_1 * (utf8.len(var_55_3) / 41)

				if (41 <= 0 and var_55_1 or var_55_1 * (utf8.len(var_55_3) / 41)) > 0 and var_55_1 < var_55_5 then
					arg_52_1.talkMaxDuration = var_55_5

					if var_55_5 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071013", "story_v_out_108071.awb") ~= 0 then
					local var_55_6 = manager.audio:GetVoiceLength("story_v_out_108071", "108071013", "story_v_out_108071.awb") / 1000

					if var_55_6 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_0
					end

					if var_55_2.prefab_name ~= "" and arg_52_1.actors_[var_55_2.prefab_name] ~= nil then
						local var_55_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_2.prefab_name].transform, "story_v_out_108071", "108071013", "story_v_out_108071.awb")

						arg_52_1:RecordAudio("108071013", var_55_7)
						arg_52_1:RecordAudio("108071013", var_55_7)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_108071", "108071013", "story_v_out_108071.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_108071", "108071013", "story_v_out_108071.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_8 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_8 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_8

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_8 and arg_52_1.time_ < var_55_0 + var_55_8 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play108071014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 108071014
		arg_56_1.duration_ = 11.63

		local var_56_0 = {
			ja = 11.633,
			ko = 7.9,
			zh = 7.766,
			en = 9.4
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
				arg_56_0:Play108071015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_59_0 = 0
			local var_59_1 = 1

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_2 = arg_56_1:GetWordFromCfg(108071014)
				local var_59_3 = arg_56_1:FormatText(var_59_2.content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 40 <= 0 and var_59_1 or var_59_1 * (utf8.len(var_59_3) / 40)

				if (40 <= 0 and var_59_1 or var_59_1 * (utf8.len(var_59_3) / 40)) > 0 and var_59_1 < var_59_5 then
					arg_56_1.talkMaxDuration = var_59_5

					if var_59_5 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_3
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071014", "story_v_out_108071.awb") ~= 0 then
					local var_59_6 = manager.audio:GetVoiceLength("story_v_out_108071", "108071014", "story_v_out_108071.awb") / 1000

					if var_59_6 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_0
					end

					if var_59_2.prefab_name ~= "" and arg_56_1.actors_[var_59_2.prefab_name] ~= nil then
						local var_59_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_2.prefab_name].transform, "story_v_out_108071", "108071014", "story_v_out_108071.awb")

						arg_56_1:RecordAudio("108071014", var_59_7)
						arg_56_1:RecordAudio("108071014", var_59_7)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_108071", "108071014", "story_v_out_108071.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_108071", "108071014", "story_v_out_108071.awb")
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
	Play108071015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 108071015
		arg_60_1.duration_ = 11.27

		local var_60_0 = {
			ja = 11.266,
			ko = 3.7,
			zh = 3.2,
			en = 4.866
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
				arg_60_0:Play108071016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_63_0 = 0
			local var_63_1 = 0.325

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_2 = arg_60_1:GetWordFromCfg(108071015)
				local var_63_3 = arg_60_1:FormatText(var_63_2.content)

				arg_60_1.text_.text = var_63_3

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 13 <= 0 and var_63_1 or var_63_1 * (utf8.len(var_63_3) / 13)

				if (13 <= 0 and var_63_1 or var_63_1 * (utf8.len(var_63_3) / 13)) > 0 and var_63_1 < var_63_5 then
					arg_60_1.talkMaxDuration = var_63_5

					if var_63_5 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_3
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071015", "story_v_out_108071.awb") ~= 0 then
					local var_63_6 = manager.audio:GetVoiceLength("story_v_out_108071", "108071015", "story_v_out_108071.awb") / 1000

					if var_63_6 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_6 + var_63_0
					end

					if var_63_2.prefab_name ~= "" and arg_60_1.actors_[var_63_2.prefab_name] ~= nil then
						local var_63_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_2.prefab_name].transform, "story_v_out_108071", "108071015", "story_v_out_108071.awb")

						arg_60_1:RecordAudio("108071015", var_63_7)
						arg_60_1:RecordAudio("108071015", var_63_7)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_108071", "108071015", "story_v_out_108071.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_108071", "108071015", "story_v_out_108071.awb")
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
	Play108071016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 108071016
		arg_64_1.duration_ = 22.8

		local var_64_0 = {
			ja = 22.8,
			ko = 15.733,
			zh = 17.233,
			en = 14.4
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
				arg_64_0:Play108071017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1099ui_story = arg_64_1.actors_["1099ui_story"].transform.localPosition
			end

			local var_67_0 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 then
				arg_64_1.actors_["1099ui_story"].transform.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_0)
				arg_64_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1099ui_story"].transform.position).z)
				arg_64_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1099ui_story"].transform.localEulerAngles = arg_64_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 then
				arg_64_1.actors_["1099ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_64_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1099ui_story"].transform.position).z)
				arg_64_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1099ui_story"].transform.localEulerAngles = arg_64_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			local var_67_1 = arg_64_1.actors_["1050ui_story"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1050ui_story = var_67_1.localPosition
			end

			local var_67_2 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_2 then
				var_67_1.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_2)
				var_67_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_1.position).x, (manager.ui.mainCamera.transform.position - var_67_1.position).y, (manager.ui.mainCamera.transform.position - var_67_1.position).z)
				var_67_1.localEulerAngles.z = 0
				var_67_1.localEulerAngles.x = 0
				var_67_1.localEulerAngles = var_67_1.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_2 and arg_64_1.time_ < 0 + var_67_2 + arg_67_0 then
				var_67_1.localPosition = Vector3.New(0, 100, 0)
				var_67_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_1.position).x, (manager.ui.mainCamera.transform.position - var_67_1.position).y, (manager.ui.mainCamera.transform.position - var_67_1.position).z)
				var_67_1.localEulerAngles.z = 0
				var_67_1.localEulerAngles.x = 0
				var_67_1.localEulerAngles = var_67_1.localEulerAngles
			end

			local var_67_3 = arg_64_1.actors_["3014_tpose"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos3014_tpose = var_67_3.localPosition

				local var_67_4 = GameObjectTools.GetOrAddComponent(var_67_3.gameObject, typeof(DynamicBoneHelper))

				if var_67_4 then
					var_67_4:EnableDynamicBone(false)
				end
			end

			local var_67_5 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_5 then
				var_67_3.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos3014_tpose, Vector3.New(0, -2.35, -2.9), (arg_64_1.time_ - 0) / var_67_5)
				var_67_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_3.position).x, (manager.ui.mainCamera.transform.position - var_67_3.position).y, (manager.ui.mainCamera.transform.position - var_67_3.position).z)
				var_67_3.localEulerAngles.z = 0
				var_67_3.localEulerAngles.x = 0
				var_67_3.localEulerAngles = var_67_3.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_5 and arg_64_1.time_ < 0 + var_67_5 + arg_67_0 then
				var_67_3.localPosition = Vector3.New(0, -2.35, -2.9)
				var_67_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_3.position).x, (manager.ui.mainCamera.transform.position - var_67_3.position).y, (manager.ui.mainCamera.transform.position - var_67_3.position).z)
				var_67_3.localEulerAngles.z = 0
				var_67_3.localEulerAngles.x = 0
				var_67_3.localEulerAngles = var_67_3.localEulerAngles

				local var_67_6 = GameObjectTools.GetOrAddComponent(var_67_3.gameObject, typeof(DynamicBoneHelper))

				if var_67_6 then
					var_67_6:EnableDynamicBone(true)
				end
			end

			local var_67_7 = arg_64_1.actors_["3014_tpose"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_7) and arg_64_1.var_.characterEffect3014_tpose == nil then
				arg_64_1.var_.characterEffect3014_tpose = var_67_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_8 = 0.2

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_8 and not isNil(var_67_7) then
				if arg_64_1.var_.characterEffect3014_tpose and not isNil(var_67_7) then
					arg_64_1.var_.characterEffect3014_tpose.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_8 and arg_64_1.time_ < 0 + var_67_8 + arg_67_0 and not isNil(var_67_7) and arg_64_1.var_.characterEffect3014_tpose then
				arg_64_1.var_.characterEffect3014_tpose.fillFlat = false
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("3014_tpose", "StoryTimeline/CharAction/story3014/story3014action/3014action1_1")
			end

			local var_67_10 = 0
			local var_67_11 = 1.375

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_12 = arg_64_1:GetWordFromCfg(108071016)
				local var_67_13 = arg_64_1:FormatText(var_67_12.content)

				arg_64_1.text_.text = var_67_13

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_15 = 53 <= 0 and var_67_11 or var_67_11 * (utf8.len(var_67_13) / 53)

				if (53 <= 0 and var_67_11 or var_67_11 * (utf8.len(var_67_13) / 53)) > 0 and var_67_11 < var_67_15 then
					arg_64_1.talkMaxDuration = var_67_15

					if var_67_15 + var_67_10 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_15 + var_67_10
					end
				end

				arg_64_1.text_.text = var_67_13
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071016", "story_v_out_108071.awb") ~= 0 then
					local var_67_16 = manager.audio:GetVoiceLength("story_v_out_108071", "108071016", "story_v_out_108071.awb") / 1000

					if var_67_16 + var_67_10 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_16 + var_67_10
					end

					if var_67_12.prefab_name ~= "" and arg_64_1.actors_[var_67_12.prefab_name] ~= nil then
						local var_67_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_12.prefab_name].transform, "story_v_out_108071", "108071016", "story_v_out_108071.awb")

						arg_64_1:RecordAudio("108071016", var_67_17)
						arg_64_1:RecordAudio("108071016", var_67_17)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_108071", "108071016", "story_v_out_108071.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_108071", "108071016", "story_v_out_108071.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_18 = math.max(var_67_11, arg_64_1.talkMaxDuration)

			if var_67_10 <= arg_64_1.time_ and arg_64_1.time_ < var_67_10 + var_67_18 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_10) / var_67_18

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_10 + var_67_18 and arg_64_1.time_ < var_67_10 + var_67_18 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play108071017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 108071017
		arg_68_1.duration_ = 6.77

		local var_68_0 = {
			ja = 6.766,
			ko = 4.6,
			zh = 4.966,
			en = 3.333
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
				arg_68_0:Play108071018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0.35

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_1 = arg_68_1:GetWordFromCfg(108071017)
				local var_71_2 = arg_68_1:FormatText(var_71_1.content)

				arg_68_1.text_.text = var_71_2

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 14 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 14)

				if (14 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 14)) > 0 and var_71_0 < var_71_4 then
					arg_68_1.talkMaxDuration = var_71_4

					if var_71_4 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_4 + 0
					end
				end

				arg_68_1.text_.text = var_71_2
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071017", "story_v_out_108071.awb") ~= 0 then
					local var_71_5 = manager.audio:GetVoiceLength("story_v_out_108071", "108071017", "story_v_out_108071.awb") / 1000

					if var_71_5 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + 0
					end

					if var_71_1.prefab_name ~= "" and arg_68_1.actors_[var_71_1.prefab_name] ~= nil then
						local var_71_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_1.prefab_name].transform, "story_v_out_108071", "108071017", "story_v_out_108071.awb")

						arg_68_1:RecordAudio("108071017", var_71_6)
						arg_68_1:RecordAudio("108071017", var_71_6)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_108071", "108071017", "story_v_out_108071.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_108071", "108071017", "story_v_out_108071.awb")
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
	Play108071018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 108071018
		arg_72_1.duration_ = 6.87

		local var_72_0 = {
			ja = 5.933,
			ko = 5.833,
			zh = 6.866,
			en = 4.666
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
				arg_72_0:Play108071019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.575

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_1 = arg_72_1:GetWordFromCfg(108071018)
				local var_75_2 = arg_72_1:FormatText(var_75_1.content)

				arg_72_1.text_.text = var_75_2

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 23 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 23)

				if (23 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 23)) > 0 and var_75_0 < var_75_4 then
					arg_72_1.talkMaxDuration = var_75_4

					if var_75_4 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_4 + 0
					end
				end

				arg_72_1.text_.text = var_75_2
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071018", "story_v_out_108071.awb") ~= 0 then
					local var_75_5 = manager.audio:GetVoiceLength("story_v_out_108071", "108071018", "story_v_out_108071.awb") / 1000

					if var_75_5 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + 0
					end

					if var_75_1.prefab_name ~= "" and arg_72_1.actors_[var_75_1.prefab_name] ~= nil then
						local var_75_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_1.prefab_name].transform, "story_v_out_108071", "108071018", "story_v_out_108071.awb")

						arg_72_1:RecordAudio("108071018", var_75_6)
						arg_72_1:RecordAudio("108071018", var_75_6)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_108071", "108071018", "story_v_out_108071.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_108071", "108071018", "story_v_out_108071.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_7 = math.max(var_75_0, arg_72_1.talkMaxDuration)

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_7 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - 0) / var_75_7

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= 0 + var_75_7 and arg_72_1.time_ < 0 + var_75_7 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play108071019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 108071019
		arg_76_1.duration_ = 10.93

		local var_76_0 = {
			ja = 5.833,
			ko = 9,
			zh = 10.933,
			en = 9.133
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
				arg_76_0:Play108071020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0.8

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_1 = arg_76_1:GetWordFromCfg(108071019)
				local var_79_2 = arg_76_1:FormatText(var_79_1.content)

				arg_76_1.text_.text = var_79_2

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_4 = 32 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 32)

				if (32 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 32)) > 0 and var_79_0 < var_79_4 then
					arg_76_1.talkMaxDuration = var_79_4

					if var_79_4 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_4 + 0
					end
				end

				arg_76_1.text_.text = var_79_2
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071019", "story_v_out_108071.awb") ~= 0 then
					local var_79_5 = manager.audio:GetVoiceLength("story_v_out_108071", "108071019", "story_v_out_108071.awb") / 1000

					if var_79_5 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + 0
					end

					if var_79_1.prefab_name ~= "" and arg_76_1.actors_[var_79_1.prefab_name] ~= nil then
						local var_79_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_1.prefab_name].transform, "story_v_out_108071", "108071019", "story_v_out_108071.awb")

						arg_76_1:RecordAudio("108071019", var_79_6)
						arg_76_1:RecordAudio("108071019", var_79_6)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_108071", "108071019", "story_v_out_108071.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_108071", "108071019", "story_v_out_108071.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_7 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_7

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play108071020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 108071020
		arg_80_1.duration_ = 21.47

		local var_80_0 = {
			ja = 21.466,
			ko = 13.233,
			zh = 16.4,
			en = 16.466
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play108071021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 1.05

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_1 = arg_80_1:GetWordFromCfg(108071020)
				local var_83_2 = arg_80_1:FormatText(var_83_1.content)

				arg_80_1.text_.text = var_83_2

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_4 = 42 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 42)

				if (42 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 42)) > 0 and var_83_0 < var_83_4 then
					arg_80_1.talkMaxDuration = var_83_4

					if var_83_4 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_4 + 0
					end
				end

				arg_80_1.text_.text = var_83_2
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071020", "story_v_out_108071.awb") ~= 0 then
					local var_83_5 = manager.audio:GetVoiceLength("story_v_out_108071", "108071020", "story_v_out_108071.awb") / 1000

					if var_83_5 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + 0
					end

					if var_83_1.prefab_name ~= "" and arg_80_1.actors_[var_83_1.prefab_name] ~= nil then
						local var_83_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_1.prefab_name].transform, "story_v_out_108071", "108071020", "story_v_out_108071.awb")

						arg_80_1:RecordAudio("108071020", var_83_6)
						arg_80_1:RecordAudio("108071020", var_83_6)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_108071", "108071020", "story_v_out_108071.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_108071", "108071020", "story_v_out_108071.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_7 = math.max(var_83_0, arg_80_1.talkMaxDuration)

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_7 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - 0) / var_83_7

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= 0 + var_83_7 and arg_80_1.time_ < 0 + var_83_7 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play108071021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 108071021
		arg_84_1.duration_ = 15.97

		local var_84_0 = {
			ja = 3.4,
			ko = 6.7,
			zh = 8.533,
			en = 15.966
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
				arg_84_0:Play108071022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.775

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_1 = arg_84_1:GetWordFromCfg(108071021)
				local var_87_2 = arg_84_1:FormatText(var_87_1.content)

				arg_84_1.text_.text = var_87_2

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_4 = 31 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 31)

				if (31 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 31)) > 0 and var_87_0 < var_87_4 then
					arg_84_1.talkMaxDuration = var_87_4

					if var_87_4 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_4 + 0
					end
				end

				arg_84_1.text_.text = var_87_2
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071021", "story_v_out_108071.awb") ~= 0 then
					local var_87_5 = manager.audio:GetVoiceLength("story_v_out_108071", "108071021", "story_v_out_108071.awb") / 1000

					if var_87_5 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + 0
					end

					if var_87_1.prefab_name ~= "" and arg_84_1.actors_[var_87_1.prefab_name] ~= nil then
						local var_87_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_1.prefab_name].transform, "story_v_out_108071", "108071021", "story_v_out_108071.awb")

						arg_84_1:RecordAudio("108071021", var_87_6)
						arg_84_1:RecordAudio("108071021", var_87_6)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_108071", "108071021", "story_v_out_108071.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_108071", "108071021", "story_v_out_108071.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_7 = math.max(var_87_0, arg_84_1.talkMaxDuration)

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_7 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - 0) / var_87_7

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= 0 + var_87_7 and arg_84_1.time_ < 0 + var_87_7 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play108071022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 108071022
		arg_88_1.duration_ = 21.4

		local var_88_0 = {
			ja = 21.4,
			ko = 14.6,
			zh = 17.066,
			en = 13.666
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
				arg_88_0:Play108071023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 1.25

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_1 = arg_88_1:GetWordFromCfg(108071022)
				local var_91_2 = arg_88_1:FormatText(var_91_1.content)

				arg_88_1.text_.text = var_91_2

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_4 = 50 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_2) / 50)

				if (50 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_2) / 50)) > 0 and var_91_0 < var_91_4 then
					arg_88_1.talkMaxDuration = var_91_4

					if var_91_4 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_4 + 0
					end
				end

				arg_88_1.text_.text = var_91_2
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071022", "story_v_out_108071.awb") ~= 0 then
					local var_91_5 = manager.audio:GetVoiceLength("story_v_out_108071", "108071022", "story_v_out_108071.awb") / 1000

					if var_91_5 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_5 + 0
					end

					if var_91_1.prefab_name ~= "" and arg_88_1.actors_[var_91_1.prefab_name] ~= nil then
						local var_91_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_1.prefab_name].transform, "story_v_out_108071", "108071022", "story_v_out_108071.awb")

						arg_88_1:RecordAudio("108071022", var_91_6)
						arg_88_1:RecordAudio("108071022", var_91_6)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_108071", "108071022", "story_v_out_108071.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_108071", "108071022", "story_v_out_108071.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_7 = math.max(var_91_0, arg_88_1.talkMaxDuration)

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_7 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - 0) / var_91_7

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= 0 + var_91_7 and arg_88_1.time_ < 0 + var_91_7 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play108071023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 108071023
		arg_92_1.duration_ = 3.7

		local var_92_0 = {
			ja = 3.366,
			ko = 3.6,
			zh = 3.7,
			en = 2.4
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
				arg_92_0:Play108071024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos3014_tpose = arg_92_1.actors_["3014_tpose"].transform.localPosition

				local var_95_0 = GameObjectTools.GetOrAddComponent(arg_92_1.actors_["3014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_95_0 then
					var_95_0:EnableDynamicBone(false)
				end
			end

			local var_95_1 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_1 then
				arg_92_1.actors_["3014_tpose"].transform.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos3014_tpose, Vector3.New(0, 100, 0), (arg_92_1.time_ - 0) / var_95_1)
				arg_92_1.actors_["3014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["3014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["3014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["3014_tpose"].transform.position).z)
				arg_92_1.actors_["3014_tpose"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["3014_tpose"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["3014_tpose"].transform.localEulerAngles = arg_92_1.actors_["3014_tpose"].transform.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_1 and arg_92_1.time_ < 0 + var_95_1 + arg_95_0 then
				arg_92_1.actors_["3014_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.actors_["3014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["3014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["3014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["3014_tpose"].transform.position).z)
				arg_92_1.actors_["3014_tpose"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["3014_tpose"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["3014_tpose"].transform.localEulerAngles = arg_92_1.actors_["3014_tpose"].transform.localEulerAngles

				local var_95_2 = GameObjectTools.GetOrAddComponent(arg_92_1.actors_["3014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_95_2 then
					var_95_2:EnableDynamicBone(true)
				end
			end

			local var_95_3 = arg_92_1.actors_["1050ui_story"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1050ui_story = var_95_3.localPosition
			end

			local var_95_4 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_4 then
				var_95_3.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_92_1.time_ - 0) / var_95_4)
				var_95_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_3.position).x, (manager.ui.mainCamera.transform.position - var_95_3.position).y, (manager.ui.mainCamera.transform.position - var_95_3.position).z)
				var_95_3.localEulerAngles.z = 0
				var_95_3.localEulerAngles.x = 0
				var_95_3.localEulerAngles = var_95_3.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_4 and arg_92_1.time_ < 0 + var_95_4 + arg_95_0 then
				var_95_3.localPosition = Vector3.New(0, -1, -6.1)
				var_95_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_3.position).x, (manager.ui.mainCamera.transform.position - var_95_3.position).y, (manager.ui.mainCamera.transform.position - var_95_3.position).z)
				var_95_3.localEulerAngles.z = 0
				var_95_3.localEulerAngles.x = 0
				var_95_3.localEulerAngles = var_95_3.localEulerAngles
			end

			local var_95_5 = arg_92_1.actors_["1050ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_5) and arg_92_1.var_.characterEffect1050ui_story == nil then
				arg_92_1.var_.characterEffect1050ui_story = var_95_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_6 = 0.2

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_6 and not isNil(var_95_5) then
				if arg_92_1.var_.characterEffect1050ui_story and not isNil(var_95_5) then
					arg_92_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_6 and arg_92_1.time_ < 0 + var_95_6 + arg_95_0 and not isNil(var_95_5) and arg_92_1.var_.characterEffect1050ui_story then
				arg_92_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_95_8 = 0
			local var_95_9 = 0.375

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_8 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_10 = arg_92_1:GetWordFromCfg(108071023)
				local var_95_11 = arg_92_1:FormatText(var_95_10.content)

				arg_92_1.text_.text = var_95_11

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_13 = 15 <= 0 and var_95_9 or var_95_9 * (utf8.len(var_95_11) / 15)

				if (15 <= 0 and var_95_9 or var_95_9 * (utf8.len(var_95_11) / 15)) > 0 and var_95_9 < var_95_13 then
					arg_92_1.talkMaxDuration = var_95_13

					if var_95_13 + var_95_8 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_8
					end
				end

				arg_92_1.text_.text = var_95_11
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071023", "story_v_out_108071.awb") ~= 0 then
					local var_95_14 = manager.audio:GetVoiceLength("story_v_out_108071", "108071023", "story_v_out_108071.awb") / 1000

					if var_95_14 + var_95_8 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_14 + var_95_8
					end

					if var_95_10.prefab_name ~= "" and arg_92_1.actors_[var_95_10.prefab_name] ~= nil then
						local var_95_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_10.prefab_name].transform, "story_v_out_108071", "108071023", "story_v_out_108071.awb")

						arg_92_1:RecordAudio("108071023", var_95_15)
						arg_92_1:RecordAudio("108071023", var_95_15)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_108071", "108071023", "story_v_out_108071.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_108071", "108071023", "story_v_out_108071.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_16 = math.max(var_95_9, arg_92_1.talkMaxDuration)

			if var_95_8 <= arg_92_1.time_ and arg_92_1.time_ < var_95_8 + var_95_16 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_8) / var_95_16

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_8 + var_95_16 and arg_92_1.time_ < var_95_8 + var_95_16 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play108071024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 108071024
		arg_96_1.duration_ = 9.9

		local var_96_0 = {
			ja = 9.9,
			ko = 9.5,
			zh = 9.9,
			en = 7.933
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
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play108071025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1050ui_story = arg_96_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_99_0 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 then
				arg_96_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_96_1.time_ - 0) / var_99_0)
				arg_96_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1050ui_story"].transform.position).z)
				arg_96_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["1050ui_story"].transform.localEulerAngles = arg_96_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 then
				arg_96_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_96_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1050ui_story"].transform.position).z)
				arg_96_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["1050ui_story"].transform.localEulerAngles = arg_96_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_99_1 = arg_96_1.actors_["3014_tpose"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos3014_tpose = var_99_1.localPosition

				local var_99_2 = GameObjectTools.GetOrAddComponent(var_99_1.gameObject, typeof(DynamicBoneHelper))

				if var_99_2 then
					var_99_2:EnableDynamicBone(false)
				end
			end

			local var_99_3 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_3 then
				var_99_1.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos3014_tpose, Vector3.New(0, -2.35, -2.9), (arg_96_1.time_ - 0) / var_99_3)
				var_99_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_1.position).x, (manager.ui.mainCamera.transform.position - var_99_1.position).y, (manager.ui.mainCamera.transform.position - var_99_1.position).z)
				var_99_1.localEulerAngles.z = 0
				var_99_1.localEulerAngles.x = 0
				var_99_1.localEulerAngles = var_99_1.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_3 and arg_96_1.time_ < 0 + var_99_3 + arg_99_0 then
				var_99_1.localPosition = Vector3.New(0, -2.35, -2.9)
				var_99_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_1.position).x, (manager.ui.mainCamera.transform.position - var_99_1.position).y, (manager.ui.mainCamera.transform.position - var_99_1.position).z)
				var_99_1.localEulerAngles.z = 0
				var_99_1.localEulerAngles.x = 0
				var_99_1.localEulerAngles = var_99_1.localEulerAngles

				local var_99_4 = GameObjectTools.GetOrAddComponent(var_99_1.gameObject, typeof(DynamicBoneHelper))

				if var_99_4 then
					var_99_4:EnableDynamicBone(true)
				end
			end

			local var_99_5 = arg_96_1.actors_["3014_tpose"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_5) and arg_96_1.var_.characterEffect3014_tpose == nil then
				arg_96_1.var_.characterEffect3014_tpose = var_99_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_6 = 0.2

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_6 and not isNil(var_99_5) then
				if arg_96_1.var_.characterEffect3014_tpose and not isNil(var_99_5) then
					arg_96_1.var_.characterEffect3014_tpose.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_6 and arg_96_1.time_ < 0 + var_99_6 + arg_99_0 and not isNil(var_99_5) and arg_96_1.var_.characterEffect3014_tpose then
				arg_96_1.var_.characterEffect3014_tpose.fillFlat = false
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("3014_tpose", "StoryTimeline/CharAction/story3014/story3014action/3014action1_1")
			end

			local var_99_8 = 0
			local var_99_9 = 0.675

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_8 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_10 = arg_96_1:GetWordFromCfg(108071024)
				local var_99_11 = arg_96_1:FormatText(var_99_10.content)

				arg_96_1.text_.text = var_99_11

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_13 = 27 <= 0 and var_99_9 or var_99_9 * (utf8.len(var_99_11) / 27)

				if (27 <= 0 and var_99_9 or var_99_9 * (utf8.len(var_99_11) / 27)) > 0 and var_99_9 < var_99_13 then
					arg_96_1.talkMaxDuration = var_99_13

					if var_99_13 + var_99_8 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_13 + var_99_8
					end
				end

				arg_96_1.text_.text = var_99_11
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071024", "story_v_out_108071.awb") ~= 0 then
					local var_99_14 = manager.audio:GetVoiceLength("story_v_out_108071", "108071024", "story_v_out_108071.awb") / 1000

					if var_99_14 + var_99_8 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_14 + var_99_8
					end

					if var_99_10.prefab_name ~= "" and arg_96_1.actors_[var_99_10.prefab_name] ~= nil then
						local var_99_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_10.prefab_name].transform, "story_v_out_108071", "108071024", "story_v_out_108071.awb")

						arg_96_1:RecordAudio("108071024", var_99_15)
						arg_96_1:RecordAudio("108071024", var_99_15)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_108071", "108071024", "story_v_out_108071.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_108071", "108071024", "story_v_out_108071.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_16 = math.max(var_99_9, arg_96_1.talkMaxDuration)

			if var_99_8 <= arg_96_1.time_ and arg_96_1.time_ < var_99_8 + var_99_16 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_8) / var_99_16

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_8 + var_99_16 and arg_96_1.time_ < var_99_8 + var_99_16 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play108071025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 108071025
		arg_100_1.duration_ = 2

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play108071026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos3014_tpose = arg_100_1.actors_["3014_tpose"].transform.localPosition

				local var_103_0 = GameObjectTools.GetOrAddComponent(arg_100_1.actors_["3014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_103_0 then
					var_103_0:EnableDynamicBone(false)
				end
			end

			local var_103_1 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_1 then
				arg_100_1.actors_["3014_tpose"].transform.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos3014_tpose, Vector3.New(0, 100, 0), (arg_100_1.time_ - 0) / var_103_1)
				arg_100_1.actors_["3014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["3014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["3014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["3014_tpose"].transform.position).z)
				arg_100_1.actors_["3014_tpose"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["3014_tpose"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["3014_tpose"].transform.localEulerAngles = arg_100_1.actors_["3014_tpose"].transform.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_1 and arg_100_1.time_ < 0 + var_103_1 + arg_103_0 then
				arg_100_1.actors_["3014_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_100_1.actors_["3014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["3014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["3014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["3014_tpose"].transform.position).z)
				arg_100_1.actors_["3014_tpose"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["3014_tpose"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["3014_tpose"].transform.localEulerAngles = arg_100_1.actors_["3014_tpose"].transform.localEulerAngles

				local var_103_2 = GameObjectTools.GetOrAddComponent(arg_100_1.actors_["3014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_103_2 then
					var_103_2:EnableDynamicBone(true)
				end
			end

			local var_103_3 = arg_100_1.actors_["1099ui_story"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1099ui_story = var_103_3.localPosition
			end

			local var_103_4 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_4 then
				var_103_3.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1099ui_story, Vector3.New(0, -1.08, -5.9), (arg_100_1.time_ - 0) / var_103_4)
				var_103_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_3.position).x, (manager.ui.mainCamera.transform.position - var_103_3.position).y, (manager.ui.mainCamera.transform.position - var_103_3.position).z)
				var_103_3.localEulerAngles.z = 0
				var_103_3.localEulerAngles.x = 0
				var_103_3.localEulerAngles = var_103_3.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_4 and arg_100_1.time_ < 0 + var_103_4 + arg_103_0 then
				var_103_3.localPosition = Vector3.New(0, -1.08, -5.9)
				var_103_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_3.position).x, (manager.ui.mainCamera.transform.position - var_103_3.position).y, (manager.ui.mainCamera.transform.position - var_103_3.position).z)
				var_103_3.localEulerAngles.z = 0
				var_103_3.localEulerAngles.x = 0
				var_103_3.localEulerAngles = var_103_3.localEulerAngles
			end

			local var_103_5 = arg_100_1.actors_["1099ui_story"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_5) and arg_100_1.var_.characterEffect1099ui_story == nil then
				arg_100_1.var_.characterEffect1099ui_story = var_103_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_6 = 0.2

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_6 and not isNil(var_103_5) then
				if arg_100_1.var_.characterEffect1099ui_story and not isNil(var_103_5) then
					arg_100_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_6 and arg_100_1.time_ < 0 + var_103_6 + arg_103_0 and not isNil(var_103_5) and arg_100_1.var_.characterEffect1099ui_story then
				arg_100_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_1")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_103_8 = 0
			local var_103_9 = 0.15

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_8 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_10 = arg_100_1:GetWordFromCfg(108071025)
				local var_103_11 = arg_100_1:FormatText(var_103_10.content)

				arg_100_1.text_.text = var_103_11

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_13 = 6 <= 0 and var_103_9 or var_103_9 * (utf8.len(var_103_11) / 6)

				if (6 <= 0 and var_103_9 or var_103_9 * (utf8.len(var_103_11) / 6)) > 0 and var_103_9 < var_103_13 then
					arg_100_1.talkMaxDuration = var_103_13

					if var_103_13 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_13 + var_103_8
					end
				end

				arg_100_1.text_.text = var_103_11
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071025", "story_v_out_108071.awb") ~= 0 then
					local var_103_14 = manager.audio:GetVoiceLength("story_v_out_108071", "108071025", "story_v_out_108071.awb") / 1000

					if var_103_14 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_14 + var_103_8
					end

					if var_103_10.prefab_name ~= "" and arg_100_1.actors_[var_103_10.prefab_name] ~= nil then
						local var_103_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_10.prefab_name].transform, "story_v_out_108071", "108071025", "story_v_out_108071.awb")

						arg_100_1:RecordAudio("108071025", var_103_15)
						arg_100_1:RecordAudio("108071025", var_103_15)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_108071", "108071025", "story_v_out_108071.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_108071", "108071025", "story_v_out_108071.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_16 = math.max(var_103_9, arg_100_1.talkMaxDuration)

			if var_103_8 <= arg_100_1.time_ and arg_100_1.time_ < var_103_8 + var_103_16 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_8) / var_103_16

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_8 + var_103_16 and arg_100_1.time_ < var_103_8 + var_103_16 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play108071026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 108071026
		arg_104_1.duration_ = 17.2

		local var_104_0 = {
			ja = 8.666,
			ko = 12.633,
			zh = 17.2,
			en = 14.1
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play108071027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1099ui_story = arg_104_1.actors_["1099ui_story"].transform.localPosition
			end

			local var_107_0 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 then
				arg_104_1.actors_["1099ui_story"].transform.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_104_1.time_ - 0) / var_107_0)
				arg_104_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1099ui_story"].transform.position).z)
				arg_104_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["1099ui_story"].transform.localEulerAngles = arg_104_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 then
				arg_104_1.actors_["1099ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_104_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1099ui_story"].transform.position).z)
				arg_104_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["1099ui_story"].transform.localEulerAngles = arg_104_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			local var_107_1 = arg_104_1.actors_["3014_tpose"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos3014_tpose = var_107_1.localPosition

				local var_107_2 = GameObjectTools.GetOrAddComponent(var_107_1.gameObject, typeof(DynamicBoneHelper))

				if var_107_2 then
					var_107_2:EnableDynamicBone(false)
				end
			end

			local var_107_3 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_3 then
				var_107_1.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos3014_tpose, Vector3.New(0, -2.35, -2.9), (arg_104_1.time_ - 0) / var_107_3)
				var_107_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_1.position).x, (manager.ui.mainCamera.transform.position - var_107_1.position).y, (manager.ui.mainCamera.transform.position - var_107_1.position).z)
				var_107_1.localEulerAngles.z = 0
				var_107_1.localEulerAngles.x = 0
				var_107_1.localEulerAngles = var_107_1.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_3 and arg_104_1.time_ < 0 + var_107_3 + arg_107_0 then
				var_107_1.localPosition = Vector3.New(0, -2.35, -2.9)
				var_107_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_1.position).x, (manager.ui.mainCamera.transform.position - var_107_1.position).y, (manager.ui.mainCamera.transform.position - var_107_1.position).z)
				var_107_1.localEulerAngles.z = 0
				var_107_1.localEulerAngles.x = 0
				var_107_1.localEulerAngles = var_107_1.localEulerAngles

				local var_107_4 = GameObjectTools.GetOrAddComponent(var_107_1.gameObject, typeof(DynamicBoneHelper))

				if var_107_4 then
					var_107_4:EnableDynamicBone(true)
				end
			end

			local var_107_5 = arg_104_1.actors_["3014_tpose"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_5) and arg_104_1.var_.characterEffect3014_tpose == nil then
				arg_104_1.var_.characterEffect3014_tpose = var_107_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_6 = 0.2

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_6 and not isNil(var_107_5) then
				if arg_104_1.var_.characterEffect3014_tpose and not isNil(var_107_5) then
					arg_104_1.var_.characterEffect3014_tpose.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_6 and arg_104_1.time_ < 0 + var_107_6 + arg_107_0 and not isNil(var_107_5) and arg_104_1.var_.characterEffect3014_tpose then
				arg_104_1.var_.characterEffect3014_tpose.fillFlat = false
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("3014_tpose", "StoryTimeline/CharAction/story3014/story3014action/3014action1_1")
			end

			local var_107_8 = 0
			local var_107_9 = 1.175

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_8 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_10 = arg_104_1:GetWordFromCfg(108071026)
				local var_107_11 = arg_104_1:FormatText(var_107_10.content)

				arg_104_1.text_.text = var_107_11

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_13 = 47 <= 0 and var_107_9 or var_107_9 * (utf8.len(var_107_11) / 47)

				if (47 <= 0 and var_107_9 or var_107_9 * (utf8.len(var_107_11) / 47)) > 0 and var_107_9 < var_107_13 then
					arg_104_1.talkMaxDuration = var_107_13

					if var_107_13 + var_107_8 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_13 + var_107_8
					end
				end

				arg_104_1.text_.text = var_107_11
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071026", "story_v_out_108071.awb") ~= 0 then
					local var_107_14 = manager.audio:GetVoiceLength("story_v_out_108071", "108071026", "story_v_out_108071.awb") / 1000

					if var_107_14 + var_107_8 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_14 + var_107_8
					end

					if var_107_10.prefab_name ~= "" and arg_104_1.actors_[var_107_10.prefab_name] ~= nil then
						local var_107_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_10.prefab_name].transform, "story_v_out_108071", "108071026", "story_v_out_108071.awb")

						arg_104_1:RecordAudio("108071026", var_107_15)
						arg_104_1:RecordAudio("108071026", var_107_15)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_108071", "108071026", "story_v_out_108071.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_108071", "108071026", "story_v_out_108071.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_16 = math.max(var_107_9, arg_104_1.talkMaxDuration)

			if var_107_8 <= arg_104_1.time_ and arg_104_1.time_ < var_107_8 + var_107_16 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_8) / var_107_16

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_8 + var_107_16 and arg_104_1.time_ < var_107_8 + var_107_16 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play108071027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 108071027
		arg_108_1.duration_ = 11.67

		local var_108_0 = {
			ja = 11.666,
			ko = 4.1,
			zh = 5.166,
			en = 8.066
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play108071028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0.35

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_1 = arg_108_1:GetWordFromCfg(108071027)
				local var_111_2 = arg_108_1:FormatText(var_111_1.content)

				arg_108_1.text_.text = var_111_2

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_4 = 14 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_2) / 14)

				if (14 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_2) / 14)) > 0 and var_111_0 < var_111_4 then
					arg_108_1.talkMaxDuration = var_111_4

					if var_111_4 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_4 + 0
					end
				end

				arg_108_1.text_.text = var_111_2
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071027", "story_v_out_108071.awb") ~= 0 then
					local var_111_5 = manager.audio:GetVoiceLength("story_v_out_108071", "108071027", "story_v_out_108071.awb") / 1000

					if var_111_5 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + 0
					end

					if var_111_1.prefab_name ~= "" and arg_108_1.actors_[var_111_1.prefab_name] ~= nil then
						local var_111_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_1.prefab_name].transform, "story_v_out_108071", "108071027", "story_v_out_108071.awb")

						arg_108_1:RecordAudio("108071027", var_111_6)
						arg_108_1:RecordAudio("108071027", var_111_6)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_108071", "108071027", "story_v_out_108071.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_108071", "108071027", "story_v_out_108071.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_7 = math.max(var_111_0, arg_108_1.talkMaxDuration)

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_7 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - 0) / var_111_7

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= 0 + var_111_7 and arg_108_1.time_ < 0 + var_111_7 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play108071028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 108071028
		arg_112_1.duration_ = 6.97

		local var_112_0 = {
			ja = 6.966,
			ko = 3.466,
			zh = 3.566,
			en = 1.366
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
			arg_112_1.auto_ = false
		end

		function arg_112_1.playNext_(arg_114_0)
			arg_112_1.onStoryFinished_()
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0.15

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_1 = arg_112_1:GetWordFromCfg(108071028)
				local var_115_2 = arg_112_1:FormatText(var_115_1.content)

				arg_112_1.text_.text = var_115_2

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_4 = 6 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_2) / 6)

				if (6 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_2) / 6)) > 0 and var_115_0 < var_115_4 then
					arg_112_1.talkMaxDuration = var_115_4

					if var_115_4 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_4 + 0
					end
				end

				arg_112_1.text_.text = var_115_2
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071028", "story_v_out_108071.awb") ~= 0 then
					local var_115_5 = manager.audio:GetVoiceLength("story_v_out_108071", "108071028", "story_v_out_108071.awb") / 1000

					if var_115_5 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_5 + 0
					end

					if var_115_1.prefab_name ~= "" and arg_112_1.actors_[var_115_1.prefab_name] ~= nil then
						local var_115_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_1.prefab_name].transform, "story_v_out_108071", "108071028", "story_v_out_108071.awb")

						arg_112_1:RecordAudio("108071028", var_115_6)
						arg_112_1:RecordAudio("108071028", var_115_6)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_108071", "108071028", "story_v_out_108071.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_108071", "108071028", "story_v_out_108071.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_7 = math.max(var_115_0, arg_112_1.talkMaxDuration)

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_7 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - 0) / var_115_7

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= 0 + var_115_7 and arg_112_1.time_ < 0 + var_115_7 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C07_1"
	},
	voices = {
		"story_v_out_108071.awb"
	}
}
