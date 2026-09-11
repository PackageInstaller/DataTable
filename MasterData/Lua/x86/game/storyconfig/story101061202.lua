return {
	Play106122001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 106122001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play106122002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.C01b == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "C01b")
				var_4_0.name = "C01b"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.C01b = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.C01b

				arg_1_1.bgs_.C01b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "C01b" then
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
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_10 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

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

			local var_4_11 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_11 + 2 and arg_1_1.time_ < var_4_11 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_12 = 2
			local var_4_13 = 1.225

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_14 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_14:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_15 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(106122001).content)

				arg_1_1.text_.text = var_4_15

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_17 = 49 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_15) / 49)

				if (49 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_15) / 49)) > 0 and var_4_13 < var_4_17 then
					arg_1_1.talkMaxDuration = var_4_17
					var_4_12 = var_4_12 + 0.3

					if var_4_17 + var_4_12 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_17 + var_4_12
					end
				end

				arg_1_1.text_.text = var_4_15
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_18 = var_4_12 + 0.3
			local var_4_19 = math.max(var_4_13, arg_1_1.talkMaxDuration)

			if var_4_12 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_18) / var_4_19

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play106122002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 106122002
		arg_8_1.duration_ = 6.93

		local var_8_0 = {
			ja = 4.333,
			ko = 5.6,
			zh = 4.833,
			en = 6.933
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play106122003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["4014_tpose"] == nil and not isNil((Asset.Load("Char/" .. "4014_tpose"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "4014_tpose"), arg_8_1.stage_.transform)

				var_11_0.name = "4014_tpose"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["4014_tpose"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["4014_tpose" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["4014_tpose" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["4014_tpose" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["4014_tpose"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect4014_tpose == nil then
				arg_8_1.var_.characterEffect4014_tpose = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect4014_tpose and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect4014_tpose then
				arg_8_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_11_6 = arg_8_1.actors_["4014_tpose"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos4014_tpose = var_11_6.localPosition

				local var_11_7 = GameObjectTools.GetOrAddComponent(var_11_6.gameObject, typeof(DynamicBoneHelper))

				if var_11_7 then
					var_11_7:EnableDynamicBone(false)
				end
			end

			local var_11_8 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_8 then
				var_11_6.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_8_1.time_ - 0) / var_11_8)
				var_11_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_6.position).x, (manager.ui.mainCamera.transform.position - var_11_6.position).y, (manager.ui.mainCamera.transform.position - var_11_6.position).z)
				var_11_6.localEulerAngles.z = 0
				var_11_6.localEulerAngles.x = 0
				var_11_6.localEulerAngles = var_11_6.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_8 and arg_8_1.time_ < 0 + var_11_8 + arg_11_0 then
				var_11_6.localPosition = Vector3.New(0, -1.95, -4.2)
				var_11_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_6.position).x, (manager.ui.mainCamera.transform.position - var_11_6.position).y, (manager.ui.mainCamera.transform.position - var_11_6.position).z)
				var_11_6.localEulerAngles.z = 0
				var_11_6.localEulerAngles.x = 0
				var_11_6.localEulerAngles = var_11_6.localEulerAngles

				local var_11_9 = GameObjectTools.GetOrAddComponent(var_11_6.gameObject, typeof(DynamicBoneHelper))

				if var_11_9 then
					var_11_9:EnableDynamicBone(true)
				end
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_11_10 = 0
			local var_11_11 = 0.575

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_12 = arg_8_1:GetWordFromCfg(106122002)
				local var_11_13 = arg_8_1:FormatText(var_11_12.content)

				arg_8_1.text_.text = var_11_13

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_15 = 23 <= 0 and var_11_11 or var_11_11 * (utf8.len(var_11_13) / 23)

				if (23 <= 0 and var_11_11 or var_11_11 * (utf8.len(var_11_13) / 23)) > 0 and var_11_11 < var_11_15 then
					arg_8_1.talkMaxDuration = var_11_15

					if var_11_15 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_15 + var_11_10
					end
				end

				arg_8_1.text_.text = var_11_13
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122002", "story_v_out_106122.awb") ~= 0 then
					local var_11_16 = manager.audio:GetVoiceLength("story_v_out_106122", "106122002", "story_v_out_106122.awb") / 1000

					if var_11_16 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_16 + var_11_10
					end

					if var_11_12.prefab_name ~= "" and arg_8_1.actors_[var_11_12.prefab_name] ~= nil then
						local var_11_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_12.prefab_name].transform, "story_v_out_106122", "106122002", "story_v_out_106122.awb")

						arg_8_1:RecordAudio("106122002", var_11_17)
						arg_8_1:RecordAudio("106122002", var_11_17)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_106122", "106122002", "story_v_out_106122.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_106122", "106122002", "story_v_out_106122.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_18 = math.max(var_11_11, arg_8_1.talkMaxDuration)

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_18 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_10) / var_11_18

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_10 + var_11_18 and arg_8_1.time_ < var_11_10 + var_11_18 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play106122003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 106122003
		arg_12_1.duration_ = 11

		local var_12_0 = {
			ja = 9.733,
			ko = 11,
			zh = 7.3,
			en = 10.066
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
				arg_12_0:Play106122004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.775

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:GetWordFromCfg(106122003)
				local var_15_2 = arg_12_1:FormatText(var_15_1.content)

				arg_12_1.text_.text = var_15_2

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 31 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 31)

				if (31 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 31)) > 0 and var_15_0 < var_15_4 then
					arg_12_1.talkMaxDuration = var_15_4

					if var_15_4 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_4 + 0
					end
				end

				arg_12_1.text_.text = var_15_2
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122003", "story_v_out_106122.awb") ~= 0 then
					local var_15_5 = manager.audio:GetVoiceLength("story_v_out_106122", "106122003", "story_v_out_106122.awb") / 1000

					if var_15_5 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + 0
					end

					if var_15_1.prefab_name ~= "" and arg_12_1.actors_[var_15_1.prefab_name] ~= nil then
						local var_15_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_1.prefab_name].transform, "story_v_out_106122", "106122003", "story_v_out_106122.awb")

						arg_12_1:RecordAudio("106122003", var_15_6)
						arg_12_1:RecordAudio("106122003", var_15_6)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_106122", "106122003", "story_v_out_106122.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_106122", "106122003", "story_v_out_106122.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play106122004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 106122004
		arg_16_1.duration_ = 5.8

		local var_16_0 = {
			ja = 5.8,
			ko = 5.2,
			zh = 5.133,
			en = 3.7
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
				arg_16_0:Play106122005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "1093ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1093ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["1093ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["1093ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["1093ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["1093ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1093ui_story == nil then
				arg_16_1.var_.characterEffect1093ui_story = var_19_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_4 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 and not isNil(var_19_3) then
				if arg_16_1.var_.characterEffect1093ui_story and not isNil(var_19_3) then
					arg_16_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1093ui_story then
				arg_16_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_19_6 = arg_16_1.actors_["4014_tpose"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_6) and arg_16_1.var_.characterEffect4014_tpose == nil then
				arg_16_1.var_.characterEffect4014_tpose = var_19_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_7 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 and not isNil(var_19_6) then
				if arg_16_1.var_.characterEffect4014_tpose and not isNil(var_19_6) then
					arg_16_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_16_1.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_7)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 and not isNil(var_19_6) and arg_16_1.var_.characterEffect4014_tpose then
				arg_16_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_16_1.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			local var_19_8 = arg_16_1.actors_["4014_tpose"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos4014_tpose = var_19_8.localPosition

				local var_19_9 = GameObjectTools.GetOrAddComponent(var_19_8.gameObject, typeof(DynamicBoneHelper))

				if var_19_9 then
					var_19_9:EnableDynamicBone(false)
				end
			end

			local var_19_10 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_10 then
				var_19_8.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_10)
				var_19_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_8.position).x, (manager.ui.mainCamera.transform.position - var_19_8.position).y, (manager.ui.mainCamera.transform.position - var_19_8.position).z)
				var_19_8.localEulerAngles.z = 0
				var_19_8.localEulerAngles.x = 0
				var_19_8.localEulerAngles = var_19_8.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_10 and arg_16_1.time_ < 0 + var_19_10 + arg_19_0 then
				var_19_8.localPosition = Vector3.New(0, 100, 0)
				var_19_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_8.position).x, (manager.ui.mainCamera.transform.position - var_19_8.position).y, (manager.ui.mainCamera.transform.position - var_19_8.position).z)
				var_19_8.localEulerAngles.z = 0
				var_19_8.localEulerAngles.x = 0
				var_19_8.localEulerAngles = var_19_8.localEulerAngles

				local var_19_11 = GameObjectTools.GetOrAddComponent(var_19_8.gameObject, typeof(DynamicBoneHelper))

				if var_19_11 then
					var_19_11:EnableDynamicBone(true)
				end
			end

			local var_19_12 = arg_16_1.actors_["1093ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1093ui_story = var_19_12.localPosition

				arg_16_1:ShowWeapon(arg_16_1.var_["1093ui_story" .. "Animator"].transform, true)
			end

			local var_19_13 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_13 then
				var_19_12.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_16_1.time_ - 0) / var_19_13)
				var_19_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_12.position).x, (manager.ui.mainCamera.transform.position - var_19_12.position).y, (manager.ui.mainCamera.transform.position - var_19_12.position).z)
				var_19_12.localEulerAngles.z = 0
				var_19_12.localEulerAngles.x = 0
				var_19_12.localEulerAngles = var_19_12.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_13 and arg_16_1.time_ < 0 + var_19_13 + arg_19_0 then
				var_19_12.localPosition = Vector3.New(0, -1.11, -5.88)
				var_19_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_12.position).x, (manager.ui.mainCamera.transform.position - var_19_12.position).y, (manager.ui.mainCamera.transform.position - var_19_12.position).z)
				var_19_12.localEulerAngles.z = 0
				var_19_12.localEulerAngles.x = 0
				var_19_12.localEulerAngles = var_19_12.localEulerAngles
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action10_2")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_19_14 = 0
			local var_19_15 = 0.45

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_14 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_16 = arg_16_1:GetWordFromCfg(106122004)
				local var_19_17 = arg_16_1:FormatText(var_19_16.content)

				arg_16_1.text_.text = var_19_17

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_19 = 17 <= 0 and var_19_15 or var_19_15 * (utf8.len(var_19_17) / 17)

				if (17 <= 0 and var_19_15 or var_19_15 * (utf8.len(var_19_17) / 17)) > 0 and var_19_15 < var_19_19 then
					arg_16_1.talkMaxDuration = var_19_19

					if var_19_19 + var_19_14 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_19 + var_19_14
					end
				end

				arg_16_1.text_.text = var_19_17
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122004", "story_v_out_106122.awb") ~= 0 then
					local var_19_20 = manager.audio:GetVoiceLength("story_v_out_106122", "106122004", "story_v_out_106122.awb") / 1000

					if var_19_20 + var_19_14 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_20 + var_19_14
					end

					if var_19_16.prefab_name ~= "" and arg_16_1.actors_[var_19_16.prefab_name] ~= nil then
						local var_19_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_16.prefab_name].transform, "story_v_out_106122", "106122004", "story_v_out_106122.awb")

						arg_16_1:RecordAudio("106122004", var_19_21)
						arg_16_1:RecordAudio("106122004", var_19_21)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_106122", "106122004", "story_v_out_106122.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_106122", "106122004", "story_v_out_106122.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_22 = math.max(var_19_15, arg_16_1.talkMaxDuration)

			if var_19_14 <= arg_16_1.time_ and arg_16_1.time_ < var_19_14 + var_19_22 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_14) / var_19_22

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_14 + var_19_22 and arg_16_1.time_ < var_19_14 + var_19_22 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play106122005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 106122005
		arg_20_1.duration_ = 4.43

		local var_20_0 = {
			ja = 2.3,
			ko = 1.999999999999,
			zh = 2.866,
			en = 4.433
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
				arg_20_0:Play106122006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["4014_tpose"]) and arg_20_1.var_.characterEffect4014_tpose == nil then
				arg_20_1.var_.characterEffect4014_tpose = arg_20_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["4014_tpose"]) then
				if arg_20_1.var_.characterEffect4014_tpose and not isNil(arg_20_1.actors_["4014_tpose"]) then
					arg_20_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["4014_tpose"]) and arg_20_1.var_.characterEffect4014_tpose then
				arg_20_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_23_2 = arg_20_1.actors_["1093ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect1093ui_story == nil then
				arg_20_1.var_.characterEffect1093ui_story = var_23_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_3 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_3 and not isNil(var_23_2) then
				if arg_20_1.var_.characterEffect1093ui_story and not isNil(var_23_2) then
					arg_20_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_3)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_3 and arg_20_1.time_ < 0 + var_23_3 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect1093ui_story then
				arg_20_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_23_4 = arg_20_1.actors_["1093ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1093ui_story = var_23_4.localPosition
			end

			local var_23_5 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_5 then
				var_23_4.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_20_1.time_ - 0) / var_23_5)
				var_23_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_4.position).x, (manager.ui.mainCamera.transform.position - var_23_4.position).y, (manager.ui.mainCamera.transform.position - var_23_4.position).z)
				var_23_4.localEulerAngles.z = 0
				var_23_4.localEulerAngles.x = 0
				var_23_4.localEulerAngles = var_23_4.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_5 and arg_20_1.time_ < 0 + var_23_5 + arg_23_0 then
				var_23_4.localPosition = Vector3.New(0, 100, 0)
				var_23_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_4.position).x, (manager.ui.mainCamera.transform.position - var_23_4.position).y, (manager.ui.mainCamera.transform.position - var_23_4.position).z)
				var_23_4.localEulerAngles.z = 0
				var_23_4.localEulerAngles.x = 0
				var_23_4.localEulerAngles = var_23_4.localEulerAngles
			end

			local var_23_6 = arg_20_1.actors_["4014_tpose"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos4014_tpose = var_23_6.localPosition

				local var_23_7 = GameObjectTools.GetOrAddComponent(var_23_6.gameObject, typeof(DynamicBoneHelper))

				if var_23_7 then
					var_23_7:EnableDynamicBone(false)
				end
			end

			local var_23_8 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_8 then
				var_23_6.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_20_1.time_ - 0) / var_23_8)
				var_23_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_6.position).x, (manager.ui.mainCamera.transform.position - var_23_6.position).y, (manager.ui.mainCamera.transform.position - var_23_6.position).z)
				var_23_6.localEulerAngles.z = 0
				var_23_6.localEulerAngles.x = 0
				var_23_6.localEulerAngles = var_23_6.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_8 and arg_20_1.time_ < 0 + var_23_8 + arg_23_0 then
				var_23_6.localPosition = Vector3.New(0, -1.95, -4.2)
				var_23_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_6.position).x, (manager.ui.mainCamera.transform.position - var_23_6.position).y, (manager.ui.mainCamera.transform.position - var_23_6.position).z)
				var_23_6.localEulerAngles.z = 0
				var_23_6.localEulerAngles.x = 0
				var_23_6.localEulerAngles = var_23_6.localEulerAngles

				local var_23_9 = GameObjectTools.GetOrAddComponent(var_23_6.gameObject, typeof(DynamicBoneHelper))

				if var_23_9 then
					var_23_9:EnableDynamicBone(true)
				end
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_23_10 = 0
			local var_23_11 = 0.225

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_12 = arg_20_1:GetWordFromCfg(106122005)
				local var_23_13 = arg_20_1:FormatText(var_23_12.content)

				arg_20_1.text_.text = var_23_13

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_15 = 9 <= 0 and var_23_11 or var_23_11 * (utf8.len(var_23_13) / 9)

				if (9 <= 0 and var_23_11 or var_23_11 * (utf8.len(var_23_13) / 9)) > 0 and var_23_11 < var_23_15 then
					arg_20_1.talkMaxDuration = var_23_15

					if var_23_15 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_15 + var_23_10
					end
				end

				arg_20_1.text_.text = var_23_13
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122005", "story_v_out_106122.awb") ~= 0 then
					local var_23_16 = manager.audio:GetVoiceLength("story_v_out_106122", "106122005", "story_v_out_106122.awb") / 1000

					if var_23_16 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_16 + var_23_10
					end

					if var_23_12.prefab_name ~= "" and arg_20_1.actors_[var_23_12.prefab_name] ~= nil then
						local var_23_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_12.prefab_name].transform, "story_v_out_106122", "106122005", "story_v_out_106122.awb")

						arg_20_1:RecordAudio("106122005", var_23_17)
						arg_20_1:RecordAudio("106122005", var_23_17)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_106122", "106122005", "story_v_out_106122.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_106122", "106122005", "story_v_out_106122.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_18 = math.max(var_23_11, arg_20_1.talkMaxDuration)

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_18 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_10) / var_23_18

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_10 + var_23_18 and arg_20_1.time_ < var_23_10 + var_23_18 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play106122006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 106122006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play106122007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["4014_tpose"]) and arg_24_1.var_.characterEffect4014_tpose == nil then
				arg_24_1.var_.characterEffect4014_tpose = arg_24_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["4014_tpose"]) then
				if arg_24_1.var_.characterEffect4014_tpose and not isNil(arg_24_1.actors_["4014_tpose"]) then
					arg_24_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_24_1.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_0)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["4014_tpose"]) and arg_24_1.var_.characterEffect4014_tpose then
				arg_24_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_24_1.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			local var_27_1 = 0
			local var_27_2 = 0.75

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_3 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(106122006).content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 30 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 30)

				if (30 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 30)) > 0 and var_27_2 < var_27_5 then
					arg_24_1.talkMaxDuration = var_27_5

					if var_27_5 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + var_27_1
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_6 = math.max(var_27_2, arg_24_1.talkMaxDuration)

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_6 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_1) / var_27_6

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_1 + var_27_6 and arg_24_1.time_ < var_27_1 + var_27_6 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play106122007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 106122007
		arg_28_1.duration_ = 4.37

		local var_28_0 = {
			ja = 4.366,
			ko = 4.366,
			zh = 3.633,
			en = 3.1
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
				arg_28_0:Play106122008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["4014_tpose"]) and arg_28_1.var_.characterEffect4014_tpose == nil then
				arg_28_1.var_.characterEffect4014_tpose = arg_28_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["4014_tpose"]) then
				if arg_28_1.var_.characterEffect4014_tpose and not isNil(arg_28_1.actors_["4014_tpose"]) then
					arg_28_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["4014_tpose"]) and arg_28_1.var_.characterEffect4014_tpose then
				arg_28_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_31_2 = arg_28_1.actors_["4014_tpose"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos4014_tpose = var_31_2.localPosition

				local var_31_3 = GameObjectTools.GetOrAddComponent(var_31_2.gameObject, typeof(DynamicBoneHelper))

				if var_31_3 then
					var_31_3:EnableDynamicBone(false)
				end
			end

			local var_31_4 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				var_31_2.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_28_1.time_ - 0) / var_31_4)
				var_31_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_2.position).x, (manager.ui.mainCamera.transform.position - var_31_2.position).y, (manager.ui.mainCamera.transform.position - var_31_2.position).z)
				var_31_2.localEulerAngles.z = 0
				var_31_2.localEulerAngles.x = 0
				var_31_2.localEulerAngles = var_31_2.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				var_31_2.localPosition = Vector3.New(0, -1.95, -4.2)
				var_31_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_2.position).x, (manager.ui.mainCamera.transform.position - var_31_2.position).y, (manager.ui.mainCamera.transform.position - var_31_2.position).z)
				var_31_2.localEulerAngles.z = 0
				var_31_2.localEulerAngles.x = 0
				var_31_2.localEulerAngles = var_31_2.localEulerAngles

				local var_31_5 = GameObjectTools.GetOrAddComponent(var_31_2.gameObject, typeof(DynamicBoneHelper))

				if var_31_5 then
					var_31_5:EnableDynamicBone(true)
				end
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_31_6 = 0
			local var_31_7 = 0.35

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_8 = arg_28_1:GetWordFromCfg(106122007)
				local var_31_9 = arg_28_1:FormatText(var_31_8.content)

				arg_28_1.text_.text = var_31_9

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_11 = 14 <= 0 and var_31_7 or var_31_7 * (utf8.len(var_31_9) / 14)

				if (14 <= 0 and var_31_7 or var_31_7 * (utf8.len(var_31_9) / 14)) > 0 and var_31_7 < var_31_11 then
					arg_28_1.talkMaxDuration = var_31_11

					if var_31_11 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_11 + var_31_6
					end
				end

				arg_28_1.text_.text = var_31_9
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122007", "story_v_out_106122.awb") ~= 0 then
					local var_31_12 = manager.audio:GetVoiceLength("story_v_out_106122", "106122007", "story_v_out_106122.awb") / 1000

					if var_31_12 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_12 + var_31_6
					end

					if var_31_8.prefab_name ~= "" and arg_28_1.actors_[var_31_8.prefab_name] ~= nil then
						local var_31_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_8.prefab_name].transform, "story_v_out_106122", "106122007", "story_v_out_106122.awb")

						arg_28_1:RecordAudio("106122007", var_31_13)
						arg_28_1:RecordAudio("106122007", var_31_13)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_106122", "106122007", "story_v_out_106122.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_106122", "106122007", "story_v_out_106122.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_14 = math.max(var_31_7, arg_28_1.talkMaxDuration)

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_14 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_6) / var_31_14

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_6 + var_31_14 and arg_28_1.time_ < var_31_6 + var_31_14 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play106122008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 106122008
		arg_32_1.duration_ = 3.2

		local var_32_0 = {
			ja = 2.866,
			ko = 1.6,
			zh = 1.9,
			en = 3.2
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
				arg_32_0:Play106122009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1093ui_story"]) and arg_32_1.var_.characterEffect1093ui_story == nil then
				arg_32_1.var_.characterEffect1093ui_story = arg_32_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1093ui_story"]) then
				if arg_32_1.var_.characterEffect1093ui_story and not isNil(arg_32_1.actors_["1093ui_story"]) then
					arg_32_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1093ui_story"]) and arg_32_1.var_.characterEffect1093ui_story then
				arg_32_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_35_2 = arg_32_1.actors_["4014_tpose"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect4014_tpose == nil then
				arg_32_1.var_.characterEffect4014_tpose = var_35_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_3 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 and not isNil(var_35_2) then
				if arg_32_1.var_.characterEffect4014_tpose and not isNil(var_35_2) then
					arg_32_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_32_1.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_3)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect4014_tpose then
				arg_32_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_32_1.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			local var_35_4 = arg_32_1.actors_["4014_tpose"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos4014_tpose = var_35_4.localPosition

				local var_35_5 = GameObjectTools.GetOrAddComponent(var_35_4.gameObject, typeof(DynamicBoneHelper))

				if var_35_5 then
					var_35_5:EnableDynamicBone(false)
				end

				arg_32_1:ShowWeapon(arg_32_1.var_["4014_tpose" .. "Animator"].transform, true)
			end

			local var_35_6 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_6 then
				var_35_4.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0) / var_35_6)
				var_35_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_4.position).x, (manager.ui.mainCamera.transform.position - var_35_4.position).y, (manager.ui.mainCamera.transform.position - var_35_4.position).z)
				var_35_4.localEulerAngles.z = 0
				var_35_4.localEulerAngles.x = 0
				var_35_4.localEulerAngles = var_35_4.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_6 and arg_32_1.time_ < 0 + var_35_6 + arg_35_0 then
				var_35_4.localPosition = Vector3.New(0, 100, 0)
				var_35_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_4.position).x, (manager.ui.mainCamera.transform.position - var_35_4.position).y, (manager.ui.mainCamera.transform.position - var_35_4.position).z)
				var_35_4.localEulerAngles.z = 0
				var_35_4.localEulerAngles.x = 0
				var_35_4.localEulerAngles = var_35_4.localEulerAngles

				local var_35_7 = GameObjectTools.GetOrAddComponent(var_35_4.gameObject, typeof(DynamicBoneHelper))

				if var_35_7 then
					var_35_7:EnableDynamicBone(true)
				end
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_35_8 = 0
			local var_35_9 = 0.175

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_8 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_10 = arg_32_1:GetWordFromCfg(106122008)
				local var_35_11 = arg_32_1:FormatText(var_35_10.content)

				arg_32_1.text_.text = var_35_11

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_13 = 7 <= 0 and var_35_9 or var_35_9 * (utf8.len(var_35_11) / 7)

				if (7 <= 0 and var_35_9 or var_35_9 * (utf8.len(var_35_11) / 7)) > 0 and var_35_9 < var_35_13 then
					arg_32_1.talkMaxDuration = var_35_13

					if var_35_13 + var_35_8 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_13 + var_35_8
					end
				end

				arg_32_1.text_.text = var_35_11
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122008", "story_v_out_106122.awb") ~= 0 then
					local var_35_14 = manager.audio:GetVoiceLength("story_v_out_106122", "106122008", "story_v_out_106122.awb") / 1000

					if var_35_14 + var_35_8 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_14 + var_35_8
					end

					if var_35_10.prefab_name ~= "" and arg_32_1.actors_[var_35_10.prefab_name] ~= nil then
						local var_35_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_10.prefab_name].transform, "story_v_out_106122", "106122008", "story_v_out_106122.awb")

						arg_32_1:RecordAudio("106122008", var_35_15)
						arg_32_1:RecordAudio("106122008", var_35_15)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_106122", "106122008", "story_v_out_106122.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_106122", "106122008", "story_v_out_106122.awb")
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
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play106122009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 106122009
		arg_36_1.duration_ = 4.07

		local var_36_0 = {
			ja = 4.066,
			ko = 2.633,
			zh = 2.866,
			en = 2.9
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
				arg_36_0:Play106122010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["4014_tpose"]) and arg_36_1.var_.characterEffect4014_tpose == nil then
				arg_36_1.var_.characterEffect4014_tpose = arg_36_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["4014_tpose"]) then
				if arg_36_1.var_.characterEffect4014_tpose and not isNil(arg_36_1.actors_["4014_tpose"]) then
					arg_36_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["4014_tpose"]) and arg_36_1.var_.characterEffect4014_tpose then
				arg_36_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_39_2 = arg_36_1.actors_["1093ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect1093ui_story == nil then
				arg_36_1.var_.characterEffect1093ui_story = var_39_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_3 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 and not isNil(var_39_2) then
				if arg_36_1.var_.characterEffect1093ui_story and not isNil(var_39_2) then
					arg_36_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_3)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect1093ui_story then
				arg_36_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_39_4 = arg_36_1.actors_["1093ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1093ui_story = var_39_4.localPosition

				arg_36_1:ShowWeapon(arg_36_1.var_["1093ui_story" .. "Animator"].transform, true)
			end

			local var_39_5 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_5 then
				var_39_4.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_5)
				var_39_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_4.position).x, (manager.ui.mainCamera.transform.position - var_39_4.position).y, (manager.ui.mainCamera.transform.position - var_39_4.position).z)
				var_39_4.localEulerAngles.z = 0
				var_39_4.localEulerAngles.x = 0
				var_39_4.localEulerAngles = var_39_4.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_5 and arg_36_1.time_ < 0 + var_39_5 + arg_39_0 then
				var_39_4.localPosition = Vector3.New(0, 100, 0)
				var_39_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_4.position).x, (manager.ui.mainCamera.transform.position - var_39_4.position).y, (manager.ui.mainCamera.transform.position - var_39_4.position).z)
				var_39_4.localEulerAngles.z = 0
				var_39_4.localEulerAngles.x = 0
				var_39_4.localEulerAngles = var_39_4.localEulerAngles
			end

			local var_39_6 = arg_36_1.actors_["4014_tpose"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos4014_tpose = var_39_6.localPosition

				local var_39_7 = GameObjectTools.GetOrAddComponent(var_39_6.gameObject, typeof(DynamicBoneHelper))

				if var_39_7 then
					var_39_7:EnableDynamicBone(false)
				end
			end

			local var_39_8 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_8 then
				var_39_6.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_36_1.time_ - 0) / var_39_8)
				var_39_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_6.position).x, (manager.ui.mainCamera.transform.position - var_39_6.position).y, (manager.ui.mainCamera.transform.position - var_39_6.position).z)
				var_39_6.localEulerAngles.z = 0
				var_39_6.localEulerAngles.x = 0
				var_39_6.localEulerAngles = var_39_6.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_8 and arg_36_1.time_ < 0 + var_39_8 + arg_39_0 then
				var_39_6.localPosition = Vector3.New(0, -1.95, -4.2)
				var_39_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_6.position).x, (manager.ui.mainCamera.transform.position - var_39_6.position).y, (manager.ui.mainCamera.transform.position - var_39_6.position).z)
				var_39_6.localEulerAngles.z = 0
				var_39_6.localEulerAngles.x = 0
				var_39_6.localEulerAngles = var_39_6.localEulerAngles

				local var_39_9 = GameObjectTools.GetOrAddComponent(var_39_6.gameObject, typeof(DynamicBoneHelper))

				if var_39_9 then
					var_39_9:EnableDynamicBone(true)
				end
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_39_10 = 0
			local var_39_11 = 0.3

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_12 = arg_36_1:GetWordFromCfg(106122009)
				local var_39_13 = arg_36_1:FormatText(var_39_12.content)

				arg_36_1.text_.text = var_39_13

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_15 = 12 <= 0 and var_39_11 or var_39_11 * (utf8.len(var_39_13) / 12)

				if (12 <= 0 and var_39_11 or var_39_11 * (utf8.len(var_39_13) / 12)) > 0 and var_39_11 < var_39_15 then
					arg_36_1.talkMaxDuration = var_39_15

					if var_39_15 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_15 + var_39_10
					end
				end

				arg_36_1.text_.text = var_39_13
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122009", "story_v_out_106122.awb") ~= 0 then
					local var_39_16 = manager.audio:GetVoiceLength("story_v_out_106122", "106122009", "story_v_out_106122.awb") / 1000

					if var_39_16 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_16 + var_39_10
					end

					if var_39_12.prefab_name ~= "" and arg_36_1.actors_[var_39_12.prefab_name] ~= nil then
						local var_39_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_12.prefab_name].transform, "story_v_out_106122", "106122009", "story_v_out_106122.awb")

						arg_36_1:RecordAudio("106122009", var_39_17)
						arg_36_1:RecordAudio("106122009", var_39_17)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_106122", "106122009", "story_v_out_106122.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_106122", "106122009", "story_v_out_106122.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_18 = math.max(var_39_11, arg_36_1.talkMaxDuration)

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_18 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_10) / var_39_18

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_10 + var_39_18 and arg_36_1.time_ < var_39_10 + var_39_18 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play106122010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 106122010
		arg_40_1.duration_ = 7

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play106122011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["4014_tpose"]) and arg_40_1.var_.characterEffect4014_tpose == nil then
				arg_40_1.var_.characterEffect4014_tpose = arg_40_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.1

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["4014_tpose"]) then
				if arg_40_1.var_.characterEffect4014_tpose and not isNil(arg_40_1.actors_["4014_tpose"]) then
					arg_40_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_40_1.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_0)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["4014_tpose"]) and arg_40_1.var_.characterEffect4014_tpose then
				arg_40_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_40_1.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			local var_43_1 = arg_40_1.actors_["4014_tpose"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos4014_tpose = var_43_1.localPosition

				local var_43_2 = GameObjectTools.GetOrAddComponent(var_43_1.gameObject, typeof(DynamicBoneHelper))

				if var_43_2 then
					var_43_2:EnableDynamicBone(false)
				end
			end

			local var_43_3 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 then
				var_43_1.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_3)
				var_43_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_1.position).x, (manager.ui.mainCamera.transform.position - var_43_1.position).y, (manager.ui.mainCamera.transform.position - var_43_1.position).z)
				var_43_1.localEulerAngles.z = 0
				var_43_1.localEulerAngles.x = 0
				var_43_1.localEulerAngles = var_43_1.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 then
				var_43_1.localPosition = Vector3.New(0, 100, 0)
				var_43_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_1.position).x, (manager.ui.mainCamera.transform.position - var_43_1.position).y, (manager.ui.mainCamera.transform.position - var_43_1.position).z)
				var_43_1.localEulerAngles.z = 0
				var_43_1.localEulerAngles.x = 0
				var_43_1.localEulerAngles = var_43_1.localEulerAngles

				local var_43_4 = GameObjectTools.GetOrAddComponent(var_43_1.gameObject, typeof(DynamicBoneHelper))

				if var_43_4 then
					var_43_4:EnableDynamicBone(true)
				end
			end

			local var_43_5 = "STblack"

			if arg_40_1.bgs_.STblack == nil then
				local var_43_6 = Object.Instantiate(arg_40_1.paintGo_)

				var_43_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_43_5)
				var_43_6.name = var_43_5
				var_43_6.transform.parent = arg_40_1.stage_.transform
				var_43_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.bgs_[var_43_5] = var_43_6
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				local var_43_7 = arg_40_1.bgs_.STblack

				arg_40_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_43_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_43_8 = var_43_7:GetComponent("SpriteRenderer")

				if var_43_8 and var_43_8.sprite then
					local var_43_9 = 2 * (var_43_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_43_7.transform.localScale = Vector3.New(var_43_9 / var_43_8.sprite.bounds.size.y < var_43_9 * manager.ui.mainCameraCom_.aspect / var_43_8.sprite.bounds.size.x and var_43_9 * manager.ui.mainCameraCom_.aspect / var_43_8.sprite.bounds.size.x or var_43_9 / var_43_8.sprite.bounds.size.y, var_43_9 / var_43_8.sprite.bounds.size.y < var_43_9 * manager.ui.mainCameraCom_.aspect / var_43_8.sprite.bounds.size.x and var_43_9 * manager.ui.mainCameraCom_.aspect / var_43_8.sprite.bounds.size.x or var_43_9 / var_43_8.sprite.bounds.size.y, 0)
				end

				for iter_43_0, iter_43_1 in pairs(arg_40_1.bgs_) do
					if iter_43_0 ~= "STblack" then
						iter_43_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_43_10 = 0

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 then
				arg_40_1.mask_.enabled = true
				arg_40_1.mask_.raycastTarget = true

				arg_40_1:SetGaussion(false)
			end

			local var_43_11 = 2

			if var_43_10 <= arg_40_1.time_ and arg_40_1.time_ < var_43_10 + var_43_11 then
				local var_43_12 = Color.New(0, 0, 0)

				var_43_12.a = Mathf.Lerp(1, 0, (arg_40_1.time_ - var_43_10) / var_43_11)
				arg_40_1.mask_.color = var_43_12
			end

			if arg_40_1.time_ >= var_43_10 + var_43_11 and arg_40_1.time_ < var_43_10 + var_43_11 + arg_43_0 then
				local var_43_13 = Color.New(0, 0, 0)

				arg_40_1.mask_.enabled = false
				var_43_13.a = 0
				arg_40_1.mask_.color = var_43_13
			end

			if arg_40_1.frameCnt_ <= 1 then
				arg_40_1.dialog_:SetActive(false)
			end

			local var_43_14 = 2
			local var_43_15 = 0.925

			if 2 < arg_40_1.time_ and arg_40_1.time_ <= var_43_14 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0

				arg_40_1.dialog_:SetActive(true)

				arg_40_1.dialogCg_.alpha = 0

				local var_43_16 = LeanTween.value(arg_40_1.dialog_, 0, 1, 0.3)

				var_43_16:setOnUpdate(LuaHelper.FloatAction(function(arg_44_0)
					arg_40_1.dialogCg_.alpha = arg_44_0
				end))
				var_43_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_40_1.dialog_)
					var_43_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_40_1.duration_ = arg_40_1.duration_ + 0.3

				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_17 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(106122010).content)

				arg_40_1.text_.text = var_43_17

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_19 = 38 <= 0 and var_43_15 or var_43_15 * (utf8.len(var_43_17) / 38)

				if (38 <= 0 and var_43_15 or var_43_15 * (utf8.len(var_43_17) / 38)) > 0 and var_43_15 < var_43_19 then
					arg_40_1.talkMaxDuration = var_43_19
					var_43_14 = var_43_14 + 0.3

					if var_43_19 + var_43_14 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_19 + var_43_14
					end
				end

				arg_40_1.text_.text = var_43_17
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_20 = var_43_14 + 0.3
			local var_43_21 = math.max(var_43_15, arg_40_1.talkMaxDuration)

			if var_43_14 + 0.3 <= arg_40_1.time_ and arg_40_1.time_ < var_43_20 + var_43_21 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_20) / var_43_21

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_20 + var_43_21 and arg_40_1.time_ < var_43_20 + var_43_21 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
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
	Play106122011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 106122011
		arg_46_1.duration_ = 3.03

		local var_46_0 = {
			ja = 3.033,
			ko = 2.633,
			zh = 2.833,
			en = 2.833
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play106122012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["1093ui_story"]) and arg_46_1.var_.characterEffect1093ui_story == nil then
				arg_46_1.var_.characterEffect1093ui_story = arg_46_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_0 = 0.1

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["1093ui_story"]) then
				if arg_46_1.var_.characterEffect1093ui_story and not isNil(arg_46_1.actors_["1093ui_story"]) then
					arg_46_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["1093ui_story"]) and arg_46_1.var_.characterEffect1093ui_story then
				arg_46_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_49_2 = manager.ui.mainCamera.transform

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.shakeOldPos = var_49_2.localPosition
			end

			local var_49_3 = 0.6

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_3 then
				local var_49_4, var_49_5 = math.modf((arg_46_1.time_ - 0) / 0.066)

				var_49_2.localPosition = Vector3.New(var_49_5 * 0.13, var_49_5 * 0.13, var_49_5 * 0.13) + arg_46_1.var_.shakeOldPos
			end

			if arg_46_1.time_ >= 0 + var_49_3 and arg_46_1.time_ < 0 + var_49_3 + arg_49_0 then
				var_49_2.localPosition = arg_46_1.var_.shakeOldPos
			end

			local var_49_6 = 0

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_6 + arg_49_0 then
				arg_46_1.mask_.enabled = true
				arg_46_1.mask_.raycastTarget = true

				arg_46_1:SetGaussion(false)
			end

			local var_49_7 = 0.5

			if var_49_6 <= arg_46_1.time_ and arg_46_1.time_ < var_49_6 + var_49_7 then
				local var_49_8 = Color.New(1, 1, 1)

				var_49_8.a = Mathf.Lerp(1, 0, (arg_46_1.time_ - var_49_6) / var_49_7)
				arg_46_1.mask_.color = var_49_8
			end

			if arg_46_1.time_ >= var_49_6 + var_49_7 and arg_46_1.time_ < var_49_6 + var_49_7 + arg_49_0 then
				local var_49_9 = Color.New(1, 1, 1)

				arg_46_1.mask_.enabled = false
				var_49_9.a = 0
				arg_46_1.mask_.color = var_49_9
			end

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			if arg_46_1.frameCnt_ <= 1 then
				arg_46_1.dialog_:SetActive(false)
			end

			local var_49_10 = 0.6
			local var_49_11 = 0.25

			if 0.6 < arg_46_1.time_ and arg_46_1.time_ <= var_49_10 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0

				arg_46_1.dialog_:SetActive(true)

				arg_46_1.dialogCg_.alpha = 0

				local var_49_12 = LeanTween.value(arg_46_1.dialog_, 0, 1, 0.3)

				var_49_12:setOnUpdate(LuaHelper.FloatAction(function(arg_50_0)
					arg_46_1.dialogCg_.alpha = arg_50_0
				end))
				var_49_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_46_1.dialog_)
					var_49_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_46_1.duration_ = arg_46_1.duration_ + 0.3

				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_13 = arg_46_1:GetWordFromCfg(106122011)
				local var_49_14 = arg_46_1:FormatText(var_49_13.content)

				arg_46_1.text_.text = var_49_14

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_16 = 10 <= 0 and var_49_11 or var_49_11 * (utf8.len(var_49_14) / 10)

				if (10 <= 0 and var_49_11 or var_49_11 * (utf8.len(var_49_14) / 10)) > 0 and var_49_11 < var_49_16 then
					arg_46_1.talkMaxDuration = var_49_16
					var_49_10 = var_49_10 + 0.3

					if var_49_16 + var_49_10 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_16 + var_49_10
					end
				end

				arg_46_1.text_.text = var_49_14
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122011", "story_v_out_106122.awb") ~= 0 then
					local var_49_17 = manager.audio:GetVoiceLength("story_v_out_106122", "106122011", "story_v_out_106122.awb") / 1000

					if var_49_17 + var_49_10 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_17 + var_49_10
					end

					if var_49_13.prefab_name ~= "" and arg_46_1.actors_[var_49_13.prefab_name] ~= nil then
						local var_49_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_13.prefab_name].transform, "story_v_out_106122", "106122011", "story_v_out_106122.awb")

						arg_46_1:RecordAudio("106122011", var_49_18)
						arg_46_1:RecordAudio("106122011", var_49_18)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_106122", "106122011", "story_v_out_106122.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_106122", "106122011", "story_v_out_106122.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_19 = var_49_10 + 0.3
			local var_49_20 = math.max(var_49_11, arg_46_1.talkMaxDuration)

			if var_49_10 + 0.3 <= arg_46_1.time_ and arg_46_1.time_ < var_49_19 + var_49_20 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_19) / var_49_20

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_19 + var_49_20 and arg_46_1.time_ < var_49_19 + var_49_20 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play106122012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 106122012
		arg_52_1.duration_ = 8.57

		local var_52_0 = {
			ja = 7.466,
			ko = 8.566,
			zh = 7,
			en = 7.966
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
				arg_52_0:Play106122013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if arg_52_1.bgs_.S0611 == nil then
				local var_55_0 = Object.Instantiate(arg_52_1.paintGo_)

				var_55_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0611")
				var_55_0.name = "S0611"
				var_55_0.transform.parent = arg_52_1.stage_.transform
				var_55_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.bgs_.S0611 = var_55_0
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				local var_55_1 = arg_52_1.bgs_.S0611

				arg_52_1.bgs_.S0611.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_55_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_55_2 = var_55_1:GetComponent("SpriteRenderer")

				if var_55_2 and var_55_2.sprite then
					local var_55_3 = 2 * (var_55_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_55_1.transform.localScale = Vector3.New(var_55_3 / var_55_2.sprite.bounds.size.y < var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x and var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x or var_55_3 / var_55_2.sprite.bounds.size.y, var_55_3 / var_55_2.sprite.bounds.size.y < var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x and var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x or var_55_3 / var_55_2.sprite.bounds.size.y, 0)
				end

				for iter_55_0, iter_55_1 in pairs(arg_52_1.bgs_) do
					if iter_55_0 ~= "S0611" then
						iter_55_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_55_4 = 0

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_5 = 2

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_5 then
				local var_55_6 = Color.New(0, 0, 0)

				var_55_6.a = Mathf.Lerp(1, 0, (arg_52_1.time_ - var_55_4) / var_55_5)
				arg_52_1.mask_.color = var_55_6
			end

			if arg_52_1.time_ >= var_55_4 + var_55_5 and arg_52_1.time_ < var_55_4 + var_55_5 + arg_55_0 then
				local var_55_7 = Color.New(0, 0, 0)

				arg_52_1.mask_.enabled = false
				var_55_7.a = 0
				arg_52_1.mask_.color = var_55_7
			end

			local var_55_8 = arg_52_1.bgs_.S0611.transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPosS0611 = var_55_8.localPosition
			end

			local var_55_9 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_9 then
				var_55_8.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPosS0611, Vector3.New(0, 1, 9), (arg_52_1.time_ - 0) / var_55_9)
			end

			if arg_52_1.time_ >= 0 + var_55_9 and arg_52_1.time_ < 0 + var_55_9 + arg_55_0 then
				var_55_8.localPosition = Vector3.New(0, 1, 9)
			end

			local var_55_10 = arg_52_1.bgs_.S0611.transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPosS0611 = var_55_10.localPosition
			end

			local var_55_11 = 2.466

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_11 then
				var_55_10.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPosS0611, Vector3.New(0, 1, 10), (arg_52_1.time_ - 0) / var_55_11)
			end

			if arg_52_1.time_ >= 0 + var_55_11 and arg_52_1.time_ < 0 + var_55_11 + arg_55_0 then
				var_55_10.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_52_1.frameCnt_ <= 1 then
				arg_52_1.dialog_:SetActive(false)
			end

			local var_55_12 = 2
			local var_55_13 = 0.5

			if 2 < arg_52_1.time_ and arg_52_1.time_ <= var_55_12 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				arg_52_1.dialog_:SetActive(true)

				arg_52_1.dialogCg_.alpha = 0

				local var_55_14 = LeanTween.value(arg_52_1.dialog_, 0, 1, 0.3)

				var_55_14:setOnUpdate(LuaHelper.FloatAction(function(arg_56_0)
					arg_52_1.dialogCg_.alpha = arg_56_0
				end))
				var_55_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_52_1.dialog_)
					var_55_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_52_1.duration_ = arg_52_1.duration_ + 0.3

				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_15 = arg_52_1:GetWordFromCfg(106122012)
				local var_55_16 = arg_52_1:FormatText(var_55_15.content)

				arg_52_1.text_.text = var_55_16

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_18 = 20 <= 0 and var_55_13 or var_55_13 * (utf8.len(var_55_16) / 20)

				if (20 <= 0 and var_55_13 or var_55_13 * (utf8.len(var_55_16) / 20)) > 0 and var_55_13 < var_55_18 then
					arg_52_1.talkMaxDuration = var_55_18
					var_55_12 = var_55_12 + 0.3

					if var_55_18 + var_55_12 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_18 + var_55_12
					end
				end

				arg_52_1.text_.text = var_55_16
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122012", "story_v_out_106122.awb") ~= 0 then
					local var_55_19 = manager.audio:GetVoiceLength("story_v_out_106122", "106122012", "story_v_out_106122.awb") / 1000

					if var_55_19 + var_55_12 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_19 + var_55_12
					end

					if var_55_15.prefab_name ~= "" and arg_52_1.actors_[var_55_15.prefab_name] ~= nil then
						local var_55_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_15.prefab_name].transform, "story_v_out_106122", "106122012", "story_v_out_106122.awb")

						arg_52_1:RecordAudio("106122012", var_55_20)
						arg_52_1:RecordAudio("106122012", var_55_20)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_106122", "106122012", "story_v_out_106122.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_106122", "106122012", "story_v_out_106122.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_21 = var_55_12 + 0.3
			local var_55_22 = math.max(var_55_13, arg_52_1.talkMaxDuration)

			if var_55_12 + 0.3 <= arg_52_1.time_ and arg_52_1.time_ < var_55_21 + var_55_22 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_21) / var_55_22

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_21 + var_55_22 and arg_52_1.time_ < var_55_21 + var_55_22 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0611",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0611",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.466,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play106122013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 106122013
		arg_58_1.duration_ = 5.83

		local var_58_0 = {
			ja = 3.5,
			ko = 4.5,
			zh = 5.833,
			en = 4.2
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play106122014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0
			local var_61_1 = 0.4

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0

				arg_58_1.dialog_:SetActive(true)

				arg_58_1.dialogCg_.alpha = 0

				local var_61_2 = LeanTween.value(arg_58_1.dialog_, 0, 1, 0.3)

				var_61_2:setOnUpdate(LuaHelper.FloatAction(function(arg_62_0)
					arg_58_1.dialogCg_.alpha = arg_62_0
				end))
				var_61_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_58_1.dialog_)
					var_61_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_58_1.duration_ = arg_58_1.duration_ + 0.3

				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_3 = arg_58_1:GetWordFromCfg(106122013)
				local var_61_4 = arg_58_1:FormatText(var_61_3.content)

				arg_58_1.text_.text = var_61_4

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_6 = 16 <= 0 and var_61_1 or var_61_1 * (utf8.len(var_61_4) / 16)

				if (16 <= 0 and var_61_1 or var_61_1 * (utf8.len(var_61_4) / 16)) > 0 and var_61_1 < var_61_6 then
					arg_58_1.talkMaxDuration = var_61_6
					var_61_0 = var_61_0 + 0.3

					if var_61_6 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_6 + var_61_0
					end
				end

				arg_58_1.text_.text = var_61_4
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122013", "story_v_out_106122.awb") ~= 0 then
					local var_61_7 = manager.audio:GetVoiceLength("story_v_out_106122", "106122013", "story_v_out_106122.awb") / 1000

					if var_61_7 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_0
					end

					if var_61_3.prefab_name ~= "" and arg_58_1.actors_[var_61_3.prefab_name] ~= nil then
						local var_61_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_3.prefab_name].transform, "story_v_out_106122", "106122013", "story_v_out_106122.awb")

						arg_58_1:RecordAudio("106122013", var_61_8)
						arg_58_1:RecordAudio("106122013", var_61_8)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_106122", "106122013", "story_v_out_106122.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_106122", "106122013", "story_v_out_106122.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_9 = var_61_0 + 0.3
			local var_61_10 = math.max(var_61_1, arg_58_1.talkMaxDuration)

			if var_61_0 + 0.3 <= arg_58_1.time_ and arg_58_1.time_ < var_61_9 + var_61_10 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_9) / var_61_10

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_9 + var_61_10 and arg_58_1.time_ < var_61_9 + var_61_10 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play106122014 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 106122014
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play106122015(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0.575

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_1 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(106122014).content)

				arg_64_1.text_.text = var_67_1

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_3 = 23 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_1) / 23)

				if (23 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_1) / 23)) > 0 and var_67_0 < var_67_3 then
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
	Play106122015 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 106122015
		arg_68_1.duration_ = 12.43

		local var_68_0 = {
			ja = 10.833,
			ko = 8.833,
			zh = 7.466,
			en = 12.433
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
				arg_68_0:Play106122016(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0.875

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_1 = arg_68_1:GetWordFromCfg(106122015)
				local var_71_2 = arg_68_1:FormatText(var_71_1.content)

				arg_68_1.text_.text = var_71_2

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 35 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 35)

				if (35 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 35)) > 0 and var_71_0 < var_71_4 then
					arg_68_1.talkMaxDuration = var_71_4

					if var_71_4 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_4 + 0
					end
				end

				arg_68_1.text_.text = var_71_2
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122015", "story_v_out_106122.awb") ~= 0 then
					local var_71_5 = manager.audio:GetVoiceLength("story_v_out_106122", "106122015", "story_v_out_106122.awb") / 1000

					if var_71_5 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + 0
					end

					if var_71_1.prefab_name ~= "" and arg_68_1.actors_[var_71_1.prefab_name] ~= nil then
						local var_71_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_1.prefab_name].transform, "story_v_out_106122", "106122015", "story_v_out_106122.awb")

						arg_68_1:RecordAudio("106122015", var_71_6)
						arg_68_1:RecordAudio("106122015", var_71_6)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_106122", "106122015", "story_v_out_106122.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_106122", "106122015", "story_v_out_106122.awb")
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
	Play106122016 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 106122016
		arg_72_1.duration_ = 11.83

		local var_72_0 = {
			ja = 11.833,
			ko = 8.733,
			zh = 7.4,
			en = 9.066
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
				arg_72_0:Play106122017(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.9

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_1 = arg_72_1:GetWordFromCfg(106122016)
				local var_75_2 = arg_72_1:FormatText(var_75_1.content)

				arg_72_1.text_.text = var_75_2

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 37 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 37)

				if (37 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 37)) > 0 and var_75_0 < var_75_4 then
					arg_72_1.talkMaxDuration = var_75_4

					if var_75_4 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_4 + 0
					end
				end

				arg_72_1.text_.text = var_75_2
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122016", "story_v_out_106122.awb") ~= 0 then
					local var_75_5 = manager.audio:GetVoiceLength("story_v_out_106122", "106122016", "story_v_out_106122.awb") / 1000

					if var_75_5 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + 0
					end

					if var_75_1.prefab_name ~= "" and arg_72_1.actors_[var_75_1.prefab_name] ~= nil then
						local var_75_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_1.prefab_name].transform, "story_v_out_106122", "106122016", "story_v_out_106122.awb")

						arg_72_1:RecordAudio("106122016", var_75_6)
						arg_72_1:RecordAudio("106122016", var_75_6)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_106122", "106122016", "story_v_out_106122.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_106122", "106122016", "story_v_out_106122.awb")
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
	Play106122017 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 106122017
		arg_76_1.duration_ = 13.43

		local var_76_0 = {
			ja = 13.166,
			ko = 7.933,
			zh = 8.4,
			en = 13.433
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
				arg_76_0:Play106122018(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 4 < arg_76_1.time_ and arg_76_1.time_ <= 4 + arg_79_0 and not isNil(arg_76_1.actors_["1093ui_story"]) and arg_76_1.var_.characterEffect1093ui_story == nil then
				arg_76_1.var_.characterEffect1093ui_story = arg_76_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.1

			if 4 <= arg_76_1.time_ and arg_76_1.time_ < 4 + var_79_0 and not isNil(arg_76_1.actors_["1093ui_story"]) then
				if arg_76_1.var_.characterEffect1093ui_story and not isNil(arg_76_1.actors_["1093ui_story"]) then
					arg_76_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 4 + var_79_0 and arg_76_1.time_ < 4 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1093ui_story"]) and arg_76_1.var_.characterEffect1093ui_story then
				arg_76_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_79_2 = arg_76_1.actors_["4014_tpose"]

			if 4 < arg_76_1.time_ and arg_76_1.time_ <= 4 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.characterEffect4014_tpose == nil then
				arg_76_1.var_.characterEffect4014_tpose = var_79_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_3 = 0.1

			if 4 <= arg_76_1.time_ and arg_76_1.time_ < 4 + var_79_3 and not isNil(var_79_2) then
				if arg_76_1.var_.characterEffect4014_tpose and not isNil(var_79_2) then
					arg_76_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_76_1.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 4) / var_79_3)
				end
			end

			if arg_76_1.time_ >= 4 + var_79_3 and arg_76_1.time_ < 4 + var_79_3 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.characterEffect4014_tpose then
				arg_76_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_76_1.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			local var_79_4 = arg_76_1.actors_["4014_tpose"].transform

			if 4 < arg_76_1.time_ and arg_76_1.time_ <= 4 + arg_79_0 then
				arg_76_1.var_.moveOldPos4014_tpose = var_79_4.localPosition

				local var_79_5 = GameObjectTools.GetOrAddComponent(var_79_4.gameObject, typeof(DynamicBoneHelper))

				if var_79_5 then
					var_79_5:EnableDynamicBone(false)
				end

				arg_76_1:ShowWeapon(arg_76_1.var_["4014_tpose" .. "Animator"].transform, true)
			end

			local var_79_6 = 0.001

			if 4 <= arg_76_1.time_ and arg_76_1.time_ < 4 + var_79_6 then
				var_79_4.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_76_1.time_ - 4) / var_79_6)
				var_79_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_4.position).x, (manager.ui.mainCamera.transform.position - var_79_4.position).y, (manager.ui.mainCamera.transform.position - var_79_4.position).z)
				var_79_4.localEulerAngles.z = 0
				var_79_4.localEulerAngles.x = 0
				var_79_4.localEulerAngles = var_79_4.localEulerAngles
			end

			if arg_76_1.time_ >= 4 + var_79_6 and arg_76_1.time_ < 4 + var_79_6 + arg_79_0 then
				var_79_4.localPosition = Vector3.New(0, 100, 0)
				var_79_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_4.position).x, (manager.ui.mainCamera.transform.position - var_79_4.position).y, (manager.ui.mainCamera.transform.position - var_79_4.position).z)
				var_79_4.localEulerAngles.z = 0
				var_79_4.localEulerAngles.x = 0
				var_79_4.localEulerAngles = var_79_4.localEulerAngles

				local var_79_7 = GameObjectTools.GetOrAddComponent(var_79_4.gameObject, typeof(DynamicBoneHelper))

				if var_79_7 then
					var_79_7:EnableDynamicBone(true)
				end
			end

			local var_79_8 = arg_76_1.actors_["1093ui_story"].transform

			if 4 < arg_76_1.time_ and arg_76_1.time_ <= 4 + arg_79_0 then
				arg_76_1.var_.moveOldPos1093ui_story = var_79_8.localPosition
			end

			local var_79_9 = 0.001

			if 4 <= arg_76_1.time_ and arg_76_1.time_ < 4 + var_79_9 then
				var_79_8.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_76_1.time_ - 4) / var_79_9)
				var_79_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_8.position).x, (manager.ui.mainCamera.transform.position - var_79_8.position).y, (manager.ui.mainCamera.transform.position - var_79_8.position).z)
				var_79_8.localEulerAngles.z = 0
				var_79_8.localEulerAngles.x = 0
				var_79_8.localEulerAngles = var_79_8.localEulerAngles
			end

			if arg_76_1.time_ >= 4 + var_79_9 and arg_76_1.time_ < 4 + var_79_9 + arg_79_0 then
				var_79_8.localPosition = Vector3.New(0, -1.11, -5.88)
				var_79_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_8.position).x, (manager.ui.mainCamera.transform.position - var_79_8.position).y, (manager.ui.mainCamera.transform.position - var_79_8.position).z)
				var_79_8.localEulerAngles.z = 0
				var_79_8.localEulerAngles.x = 0
				var_79_8.localEulerAngles = var_79_8.localEulerAngles
			end

			if 4 < arg_76_1.time_ and arg_76_1.time_ <= 4 + arg_79_0 then
				arg_76_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action10_2")
			end

			if 4 < arg_76_1.time_ and arg_76_1.time_ <= 4 + arg_79_0 then
				arg_76_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			if 2 < arg_76_1.time_ and arg_76_1.time_ <= 2 + arg_79_0 then
				local var_79_10 = arg_76_1.bgs_.C01b

				arg_76_1.bgs_.C01b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_79_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_79_11 = var_79_10:GetComponent("SpriteRenderer")

				if var_79_11 and var_79_11.sprite then
					local var_79_12 = 2 * (var_79_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_79_10.transform.localScale = Vector3.New(var_79_12 / var_79_11.sprite.bounds.size.y < var_79_12 * manager.ui.mainCameraCom_.aspect / var_79_11.sprite.bounds.size.x and var_79_12 * manager.ui.mainCameraCom_.aspect / var_79_11.sprite.bounds.size.x or var_79_12 / var_79_11.sprite.bounds.size.y, var_79_12 / var_79_11.sprite.bounds.size.y < var_79_12 * manager.ui.mainCameraCom_.aspect / var_79_11.sprite.bounds.size.x and var_79_12 * manager.ui.mainCameraCom_.aspect / var_79_11.sprite.bounds.size.x or var_79_12 / var_79_11.sprite.bounds.size.y, 0)
				end

				for iter_79_0, iter_79_1 in pairs(arg_76_1.bgs_) do
					if iter_79_0 ~= "C01b" then
						iter_79_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_79_13 = 0

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_13 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_14 = 2

			if var_79_13 <= arg_76_1.time_ and arg_76_1.time_ < var_79_13 + var_79_14 then
				local var_79_15 = Color.New(0, 0, 0)

				var_79_15.a = Mathf.Lerp(0, 1, (arg_76_1.time_ - var_79_13) / var_79_14)
				arg_76_1.mask_.color = var_79_15
			end

			if arg_76_1.time_ >= var_79_13 + var_79_14 and arg_76_1.time_ < var_79_13 + var_79_14 + arg_79_0 then
				local var_79_16 = Color.New(0, 0, 0)

				var_79_16.a = 1
				arg_76_1.mask_.color = var_79_16
			end

			local var_79_17 = 2

			if 2 < arg_76_1.time_ and arg_76_1.time_ <= var_79_17 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_18 = 2

			if var_79_17 <= arg_76_1.time_ and arg_76_1.time_ < var_79_17 + var_79_18 then
				local var_79_19 = Color.New(0, 0, 0)

				var_79_19.a = Mathf.Lerp(1, 0, (arg_76_1.time_ - var_79_17) / var_79_18)
				arg_76_1.mask_.color = var_79_19
			end

			if arg_76_1.time_ >= var_79_17 + var_79_18 and arg_76_1.time_ < var_79_17 + var_79_18 + arg_79_0 then
				local var_79_20 = Color.New(0, 0, 0)

				arg_76_1.mask_.enabled = false
				var_79_20.a = 0
				arg_76_1.mask_.color = var_79_20
			end

			if arg_76_1.frameCnt_ <= 1 then
				arg_76_1.dialog_:SetActive(false)
			end

			local var_79_21 = 4
			local var_79_22 = 0.4

			if 4 < arg_76_1.time_ and arg_76_1.time_ <= var_79_21 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0

				arg_76_1.dialog_:SetActive(true)

				arg_76_1.dialogCg_.alpha = 0

				local var_79_23 = LeanTween.value(arg_76_1.dialog_, 0, 1, 0.3)

				var_79_23:setOnUpdate(LuaHelper.FloatAction(function(arg_80_0)
					arg_76_1.dialogCg_.alpha = arg_80_0
				end))
				var_79_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_76_1.dialog_)
					var_79_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_76_1.duration_ = arg_76_1.duration_ + 0.3

				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_24 = arg_76_1:GetWordFromCfg(106122017)
				local var_79_25 = arg_76_1:FormatText(var_79_24.content)

				arg_76_1.text_.text = var_79_25

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_27 = 16 <= 0 and var_79_22 or var_79_22 * (utf8.len(var_79_25) / 16)

				if (16 <= 0 and var_79_22 or var_79_22 * (utf8.len(var_79_25) / 16)) > 0 and var_79_22 < var_79_27 then
					arg_76_1.talkMaxDuration = var_79_27
					var_79_21 = var_79_21 + 0.3

					if var_79_27 + var_79_21 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_27 + var_79_21
					end
				end

				arg_76_1.text_.text = var_79_25
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122017", "story_v_out_106122.awb") ~= 0 then
					local var_79_28 = manager.audio:GetVoiceLength("story_v_out_106122", "106122017", "story_v_out_106122.awb") / 1000

					if var_79_28 + var_79_21 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_28 + var_79_21
					end

					if var_79_24.prefab_name ~= "" and arg_76_1.actors_[var_79_24.prefab_name] ~= nil then
						local var_79_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_24.prefab_name].transform, "story_v_out_106122", "106122017", "story_v_out_106122.awb")

						arg_76_1:RecordAudio("106122017", var_79_29)
						arg_76_1:RecordAudio("106122017", var_79_29)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_106122", "106122017", "story_v_out_106122.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_106122", "106122017", "story_v_out_106122.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_30 = var_79_21 + 0.3
			local var_79_31 = math.max(var_79_22, arg_76_1.talkMaxDuration)

			if var_79_21 + 0.3 <= arg_76_1.time_ and arg_76_1.time_ < var_79_30 + var_79_31 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_30) / var_79_31

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_30 + var_79_31 and arg_76_1.time_ < var_79_30 + var_79_31 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play106122018 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 106122018
		arg_82_1.duration_ = 7

		local var_82_0 = {
			ja = 5.6,
			ko = 6,
			zh = 5.4,
			en = 7
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play106122019(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["4014_tpose"]) and arg_82_1.var_.characterEffect4014_tpose == nil then
				arg_82_1.var_.characterEffect4014_tpose = arg_82_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_0 = 0.1

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["4014_tpose"]) then
				if arg_82_1.var_.characterEffect4014_tpose and not isNil(arg_82_1.actors_["4014_tpose"]) then
					arg_82_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["4014_tpose"]) and arg_82_1.var_.characterEffect4014_tpose then
				arg_82_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_85_2 = arg_82_1.actors_["1093ui_story"].transform

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos1093ui_story = var_85_2.localPosition
			end

			local var_85_3 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_3 then
				var_85_2.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_82_1.time_ - 0) / var_85_3)
				var_85_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_85_2.position).x, (manager.ui.mainCamera.transform.position - var_85_2.position).y, (manager.ui.mainCamera.transform.position - var_85_2.position).z)
				var_85_2.localEulerAngles.z = 0
				var_85_2.localEulerAngles.x = 0
				var_85_2.localEulerAngles = var_85_2.localEulerAngles
			end

			if arg_82_1.time_ >= 0 + var_85_3 and arg_82_1.time_ < 0 + var_85_3 + arg_85_0 then
				var_85_2.localPosition = Vector3.New(0, 100, 0)
				var_85_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_85_2.position).x, (manager.ui.mainCamera.transform.position - var_85_2.position).y, (manager.ui.mainCamera.transform.position - var_85_2.position).z)
				var_85_2.localEulerAngles.z = 0
				var_85_2.localEulerAngles.x = 0
				var_85_2.localEulerAngles = var_85_2.localEulerAngles
			end

			local var_85_4 = arg_82_1.actors_["4014_tpose"].transform

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos4014_tpose = var_85_4.localPosition

				local var_85_5 = GameObjectTools.GetOrAddComponent(var_85_4.gameObject, typeof(DynamicBoneHelper))

				if var_85_5 then
					var_85_5:EnableDynamicBone(false)
				end
			end

			local var_85_6 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_6 then
				var_85_4.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_82_1.time_ - 0) / var_85_6)
				var_85_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_85_4.position).x, (manager.ui.mainCamera.transform.position - var_85_4.position).y, (manager.ui.mainCamera.transform.position - var_85_4.position).z)
				var_85_4.localEulerAngles.z = 0
				var_85_4.localEulerAngles.x = 0
				var_85_4.localEulerAngles = var_85_4.localEulerAngles
			end

			if arg_82_1.time_ >= 0 + var_85_6 and arg_82_1.time_ < 0 + var_85_6 + arg_85_0 then
				var_85_4.localPosition = Vector3.New(0, -1.95, -4.2)
				var_85_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_85_4.position).x, (manager.ui.mainCamera.transform.position - var_85_4.position).y, (manager.ui.mainCamera.transform.position - var_85_4.position).z)
				var_85_4.localEulerAngles.z = 0
				var_85_4.localEulerAngles.x = 0
				var_85_4.localEulerAngles = var_85_4.localEulerAngles

				local var_85_7 = GameObjectTools.GetOrAddComponent(var_85_4.gameObject, typeof(DynamicBoneHelper))

				if var_85_7 then
					var_85_7:EnableDynamicBone(true)
				end
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_85_8 = 0
			local var_85_9 = 0.55

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_8 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_10 = arg_82_1:GetWordFromCfg(106122018)
				local var_85_11 = arg_82_1:FormatText(var_85_10.content)

				arg_82_1.text_.text = var_85_11

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_13 = 22 <= 0 and var_85_9 or var_85_9 * (utf8.len(var_85_11) / 22)

				if (22 <= 0 and var_85_9 or var_85_9 * (utf8.len(var_85_11) / 22)) > 0 and var_85_9 < var_85_13 then
					arg_82_1.talkMaxDuration = var_85_13

					if var_85_13 + var_85_8 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_13 + var_85_8
					end
				end

				arg_82_1.text_.text = var_85_11
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122018", "story_v_out_106122.awb") ~= 0 then
					local var_85_14 = manager.audio:GetVoiceLength("story_v_out_106122", "106122018", "story_v_out_106122.awb") / 1000

					if var_85_14 + var_85_8 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_14 + var_85_8
					end

					if var_85_10.prefab_name ~= "" and arg_82_1.actors_[var_85_10.prefab_name] ~= nil then
						local var_85_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_10.prefab_name].transform, "story_v_out_106122", "106122018", "story_v_out_106122.awb")

						arg_82_1:RecordAudio("106122018", var_85_15)
						arg_82_1:RecordAudio("106122018", var_85_15)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_106122", "106122018", "story_v_out_106122.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_106122", "106122018", "story_v_out_106122.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_16 = math.max(var_85_9, arg_82_1.talkMaxDuration)

			if var_85_8 <= arg_82_1.time_ and arg_82_1.time_ < var_85_8 + var_85_16 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_8) / var_85_16

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_8 + var_85_16 and arg_82_1.time_ < var_85_8 + var_85_16 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play106122019 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 106122019
		arg_86_1.duration_ = 12.53

		local var_86_0 = {
			ja = 9.8,
			ko = 12.533,
			zh = 10.6,
			en = 10.366
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play106122020(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 1.05

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_1 = arg_86_1:GetWordFromCfg(106122019)
				local var_89_2 = arg_86_1:FormatText(var_89_1.content)

				arg_86_1.text_.text = var_89_2

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_4 = 42 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 42)

				if (42 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 42)) > 0 and var_89_0 < var_89_4 then
					arg_86_1.talkMaxDuration = var_89_4

					if var_89_4 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_4 + 0
					end
				end

				arg_86_1.text_.text = var_89_2
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122019", "story_v_out_106122.awb") ~= 0 then
					local var_89_5 = manager.audio:GetVoiceLength("story_v_out_106122", "106122019", "story_v_out_106122.awb") / 1000

					if var_89_5 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + 0
					end

					if var_89_1.prefab_name ~= "" and arg_86_1.actors_[var_89_1.prefab_name] ~= nil then
						local var_89_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_1.prefab_name].transform, "story_v_out_106122", "106122019", "story_v_out_106122.awb")

						arg_86_1:RecordAudio("106122019", var_89_6)
						arg_86_1:RecordAudio("106122019", var_89_6)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_106122", "106122019", "story_v_out_106122.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_106122", "106122019", "story_v_out_106122.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_7 = math.max(var_89_0, arg_86_1.talkMaxDuration)

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_7 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - 0) / var_89_7

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= 0 + var_89_7 and arg_86_1.time_ < 0 + var_89_7 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play106122020 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 106122020
		arg_90_1.duration_ = 5.7

		local var_90_0 = {
			ja = 5.7,
			ko = 4.8,
			zh = 4.333,
			en = 5.633
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play106122021(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0.475

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_1 = arg_90_1:GetWordFromCfg(106122020)
				local var_93_2 = arg_90_1:FormatText(var_93_1.content)

				arg_90_1.text_.text = var_93_2

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 19 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 19)

				if (19 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 19)) > 0 and var_93_0 < var_93_4 then
					arg_90_1.talkMaxDuration = var_93_4

					if var_93_4 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_4 + 0
					end
				end

				arg_90_1.text_.text = var_93_2
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122020", "story_v_out_106122.awb") ~= 0 then
					local var_93_5 = manager.audio:GetVoiceLength("story_v_out_106122", "106122020", "story_v_out_106122.awb") / 1000

					if var_93_5 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + 0
					end

					if var_93_1.prefab_name ~= "" and arg_90_1.actors_[var_93_1.prefab_name] ~= nil then
						local var_93_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_1.prefab_name].transform, "story_v_out_106122", "106122020", "story_v_out_106122.awb")

						arg_90_1:RecordAudio("106122020", var_93_6)
						arg_90_1:RecordAudio("106122020", var_93_6)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_106122", "106122020", "story_v_out_106122.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_106122", "106122020", "story_v_out_106122.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_7 and arg_90_1.time_ < 0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play106122021 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 106122021
		arg_94_1.duration_ = 5.63

		local var_94_0 = {
			ja = 4.366,
			ko = 3.633,
			zh = 2.733,
			en = 5.633
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play106122022(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["1093ui_story"]) and arg_94_1.var_.characterEffect1093ui_story == nil then
				arg_94_1.var_.characterEffect1093ui_story = arg_94_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_0 = 0.1

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["1093ui_story"]) then
				if arg_94_1.var_.characterEffect1093ui_story and not isNil(arg_94_1.actors_["1093ui_story"]) then
					arg_94_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["1093ui_story"]) and arg_94_1.var_.characterEffect1093ui_story then
				arg_94_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_97_2 = arg_94_1.actors_["4014_tpose"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.characterEffect4014_tpose == nil then
				arg_94_1.var_.characterEffect4014_tpose = var_97_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_3 = 0.1

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_3 and not isNil(var_97_2) then
				if arg_94_1.var_.characterEffect4014_tpose and not isNil(var_97_2) then
					arg_94_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_94_1.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_94_1.time_ - 0) / var_97_3)
				end
			end

			if arg_94_1.time_ >= 0 + var_97_3 and arg_94_1.time_ < 0 + var_97_3 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.characterEffect4014_tpose then
				arg_94_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_94_1.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			local var_97_4 = arg_94_1.actors_["4014_tpose"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos4014_tpose = var_97_4.localPosition

				local var_97_5 = GameObjectTools.GetOrAddComponent(var_97_4.gameObject, typeof(DynamicBoneHelper))

				if var_97_5 then
					var_97_5:EnableDynamicBone(false)
				end
			end

			local var_97_6 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_6 then
				var_97_4.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_94_1.time_ - 0) / var_97_6)
				var_97_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_4.position).x, (manager.ui.mainCamera.transform.position - var_97_4.position).y, (manager.ui.mainCamera.transform.position - var_97_4.position).z)
				var_97_4.localEulerAngles.z = 0
				var_97_4.localEulerAngles.x = 0
				var_97_4.localEulerAngles = var_97_4.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_6 and arg_94_1.time_ < 0 + var_97_6 + arg_97_0 then
				var_97_4.localPosition = Vector3.New(0, 100, 0)
				var_97_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_4.position).x, (manager.ui.mainCamera.transform.position - var_97_4.position).y, (manager.ui.mainCamera.transform.position - var_97_4.position).z)
				var_97_4.localEulerAngles.z = 0
				var_97_4.localEulerAngles.x = 0
				var_97_4.localEulerAngles = var_97_4.localEulerAngles

				local var_97_7 = GameObjectTools.GetOrAddComponent(var_97_4.gameObject, typeof(DynamicBoneHelper))

				if var_97_7 then
					var_97_7:EnableDynamicBone(true)
				end
			end

			local var_97_8 = arg_94_1.actors_["1093ui_story"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1093ui_story = var_97_8.localPosition

				arg_94_1:ShowWeapon(arg_94_1.var_["1093ui_story" .. "Animator"].transform, true)
			end

			local var_97_9 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_9 then
				var_97_8.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_94_1.time_ - 0) / var_97_9)
				var_97_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_8.position).x, (manager.ui.mainCamera.transform.position - var_97_8.position).y, (manager.ui.mainCamera.transform.position - var_97_8.position).z)
				var_97_8.localEulerAngles.z = 0
				var_97_8.localEulerAngles.x = 0
				var_97_8.localEulerAngles = var_97_8.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_9 and arg_94_1.time_ < 0 + var_97_9 + arg_97_0 then
				var_97_8.localPosition = Vector3.New(0, -1.11, -5.88)
				var_97_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_8.position).x, (manager.ui.mainCamera.transform.position - var_97_8.position).y, (manager.ui.mainCamera.transform.position - var_97_8.position).z)
				var_97_8.localEulerAngles.z = 0
				var_97_8.localEulerAngles.x = 0
				var_97_8.localEulerAngles = var_97_8.localEulerAngles
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action10_2")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_97_10 = 0
			local var_97_11 = 0.35

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_10 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_12 = arg_94_1:GetWordFromCfg(106122021)
				local var_97_13 = arg_94_1:FormatText(var_97_12.content)

				arg_94_1.text_.text = var_97_13

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_15 = 14 <= 0 and var_97_11 or var_97_11 * (utf8.len(var_97_13) / 14)

				if (14 <= 0 and var_97_11 or var_97_11 * (utf8.len(var_97_13) / 14)) > 0 and var_97_11 < var_97_15 then
					arg_94_1.talkMaxDuration = var_97_15

					if var_97_15 + var_97_10 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_15 + var_97_10
					end
				end

				arg_94_1.text_.text = var_97_13
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122021", "story_v_out_106122.awb") ~= 0 then
					local var_97_16 = manager.audio:GetVoiceLength("story_v_out_106122", "106122021", "story_v_out_106122.awb") / 1000

					if var_97_16 + var_97_10 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_16 + var_97_10
					end

					if var_97_12.prefab_name ~= "" and arg_94_1.actors_[var_97_12.prefab_name] ~= nil then
						local var_97_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_12.prefab_name].transform, "story_v_out_106122", "106122021", "story_v_out_106122.awb")

						arg_94_1:RecordAudio("106122021", var_97_17)
						arg_94_1:RecordAudio("106122021", var_97_17)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_106122", "106122021", "story_v_out_106122.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_106122", "106122021", "story_v_out_106122.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_18 = math.max(var_97_11, arg_94_1.talkMaxDuration)

			if var_97_10 <= arg_94_1.time_ and arg_94_1.time_ < var_97_10 + var_97_18 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_10) / var_97_18

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_10 + var_97_18 and arg_94_1.time_ < var_97_10 + var_97_18 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play106122022 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 106122022
		arg_98_1.duration_ = 10.07

		local var_98_0 = {
			ja = 4.033,
			ko = 10.066,
			zh = 7.7,
			en = 9.3
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play106122023(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["4014_tpose"]) and arg_98_1.var_.characterEffect4014_tpose == nil then
				arg_98_1.var_.characterEffect4014_tpose = arg_98_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_0 = 0.1

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["4014_tpose"]) then
				if arg_98_1.var_.characterEffect4014_tpose and not isNil(arg_98_1.actors_["4014_tpose"]) then
					arg_98_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["4014_tpose"]) and arg_98_1.var_.characterEffect4014_tpose then
				arg_98_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_101_2 = arg_98_1.actors_["1093ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.characterEffect1093ui_story == nil then
				arg_98_1.var_.characterEffect1093ui_story = var_101_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_3 = 0.1

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_3 and not isNil(var_101_2) then
				if arg_98_1.var_.characterEffect1093ui_story and not isNil(var_101_2) then
					arg_98_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_3)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_3 and arg_98_1.time_ < 0 + var_101_3 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.characterEffect1093ui_story then
				arg_98_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_101_4 = arg_98_1.actors_["1093ui_story"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1093ui_story = var_101_4.localPosition

				arg_98_1:ShowWeapon(arg_98_1.var_["1093ui_story" .. "Animator"].transform, true)
			end

			local var_101_5 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_5 then
				var_101_4.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_98_1.time_ - 0) / var_101_5)
				var_101_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_4.position).x, (manager.ui.mainCamera.transform.position - var_101_4.position).y, (manager.ui.mainCamera.transform.position - var_101_4.position).z)
				var_101_4.localEulerAngles.z = 0
				var_101_4.localEulerAngles.x = 0
				var_101_4.localEulerAngles = var_101_4.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_5 and arg_98_1.time_ < 0 + var_101_5 + arg_101_0 then
				var_101_4.localPosition = Vector3.New(0, 100, 0)
				var_101_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_4.position).x, (manager.ui.mainCamera.transform.position - var_101_4.position).y, (manager.ui.mainCamera.transform.position - var_101_4.position).z)
				var_101_4.localEulerAngles.z = 0
				var_101_4.localEulerAngles.x = 0
				var_101_4.localEulerAngles = var_101_4.localEulerAngles
			end

			local var_101_6 = arg_98_1.actors_["4014_tpose"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos4014_tpose = var_101_6.localPosition

				local var_101_7 = GameObjectTools.GetOrAddComponent(var_101_6.gameObject, typeof(DynamicBoneHelper))

				if var_101_7 then
					var_101_7:EnableDynamicBone(false)
				end
			end

			local var_101_8 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_8 then
				var_101_6.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_98_1.time_ - 0) / var_101_8)
				var_101_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_6.position).x, (manager.ui.mainCamera.transform.position - var_101_6.position).y, (manager.ui.mainCamera.transform.position - var_101_6.position).z)
				var_101_6.localEulerAngles.z = 0
				var_101_6.localEulerAngles.x = 0
				var_101_6.localEulerAngles = var_101_6.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_8 and arg_98_1.time_ < 0 + var_101_8 + arg_101_0 then
				var_101_6.localPosition = Vector3.New(0, -1.95, -4.2)
				var_101_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_6.position).x, (manager.ui.mainCamera.transform.position - var_101_6.position).y, (manager.ui.mainCamera.transform.position - var_101_6.position).z)
				var_101_6.localEulerAngles.z = 0
				var_101_6.localEulerAngles.x = 0
				var_101_6.localEulerAngles = var_101_6.localEulerAngles

				local var_101_9 = GameObjectTools.GetOrAddComponent(var_101_6.gameObject, typeof(DynamicBoneHelper))

				if var_101_9 then
					var_101_9:EnableDynamicBone(true)
				end
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_101_10 = 0
			local var_101_11 = 0.725

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_10 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_12 = arg_98_1:GetWordFromCfg(106122022)
				local var_101_13 = arg_98_1:FormatText(var_101_12.content)

				arg_98_1.text_.text = var_101_13

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_15 = 29 <= 0 and var_101_11 or var_101_11 * (utf8.len(var_101_13) / 29)

				if (29 <= 0 and var_101_11 or var_101_11 * (utf8.len(var_101_13) / 29)) > 0 and var_101_11 < var_101_15 then
					arg_98_1.talkMaxDuration = var_101_15

					if var_101_15 + var_101_10 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_15 + var_101_10
					end
				end

				arg_98_1.text_.text = var_101_13
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122022", "story_v_out_106122.awb") ~= 0 then
					local var_101_16 = manager.audio:GetVoiceLength("story_v_out_106122", "106122022", "story_v_out_106122.awb") / 1000

					if var_101_16 + var_101_10 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_16 + var_101_10
					end

					if var_101_12.prefab_name ~= "" and arg_98_1.actors_[var_101_12.prefab_name] ~= nil then
						local var_101_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_12.prefab_name].transform, "story_v_out_106122", "106122022", "story_v_out_106122.awb")

						arg_98_1:RecordAudio("106122022", var_101_17)
						arg_98_1:RecordAudio("106122022", var_101_17)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_106122", "106122022", "story_v_out_106122.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_106122", "106122022", "story_v_out_106122.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_18 = math.max(var_101_11, arg_98_1.talkMaxDuration)

			if var_101_10 <= arg_98_1.time_ and arg_98_1.time_ < var_101_10 + var_101_18 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_10) / var_101_18

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_10 + var_101_18 and arg_98_1.time_ < var_101_10 + var_101_18 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play106122023 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 106122023
		arg_102_1.duration_ = 2.47

		local var_102_0 = {
			ja = 2.466,
			ko = 1.5,
			zh = 1.4,
			en = 1.4
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play106122024(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["4014_tpose"]) and arg_102_1.var_.characterEffect4014_tpose == nil then
				arg_102_1.var_.characterEffect4014_tpose = arg_102_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.1

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["4014_tpose"]) then
				if arg_102_1.var_.characterEffect4014_tpose and not isNil(arg_102_1.actors_["4014_tpose"]) then
					arg_102_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_102_1.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_0)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["4014_tpose"]) and arg_102_1.var_.characterEffect4014_tpose then
				arg_102_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_102_1.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			local var_105_1 = arg_102_1.actors_["4014_tpose"].transform

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos4014_tpose = var_105_1.localPosition

				local var_105_2 = GameObjectTools.GetOrAddComponent(var_105_1.gameObject, typeof(DynamicBoneHelper))

				if var_105_2 then
					var_105_2:EnableDynamicBone(false)
				end
			end

			local var_105_3 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_3 then
				var_105_1.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_102_1.time_ - 0) / var_105_3)
				var_105_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_1.position).x, (manager.ui.mainCamera.transform.position - var_105_1.position).y, (manager.ui.mainCamera.transform.position - var_105_1.position).z)
				var_105_1.localEulerAngles.z = 0
				var_105_1.localEulerAngles.x = 0
				var_105_1.localEulerAngles = var_105_1.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_3 and arg_102_1.time_ < 0 + var_105_3 + arg_105_0 then
				var_105_1.localPosition = Vector3.New(0, 100, 0)
				var_105_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_1.position).x, (manager.ui.mainCamera.transform.position - var_105_1.position).y, (manager.ui.mainCamera.transform.position - var_105_1.position).z)
				var_105_1.localEulerAngles.z = 0
				var_105_1.localEulerAngles.x = 0
				var_105_1.localEulerAngles = var_105_1.localEulerAngles

				local var_105_4 = GameObjectTools.GetOrAddComponent(var_105_1.gameObject, typeof(DynamicBoneHelper))

				if var_105_4 then
					var_105_4:EnableDynamicBone(true)
				end
			end

			local var_105_5 = 0
			local var_105_6 = 0.075

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_7 = arg_102_1:GetWordFromCfg(106122023)
				local var_105_8 = arg_102_1:FormatText(var_105_7.content)

				arg_102_1.text_.text = var_105_8

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_10 = 3 <= 0 and var_105_6 or var_105_6 * (utf8.len(var_105_8) / 3)

				if (3 <= 0 and var_105_6 or var_105_6 * (utf8.len(var_105_8) / 3)) > 0 and var_105_6 < var_105_10 then
					arg_102_1.talkMaxDuration = var_105_10

					if var_105_10 + var_105_5 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_10 + var_105_5
					end
				end

				arg_102_1.text_.text = var_105_8
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122023", "story_v_out_106122.awb") ~= 0 then
					local var_105_11 = manager.audio:GetVoiceLength("story_v_out_106122", "106122023", "story_v_out_106122.awb") / 1000

					if var_105_11 + var_105_5 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_11 + var_105_5
					end

					if var_105_7.prefab_name ~= "" and arg_102_1.actors_[var_105_7.prefab_name] ~= nil then
						local var_105_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_7.prefab_name].transform, "story_v_out_106122", "106122023", "story_v_out_106122.awb")

						arg_102_1:RecordAudio("106122023", var_105_12)
						arg_102_1:RecordAudio("106122023", var_105_12)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_106122", "106122023", "story_v_out_106122.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_106122", "106122023", "story_v_out_106122.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_13 = math.max(var_105_6, arg_102_1.talkMaxDuration)

			if var_105_5 <= arg_102_1.time_ and arg_102_1.time_ < var_105_5 + var_105_13 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_5) / var_105_13

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_5 + var_105_13 and arg_102_1.time_ < var_105_5 + var_105_13 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play106122024 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 106122024
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play106122025(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_109_0 = 0.6

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 then
				local var_109_1, var_109_2 = math.modf((arg_106_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_109_2 * 0.13, var_109_2 * 0.13, var_109_2 * 0.13) + arg_106_1.var_.shakeOldPos
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 then
				manager.ui.mainCamera.transform.localPosition = arg_106_1.var_.shakeOldPos
			end

			local var_109_3 = 0

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_3 + arg_109_0 then
				arg_106_1.mask_.enabled = true
				arg_106_1.mask_.raycastTarget = true

				arg_106_1:SetGaussion(false)
			end

			local var_109_4 = 0.5

			if var_109_3 <= arg_106_1.time_ and arg_106_1.time_ < var_109_3 + var_109_4 then
				local var_109_5 = Color.New(1, 1, 1)

				var_109_5.a = Mathf.Lerp(1, 0, (arg_106_1.time_ - var_109_3) / var_109_4)
				arg_106_1.mask_.color = var_109_5
			end

			if arg_106_1.time_ >= var_109_3 + var_109_4 and arg_106_1.time_ < var_109_3 + var_109_4 + arg_109_0 then
				local var_109_6 = Color.New(1, 1, 1)

				arg_106_1.mask_.enabled = false
				var_109_6.a = 0
				arg_106_1.mask_.color = var_109_6
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:AudioAction("play", "effect", "se_story_6", "se_story_6_blast", "")
			end

			local var_109_8 = 0
			local var_109_9 = 0.775

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_8 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_10 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(106122024).content)

				arg_106_1.text_.text = var_109_10

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_12 = 31 <= 0 and var_109_9 or var_109_9 * (utf8.len(var_109_10) / 31)

				if (31 <= 0 and var_109_9 or var_109_9 * (utf8.len(var_109_10) / 31)) > 0 and var_109_9 < var_109_12 then
					arg_106_1.talkMaxDuration = var_109_12

					if var_109_12 + var_109_8 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_12 + var_109_8
					end
				end

				arg_106_1.text_.text = var_109_10
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_13 = math.max(var_109_9, arg_106_1.talkMaxDuration)

			if var_109_8 <= arg_106_1.time_ and arg_106_1.time_ < var_109_8 + var_109_13 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_8) / var_109_13

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_8 + var_109_13 and arg_106_1.time_ < var_109_8 + var_109_13 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play106122025 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 106122025
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play106122026(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:AudioAction("play", "effect", "se_story_6", "se_story_6_Impale", "")
			end

			local var_113_1 = 0
			local var_113_2 = 0.725

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_3 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(106122025).content)

				arg_110_1.text_.text = var_113_3

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 29 <= 0 and var_113_2 or var_113_2 * (utf8.len(var_113_3) / 29)

				if (29 <= 0 and var_113_2 or var_113_2 * (utf8.len(var_113_3) / 29)) > 0 and var_113_2 < var_113_5 then
					arg_110_1.talkMaxDuration = var_113_5

					if var_113_5 + var_113_1 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + var_113_1
					end
				end

				arg_110_1.text_.text = var_113_3
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_6 = math.max(var_113_2, arg_110_1.talkMaxDuration)

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_6 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_1) / var_113_6

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_1 + var_113_6 and arg_110_1.time_ < var_113_1 + var_113_6 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play106122026 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 106122026
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play106122027(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:AudioAction("play", "effect", "se_story_6", "se_story_6_black_fog02", "")
			end

			local var_117_1 = 0
			local var_117_2 = 1.025

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_3 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(106122026).content)

				arg_114_1.text_.text = var_117_3

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 41 <= 0 and var_117_2 or var_117_2 * (utf8.len(var_117_3) / 41)

				if (41 <= 0 and var_117_2 or var_117_2 * (utf8.len(var_117_3) / 41)) > 0 and var_117_2 < var_117_5 then
					arg_114_1.talkMaxDuration = var_117_5

					if var_117_5 + var_117_1 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_5 + var_117_1
					end
				end

				arg_114_1.text_.text = var_117_3
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_6 = math.max(var_117_2, arg_114_1.talkMaxDuration)

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_6 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_1) / var_117_6

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_1 + var_117_6 and arg_114_1.time_ < var_117_1 + var_117_6 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play106122027 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 106122027
		arg_118_1.duration_ = 5.47

		local var_118_0 = {
			ja = 5.233,
			ko = 3.6,
			zh = 2.966,
			en = 5.466
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play106122028(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["1093ui_story"]) and arg_118_1.var_.characterEffect1093ui_story == nil then
				arg_118_1.var_.characterEffect1093ui_story = arg_118_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_0 = 0.1

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["1093ui_story"]) then
				if arg_118_1.var_.characterEffect1093ui_story and not isNil(arg_118_1.actors_["1093ui_story"]) then
					arg_118_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["1093ui_story"]) and arg_118_1.var_.characterEffect1093ui_story then
				arg_118_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_121_2 = arg_118_1.actors_["1093ui_story"].transform

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos1093ui_story = var_121_2.localPosition
			end

			local var_121_3 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_3 then
				var_121_2.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_118_1.time_ - 0) / var_121_3)
				var_121_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_2.position).x, (manager.ui.mainCamera.transform.position - var_121_2.position).y, (manager.ui.mainCamera.transform.position - var_121_2.position).z)
				var_121_2.localEulerAngles.z = 0
				var_121_2.localEulerAngles.x = 0
				var_121_2.localEulerAngles = var_121_2.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_3 and arg_118_1.time_ < 0 + var_121_3 + arg_121_0 then
				var_121_2.localPosition = Vector3.New(0, -1.11, -5.88)
				var_121_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_2.position).x, (manager.ui.mainCamera.transform.position - var_121_2.position).y, (manager.ui.mainCamera.transform.position - var_121_2.position).z)
				var_121_2.localEulerAngles.z = 0
				var_121_2.localEulerAngles.x = 0
				var_121_2.localEulerAngles = var_121_2.localEulerAngles
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action10_2")
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_121_4 = 0
			local var_121_5 = 0.225

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_4 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_6 = arg_118_1:GetWordFromCfg(106122027)
				local var_121_7 = arg_118_1:FormatText(var_121_6.content)

				arg_118_1.text_.text = var_121_7

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_9 = 9 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 9)

				if (9 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 9)) > 0 and var_121_5 < var_121_9 then
					arg_118_1.talkMaxDuration = var_121_9

					if var_121_9 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_9 + var_121_4
					end
				end

				arg_118_1.text_.text = var_121_7
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122027", "story_v_out_106122.awb") ~= 0 then
					local var_121_10 = manager.audio:GetVoiceLength("story_v_out_106122", "106122027", "story_v_out_106122.awb") / 1000

					if var_121_10 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_10 + var_121_4
					end

					if var_121_6.prefab_name ~= "" and arg_118_1.actors_[var_121_6.prefab_name] ~= nil then
						local var_121_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_6.prefab_name].transform, "story_v_out_106122", "106122027", "story_v_out_106122.awb")

						arg_118_1:RecordAudio("106122027", var_121_11)
						arg_118_1:RecordAudio("106122027", var_121_11)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_106122", "106122027", "story_v_out_106122.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_106122", "106122027", "story_v_out_106122.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_12 = math.max(var_121_5, arg_118_1.talkMaxDuration)

			if var_121_4 <= arg_118_1.time_ and arg_118_1.time_ < var_121_4 + var_121_12 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_4) / var_121_12

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_4 + var_121_12 and arg_118_1.time_ < var_121_4 + var_121_12 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play106122028 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 106122028
		arg_122_1.duration_ = 6.1

		local var_122_0 = {
			ja = 5.566,
			ko = 3.933,
			zh = 5.866,
			en = 6.1
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play106122029(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if arg_122_1.actors_["3004_tpose"] == nil and not isNil((Asset.Load("Char/" .. "3004_tpose"))) then
				local var_125_0 = Object.Instantiate(Asset.Load("Char/" .. "3004_tpose"), arg_122_1.stage_.transform)

				var_125_0.name = "3004_tpose"
				var_125_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_122_1.actors_["3004_tpose"] = var_125_0

				local var_125_1 = var_125_0:GetComponentInChildren(typeof(CharacterEffect))

				var_125_1.enabled = true

				local var_125_2 = GameObjectTools.GetOrAddComponent(var_125_0, typeof(DynamicBoneHelper))

				if var_125_2 then
					var_125_2:EnableDynamicBone(false)
				end

				arg_122_1:ShowWeapon(var_125_1.transform, false)

				arg_122_1.var_["3004_tpose" .. "Animator"] = var_125_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_122_1.var_["3004_tpose" .. "Animator"].applyRootMotion = true
				arg_122_1.var_["3004_tpose" .. "LipSync"] = var_125_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_125_3 = arg_122_1.actors_["3004_tpose"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_3) and arg_122_1.var_.characterEffect3004_tpose == nil then
				arg_122_1.var_.characterEffect3004_tpose = var_125_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_4 = 0.1

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_4 and not isNil(var_125_3) then
				if arg_122_1.var_.characterEffect3004_tpose and not isNil(var_125_3) then
					arg_122_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_4 and arg_122_1.time_ < 0 + var_125_4 + arg_125_0 and not isNil(var_125_3) and arg_122_1.var_.characterEffect3004_tpose then
				arg_122_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_125_6 = arg_122_1.actors_["1093ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_6) and arg_122_1.var_.characterEffect1093ui_story == nil then
				arg_122_1.var_.characterEffect1093ui_story = var_125_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_7 = 0.1

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_7 and not isNil(var_125_6) then
				if arg_122_1.var_.characterEffect1093ui_story and not isNil(var_125_6) then
					arg_122_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 0) / var_125_7)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_7 and arg_122_1.time_ < 0 + var_125_7 + arg_125_0 and not isNil(var_125_6) and arg_122_1.var_.characterEffect1093ui_story then
				arg_122_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_125_8 = arg_122_1.actors_["1093ui_story"].transform

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos1093ui_story = var_125_8.localPosition
			end

			local var_125_9 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_9 then
				var_125_8.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_122_1.time_ - 0) / var_125_9)
				var_125_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_8.position).x, (manager.ui.mainCamera.transform.position - var_125_8.position).y, (manager.ui.mainCamera.transform.position - var_125_8.position).z)
				var_125_8.localEulerAngles.z = 0
				var_125_8.localEulerAngles.x = 0
				var_125_8.localEulerAngles = var_125_8.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_9 and arg_122_1.time_ < 0 + var_125_9 + arg_125_0 then
				var_125_8.localPosition = Vector3.New(0, 100, 0)
				var_125_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_8.position).x, (manager.ui.mainCamera.transform.position - var_125_8.position).y, (manager.ui.mainCamera.transform.position - var_125_8.position).z)
				var_125_8.localEulerAngles.z = 0
				var_125_8.localEulerAngles.x = 0
				var_125_8.localEulerAngles = var_125_8.localEulerAngles
			end

			local var_125_10 = 0
			local var_125_11 = 0.4

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_10 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3004")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_12 = arg_122_1:GetWordFromCfg(106122028)
				local var_125_13 = arg_122_1:FormatText(var_125_12.content)

				arg_122_1.text_.text = var_125_13

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_15 = 16 <= 0 and var_125_11 or var_125_11 * (utf8.len(var_125_13) / 16)

				if (16 <= 0 and var_125_11 or var_125_11 * (utf8.len(var_125_13) / 16)) > 0 and var_125_11 < var_125_15 then
					arg_122_1.talkMaxDuration = var_125_15

					if var_125_15 + var_125_10 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_15 + var_125_10
					end
				end

				arg_122_1.text_.text = var_125_13
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122028", "story_v_out_106122.awb") ~= 0 then
					local var_125_16 = manager.audio:GetVoiceLength("story_v_out_106122", "106122028", "story_v_out_106122.awb") / 1000

					if var_125_16 + var_125_10 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_16 + var_125_10
					end

					if var_125_12.prefab_name ~= "" and arg_122_1.actors_[var_125_12.prefab_name] ~= nil then
						local var_125_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_12.prefab_name].transform, "story_v_out_106122", "106122028", "story_v_out_106122.awb")

						arg_122_1:RecordAudio("106122028", var_125_17)
						arg_122_1:RecordAudio("106122028", var_125_17)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_106122", "106122028", "story_v_out_106122.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_106122", "106122028", "story_v_out_106122.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_18 = math.max(var_125_11, arg_122_1.talkMaxDuration)

			if var_125_10 <= arg_122_1.time_ and arg_122_1.time_ < var_125_10 + var_125_18 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_10) / var_125_18

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_10 + var_125_18 and arg_122_1.time_ < var_125_10 + var_125_18 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play106122029 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 106122029
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play106122030(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["3004_tpose"]) and arg_126_1.var_.characterEffect3004_tpose == nil then
				arg_126_1.var_.characterEffect3004_tpose = arg_126_1.actors_["3004_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_0 = 0.1

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["3004_tpose"]) then
				if arg_126_1.var_.characterEffect3004_tpose and not isNil(arg_126_1.actors_["3004_tpose"]) then
					arg_126_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_126_1.var_.characterEffect3004_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_0)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["3004_tpose"]) and arg_126_1.var_.characterEffect3004_tpose then
				arg_126_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_126_1.var_.characterEffect3004_tpose.fillRatio = 0.5
			end

			local var_129_1 = 0
			local var_129_2 = 0.95

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_3 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(106122029).content)

				arg_126_1.text_.text = var_129_3

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_5 = 38 <= 0 and var_129_2 or var_129_2 * (utf8.len(var_129_3) / 38)

				if (38 <= 0 and var_129_2 or var_129_2 * (utf8.len(var_129_3) / 38)) > 0 and var_129_2 < var_129_5 then
					arg_126_1.talkMaxDuration = var_129_5

					if var_129_5 + var_129_1 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_5 + var_129_1
					end
				end

				arg_126_1.text_.text = var_129_3
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_6 = math.max(var_129_2, arg_126_1.talkMaxDuration)

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_6 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_1) / var_129_6

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_1 + var_129_6 and arg_126_1.time_ < var_129_1 + var_129_6 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play106122030 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 106122030
		arg_130_1.duration_ = 10.63

		local var_130_0 = {
			ja = 10.633,
			ko = 7.633,
			zh = 9.3,
			en = 10.333
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
			arg_130_1.auto_ = false
		end

		function arg_130_1.playNext_(arg_132_0)
			arg_130_1.onStoryFinished_()
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(arg_130_1.actors_["3004_tpose"]) and arg_130_1.var_.characterEffect3004_tpose == nil then
				arg_130_1.var_.characterEffect3004_tpose = arg_130_1.actors_["3004_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_0 = 0.1

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 and not isNil(arg_130_1.actors_["3004_tpose"]) then
				if arg_130_1.var_.characterEffect3004_tpose and not isNil(arg_130_1.actors_["3004_tpose"]) then
					arg_130_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 and not isNil(arg_130_1.actors_["3004_tpose"]) and arg_130_1.var_.characterEffect3004_tpose then
				arg_130_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_133_2 = arg_130_1.actors_["3004_tpose"].transform

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos3004_tpose = var_133_2.localPosition

				local var_133_3 = GameObjectTools.GetOrAddComponent(var_133_2.gameObject, typeof(DynamicBoneHelper))

				if var_133_3 then
					var_133_3:EnableDynamicBone(false)
				end
			end

			local var_133_4 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_4 then
				var_133_2.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos3004_tpose, Vector3.New(0, -2.22, -3.1), (arg_130_1.time_ - 0) / var_133_4)
				var_133_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_2.position).x, (manager.ui.mainCamera.transform.position - var_133_2.position).y, (manager.ui.mainCamera.transform.position - var_133_2.position).z)
				var_133_2.localEulerAngles.z = 0
				var_133_2.localEulerAngles.x = 0
				var_133_2.localEulerAngles = var_133_2.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_4 and arg_130_1.time_ < 0 + var_133_4 + arg_133_0 then
				var_133_2.localPosition = Vector3.New(0, -2.22, -3.1)
				var_133_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_2.position).x, (manager.ui.mainCamera.transform.position - var_133_2.position).y, (manager.ui.mainCamera.transform.position - var_133_2.position).z)
				var_133_2.localEulerAngles.z = 0
				var_133_2.localEulerAngles.x = 0
				var_133_2.localEulerAngles = var_133_2.localEulerAngles

				local var_133_5 = GameObjectTools.GetOrAddComponent(var_133_2.gameObject, typeof(DynamicBoneHelper))

				if var_133_5 then
					var_133_5:EnableDynamicBone(true)
				end
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_133_6 = 0
			local var_133_7 = 0.75

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_6 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_8 = arg_130_1:GetWordFromCfg(106122030)
				local var_133_9 = arg_130_1:FormatText(var_133_8.content)

				arg_130_1.text_.text = var_133_9

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_11 = 30 <= 0 and var_133_7 or var_133_7 * (utf8.len(var_133_9) / 30)

				if (30 <= 0 and var_133_7 or var_133_7 * (utf8.len(var_133_9) / 30)) > 0 and var_133_7 < var_133_11 then
					arg_130_1.talkMaxDuration = var_133_11

					if var_133_11 + var_133_6 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_11 + var_133_6
					end
				end

				arg_130_1.text_.text = var_133_9
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122030", "story_v_out_106122.awb") ~= 0 then
					local var_133_12 = manager.audio:GetVoiceLength("story_v_out_106122", "106122030", "story_v_out_106122.awb") / 1000

					if var_133_12 + var_133_6 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_12 + var_133_6
					end

					if var_133_8.prefab_name ~= "" and arg_130_1.actors_[var_133_8.prefab_name] ~= nil then
						local var_133_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_8.prefab_name].transform, "story_v_out_106122", "106122030", "story_v_out_106122.awb")

						arg_130_1:RecordAudio("106122030", var_133_13)
						arg_130_1:RecordAudio("106122030", var_133_13)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_106122", "106122030", "story_v_out_106122.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_106122", "106122030", "story_v_out_106122.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_14 = math.max(var_133_7, arg_130_1.talkMaxDuration)

			if var_133_6 <= arg_130_1.time_ and arg_130_1.time_ < var_133_6 + var_133_14 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_6) / var_133_14

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_6 + var_133_14 and arg_130_1.time_ < var_133_6 + var_133_14 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C01b",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/S0611"
	},
	voices = {
		"story_v_out_106122.awb"
	}
}
