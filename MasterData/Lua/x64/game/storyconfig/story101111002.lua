return {
	Play111102001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 111102001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play111102002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.D06b == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D06b")
				var_4_0.name = "D06b"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.D06b = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.D06b

				arg_1_1.bgs_.D06b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "D06b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.D06b:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueD06b = var_4_4.color.a
					arg_1_1.var_.alphaMatValueD06b = var_4_4
				end

				arg_1_1.var_.alphaOldValueD06b = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueD06b then
					arg_1_1.var_.alphaMatValueD06b.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueD06b, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueD06b.color = arg_1_1.var_.alphaMatValueD06b.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueD06b then
				arg_1_1.var_.alphaMatValueD06b.color.a = 1
				arg_1_1.var_.alphaMatValueD06b.color = arg_1_1.var_.alphaMatValueD06b.color
			end

			local var_4_6 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_6 + 1.3 and arg_1_1.time_ < var_4_6 + 1.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_7 = manager.ui.mainCamera.transform

			if 0.666666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.666666666666667 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_7.localPosition
			end

			local var_4_8 = 1.33333333333333

			if 0.666666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 0.666666666666667 + var_4_8 then
				local var_4_9, var_4_10 = math.modf((arg_1_1.time_ - 0.666666666666667) / 0.066)

				var_4_7.localPosition = Vector3.New(var_4_10 * 0.13, var_4_10 * 0.13, var_4_10 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= 0.666666666666667 + var_4_8 and arg_1_1.time_ < 0.666666666666667 + var_4_8 + arg_4_0 then
				var_4_7.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_11 = 0.666666666666667

			if 0.666666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_12 = 0.3

			if var_4_11 <= arg_1_1.time_ and arg_1_1.time_ < var_4_11 + var_4_12 then
				local var_4_13 = Color.New(1, 1, 1)

				var_4_13.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_11) / var_4_12)
				arg_1_1.mask_.color = var_4_13
			end

			if arg_1_1.time_ >= var_4_11 + var_4_12 and arg_1_1.time_ < var_4_11 + var_4_12 + arg_4_0 then
				local var_4_14 = Color.New(1, 1, 1)

				arg_1_1.mask_.enabled = false
				var_4_14.a = 0
				arg_1_1.mask_.color = var_4_14
			end

			local var_4_15 = 1.63333333333333

			if 1.63333333333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_16 = 0.2

			if var_4_15 <= arg_1_1.time_ and arg_1_1.time_ < var_4_15 + var_4_16 then
				local var_4_17 = Color.New(1, 1, 1)

				var_4_17.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_15) / var_4_16)
				arg_1_1.mask_.color = var_4_17
			end

			if arg_1_1.time_ >= var_4_15 + var_4_16 and arg_1_1.time_ < var_4_15 + var_4_16 + arg_4_0 then
				local var_4_18 = Color.New(1, 1, 1)

				arg_1_1.mask_.enabled = false
				var_4_18.a = 0
				arg_1_1.mask_.color = var_4_18
			end

			local var_4_19 = "1094ui_story"

			if arg_1_1.actors_["1094ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1094ui_story"))) then
				local var_4_20 = Object.Instantiate(Asset.Load("Char/" .. "1094ui_story"), arg_1_1.stage_.transform)

				var_4_20.name = var_4_19
				var_4_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_19] = var_4_20

				local var_4_21 = var_4_20:GetComponentInChildren(typeof(CharacterEffect))

				var_4_21.enabled = true

				local var_4_22 = GameObjectTools.GetOrAddComponent(var_4_20, typeof(DynamicBoneHelper))

				if var_4_22 then
					var_4_22:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_21.transform, false)

				arg_1_1.var_[var_4_19 .. "Animator"] = var_4_21.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_19 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_19 .. "LipSync"] = var_4_21.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action6_2")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_4_23 = arg_1_1.actors_["1094ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1094ui_story = var_4_23.localPosition
			end

			local var_4_24 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_24 then
				var_4_23.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_1_1.time_ - 2) / var_4_24)
				var_4_23.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_23.position).x, (manager.ui.mainCamera.transform.position - var_4_23.position).y, (manager.ui.mainCamera.transform.position - var_4_23.position).z)
				var_4_23.localEulerAngles.z = 0
				var_4_23.localEulerAngles.x = 0
				var_4_23.localEulerAngles = var_4_23.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_24 and arg_1_1.time_ < 2 + var_4_24 + arg_4_0 then
				var_4_23.localPosition = Vector3.New(0, -0.84, -6.1)
				var_4_23.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_23.position).x, (manager.ui.mainCamera.transform.position - var_4_23.position).y, (manager.ui.mainCamera.transform.position - var_4_23.position).z)
				var_4_23.localEulerAngles.z = 0
				var_4_23.localEulerAngles.x = 0
				var_4_23.localEulerAngles = var_4_23.localEulerAngles
			end

			local var_4_25 = arg_1_1.actors_["1094ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_25) and arg_1_1.var_.characterEffect1094ui_story == nil then
				arg_1_1.var_.characterEffect1094ui_story = var_4_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_26 = 0.2

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_26 and not isNil(var_4_25) then
				if arg_1_1.var_.characterEffect1094ui_story and not isNil(var_4_25) then
					arg_1_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_1_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_1_1.time_ - 2) / var_4_26)
				end
			end

			if arg_1_1.time_ >= 2 + var_4_26 and arg_1_1.time_ < 2 + var_4_26 + arg_4_0 and not isNil(var_4_25) and arg_1_1.var_.characterEffect1094ui_story then
				arg_1_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_1_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= 1.5 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_29 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
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

			local var_4_30 = 2
			local var_4_31 = 0.85

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_32 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_32:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_33 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(111102001).content)

				arg_1_1.text_.text = var_4_33

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_35 = 34 <= 0 and var_4_31 or var_4_31 * (utf8.len(var_4_33) / 34)

				if (34 <= 0 and var_4_31 or var_4_31 * (utf8.len(var_4_33) / 34)) > 0 and var_4_31 < var_4_35 then
					arg_1_1.talkMaxDuration = var_4_35
					var_4_30 = var_4_30 + 0.3

					if var_4_35 + var_4_30 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_35 + var_4_30
					end
				end

				arg_1_1.text_.text = var_4_33
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_36 = var_4_30 + 0.3
			local var_4_37 = math.max(var_4_31, arg_1_1.talkMaxDuration)

			if var_4_30 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_36) / var_4_37

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play111102002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 111102002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play111102003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.15

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

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(111102002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 46 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 46)

				if (46 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 46)) > 0 and var_11_0 < var_11_3 then
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
	Play111102003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 111102003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play111102004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0.15 < arg_12_1.time_ and arg_12_1.time_ <= 0.15 + arg_15_0 then
				local var_15_0 = arg_12_1.var_.effect123

				if not arg_12_1.var_.effect123 then
					var_15_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), manager.ui.mainCamera.transform)
					var_15_0.name = "123"
					arg_12_1.var_.effect123 = var_15_0
				else
					var_15_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_15_0.transform.localPosition = Vector3.New(0, 0, 0.15)
				var_15_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_15_2 = manager.ui.mainCamera.transform

			if 0.15 < arg_12_1.time_ and arg_12_1.time_ <= 0.15 + arg_15_0 then
				arg_12_1.var_.shakeOldPos = var_15_2.localPosition
			end

			local var_15_3 = 0.8

			if 0.15 <= arg_12_1.time_ and arg_12_1.time_ < 0.15 + var_15_3 then
				local var_15_4, var_15_5 = math.modf((arg_12_1.time_ - 0.15) / 0.066)

				var_15_2.localPosition = Vector3.New(var_15_5 * 0.13, var_15_5 * 0.13, var_15_5 * 0.13) + arg_12_1.var_.shakeOldPos
			end

			if arg_12_1.time_ >= 0.15 + var_15_3 and arg_12_1.time_ < 0.15 + var_15_3 + arg_15_0 then
				var_15_2.localPosition = arg_12_1.var_.shakeOldPos
			end

			local var_15_6 = 0

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			if arg_12_1.time_ >= var_15_6 + 2.65 and arg_12_1.time_ < var_15_6 + 2.65 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end

			local var_15_7 = arg_12_1.actors_["1094ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1094ui_story = var_15_7.localPosition
			end

			local var_15_8 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_8 then
				var_15_7.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1094ui_story, Vector3.New(0, 100, 0), (arg_12_1.time_ - 0) / var_15_8)
				var_15_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_7.position).x, (manager.ui.mainCamera.transform.position - var_15_7.position).y, (manager.ui.mainCamera.transform.position - var_15_7.position).z)
				var_15_7.localEulerAngles.z = 0
				var_15_7.localEulerAngles.x = 0
				var_15_7.localEulerAngles = var_15_7.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_8 and arg_12_1.time_ < 0 + var_15_8 + arg_15_0 then
				var_15_7.localPosition = Vector3.New(0, 100, 0)
				var_15_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_7.position).x, (manager.ui.mainCamera.transform.position - var_15_7.position).y, (manager.ui.mainCamera.transform.position - var_15_7.position).z)
				var_15_7.localEulerAngles.z = 0
				var_15_7.localEulerAngles.x = 0
				var_15_7.localEulerAngles = var_15_7.localEulerAngles
			end

			local var_15_9 = 0
			local var_15_10 = 0.15

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_9 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_11 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(111102003).content)

				arg_12_1.text_.text = var_15_11

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_13 = 6 <= 0 and var_15_10 or var_15_10 * (utf8.len(var_15_11) / 6)

				if (6 <= 0 and var_15_10 or var_15_10 * (utf8.len(var_15_11) / 6)) > 0 and var_15_10 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_9 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_9
					end
				end

				arg_12_1.text_.text = var_15_11
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_14 = math.max(var_15_10, arg_12_1.talkMaxDuration)

			if var_15_9 <= arg_12_1.time_ and arg_12_1.time_ < var_15_9 + var_15_14 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_9) / var_15_14

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_9 + var_15_14 and arg_12_1.time_ < var_15_9 + var_15_14 + arg_15_0 then
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
	Play111102004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 111102004
		arg_16_1.duration_ = 4.6

		local var_16_0 = {
			ja = 2.799999999999,
			ko = 4.6,
			zh = 3.7,
			en = 3
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
				arg_16_0:Play111102005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_9000

			if arg_16_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "1084ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1084ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["1084ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["1084ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["1084ui_story"].transform

			if 0.8 < arg_16_1.time_ and arg_16_1.time_ <= 0.8 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = var_19_3.localPosition

				arg_16_1:ShowWeapon(arg_16_1.var_["1084ui_story" .. "Animator"].transform, true)
			end

			local var_19_4 = 0.001

			if 0.8 <= arg_16_1.time_ and arg_16_1.time_ < 0.8 + var_19_4 then
				var_19_3.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_16_1.time_ - 0.8) / var_19_4)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			if arg_16_1.time_ >= 0.8 + var_19_4 and arg_16_1.time_ < 0.8 + var_19_4 + arg_19_0 then
				var_19_3.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			if 0.8 < arg_16_1.time_ and arg_16_1.time_ <= 0.8 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0.8 < arg_16_1.time_ and arg_16_1.time_ <= 0.8 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_19_5 = arg_16_1.actors_["1084ui_story"]

			if 0.8 < arg_16_1.time_ and arg_16_1.time_ <= 0.8 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_6 = 0.2

			if 0.8 <= arg_16_1.time_ and arg_16_1.time_ < 0.8 + var_19_6 and not isNil(var_19_5) then
				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_5) then
					arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0.8 + var_19_6 and arg_16_1.time_ < 0.8 + var_19_6 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1084ui_story then
				arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				if arg_16_1.var_.effect123 then
					Object.Destroy(arg_16_1.var_.effect123)

					arg_16_1.var_.effect123 = nil
				end
			end

			local var_19_9 = 0

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_9 + arg_19_0 then
				arg_16_1.allBtn_.enabled = false
			end

			if arg_16_1.time_ >= var_19_9 + 2.65 and arg_16_1.time_ < var_19_9 + 2.65 + arg_19_0 then
				arg_16_1.allBtn_.enabled = true
			end

			local var_19_10 = manager.ui.mainCamera.transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.shakeOldPos = var_19_10.localPosition
			end

			local var_19_11 = 0.8

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_11 then
				local var_19_12, var_19_13 = math.modf((arg_16_1.time_ - 0) / 0.066)

				var_19_10.localPosition = Vector3.New(var_19_13 * 0.13, var_19_13 * 0.13, var_19_13 * 0.13) + arg_16_1.var_.shakeOldPos
			end

			if arg_16_1.time_ >= 0 + var_19_11 and arg_16_1.time_ < 0 + var_19_11 + arg_19_0 then
				var_19_10.localPosition = arg_16_1.var_.shakeOldPos
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				local var_19_14 = arg_16_1.var_.effect111

				if not arg_16_1.var_.effect111 then
					var_19_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_02"), manager.ui.mainCamera.transform)
					var_19_14.name = "111"
					arg_16_1.var_.effect111 = var_19_14
				else
					var_19_14.transform:SetParent(var_19_9000)
				end

				var_19_14.transform.localPosition = Vector3.New(0, 0, 0.15)
				var_19_14.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_16_1.frameCnt_ <= 1 then
				arg_16_1.dialog_:SetActive(false)
			end

			local var_19_16 = 0.8
			local var_19_17 = 0.275

			if 0.8 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				arg_16_1.dialog_:SetActive(true)

				arg_16_1.dialogCg_.alpha = 0

				local var_19_18 = LeanTween.value(arg_16_1.dialog_, 0, 1, 0.3)

				var_19_18:setOnUpdate(LuaHelper.FloatAction(function(arg_20_0)
					arg_16_1.dialogCg_.alpha = arg_20_0
				end))
				var_19_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_16_1.dialog_)
					var_19_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_16_1.duration_ = arg_16_1.duration_ + 0.3

				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_19 = arg_16_1:GetWordFromCfg(111102004)
				local var_19_20 = arg_16_1:FormatText(var_19_19.content)

				arg_16_1.text_.text = var_19_20

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_22 = 11 <= 0 and var_19_17 or var_19_17 * (utf8.len(var_19_20) / 11)

				if (11 <= 0 and var_19_17 or var_19_17 * (utf8.len(var_19_20) / 11)) > 0 and var_19_17 < var_19_22 then
					arg_16_1.talkMaxDuration = var_19_22
					var_19_16 = var_19_16 + 0.3

					if var_19_22 + var_19_16 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_22 + var_19_16
					end
				end

				arg_16_1.text_.text = var_19_20
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111102", "111102004", "story_v_out_111102.awb") ~= 0 then
					local var_19_23 = manager.audio:GetVoiceLength("story_v_out_111102", "111102004", "story_v_out_111102.awb") / 1000

					if var_19_23 + var_19_16 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_23 + var_19_16
					end

					if var_19_19.prefab_name ~= "" and arg_16_1.actors_[var_19_19.prefab_name] ~= nil then
						local var_19_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_19.prefab_name].transform, "story_v_out_111102", "111102004", "story_v_out_111102.awb")

						arg_16_1:RecordAudio("111102004", var_19_24)
						arg_16_1:RecordAudio("111102004", var_19_24)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_111102", "111102004", "story_v_out_111102.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_111102", "111102004", "story_v_out_111102.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_25 = var_19_16 + 0.3
			local var_19_26 = math.max(var_19_17, arg_16_1.talkMaxDuration)

			if var_19_16 + 0.3 <= arg_16_1.time_ and arg_16_1.time_ < var_19_25 + var_19_26 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_25) / var_19_26

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_25 + var_19_26 and arg_16_1.time_ < var_19_25 + var_19_26 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play111102005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 111102005
		arg_22_1.duration_ = 9

		local var_22_0 = {
			ja = 7.733,
			ko = 8.533,
			zh = 7.766,
			en = 9
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play111102006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				if arg_22_1.var_.effect111 then
					Object.Destroy(arg_22_1.var_.effect111)

					arg_22_1.var_.effect111 = nil
				end
			end

			local var_25_1 = 0
			local var_25_2 = 1.025

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_3 = arg_22_1:GetWordFromCfg(111102005)
				local var_25_4 = arg_22_1:FormatText(var_25_3.content)

				arg_22_1.text_.text = var_25_4

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_6 = 41 <= 0 and var_25_2 or var_25_2 * (utf8.len(var_25_4) / 41)

				if (41 <= 0 and var_25_2 or var_25_2 * (utf8.len(var_25_4) / 41)) > 0 and var_25_2 < var_25_6 then
					arg_22_1.talkMaxDuration = var_25_6

					if var_25_6 + var_25_1 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_6 + var_25_1
					end
				end

				arg_22_1.text_.text = var_25_4
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111102", "111102005", "story_v_out_111102.awb") ~= 0 then
					local var_25_7 = manager.audio:GetVoiceLength("story_v_out_111102", "111102005", "story_v_out_111102.awb") / 1000

					if var_25_7 + var_25_1 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_7 + var_25_1
					end

					if var_25_3.prefab_name ~= "" and arg_22_1.actors_[var_25_3.prefab_name] ~= nil then
						local var_25_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_3.prefab_name].transform, "story_v_out_111102", "111102005", "story_v_out_111102.awb")

						arg_22_1:RecordAudio("111102005", var_25_8)
						arg_22_1:RecordAudio("111102005", var_25_8)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_111102", "111102005", "story_v_out_111102.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_111102", "111102005", "story_v_out_111102.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_9 = math.max(var_25_2, arg_22_1.talkMaxDuration)

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_9 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_1) / var_25_9

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_1 + var_25_9 and arg_22_1.time_ < var_25_1 + var_25_9 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play111102006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 111102006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play111102007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(arg_26_1.actors_["1084ui_story"]) and arg_26_1.var_.characterEffect1084ui_story == nil then
				arg_26_1.var_.characterEffect1084ui_story = arg_26_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_0 = 0.2

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_0 and not isNil(arg_26_1.actors_["1084ui_story"]) then
				if arg_26_1.var_.characterEffect1084ui_story and not isNil(arg_26_1.actors_["1084ui_story"]) then
					arg_26_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_26_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_26_1.time_ - 0) / var_29_0)
				end
			end

			if arg_26_1.time_ >= 0 + var_29_0 and arg_26_1.time_ < 0 + var_29_0 + arg_29_0 and not isNil(arg_26_1.actors_["1084ui_story"]) and arg_26_1.var_.characterEffect1084ui_story then
				arg_26_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_26_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_29_1 = 0
			local var_29_2 = 0.45

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_3 = arg_26_1:FormatText(arg_26_1:GetWordFromCfg(111102006).content)

				arg_26_1.text_.text = var_29_3

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_5 = 18 <= 0 and var_29_2 or var_29_2 * (utf8.len(var_29_3) / 18)

				if (18 <= 0 and var_29_2 or var_29_2 * (utf8.len(var_29_3) / 18)) > 0 and var_29_2 < var_29_5 then
					arg_26_1.talkMaxDuration = var_29_5

					if var_29_5 + var_29_1 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_5 + var_29_1
					end
				end

				arg_26_1.text_.text = var_29_3
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_6 = math.max(var_29_2, arg_26_1.talkMaxDuration)

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_6 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_1) / var_29_6

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_1 + var_29_6 and arg_26_1.time_ < var_29_1 + var_29_6 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play111102007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 111102007
		arg_30_1.duration_ = 2

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play111102008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.var_.moveOldPos1094ui_story = arg_30_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_33_0 = 0.001

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 then
				arg_30_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos1094ui_story, Vector3.New(0.7, -0.84, -6.1), (arg_30_1.time_ - 0) / var_33_0)
				arg_30_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_30_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_30_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_30_1.actors_["1094ui_story"].transform.position).z)
				arg_30_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_30_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_30_1.actors_["1094ui_story"].transform.localEulerAngles = arg_30_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 then
				arg_30_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0.7, -0.84, -6.1)
				arg_30_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_30_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_30_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_30_1.actors_["1094ui_story"].transform.position).z)
				arg_30_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_30_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_30_1.actors_["1094ui_story"].transform.localEulerAngles = arg_30_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action2_1")
			end

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_33_1 = arg_30_1.actors_["1094ui_story"]

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(var_33_1) and arg_30_1.var_.characterEffect1094ui_story == nil then
				arg_30_1.var_.characterEffect1094ui_story = var_33_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_2 = 0.2

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_2 and not isNil(var_33_1) then
				if arg_30_1.var_.characterEffect1094ui_story and not isNil(var_33_1) then
					arg_30_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= 0 + var_33_2 and arg_30_1.time_ < 0 + var_33_2 + arg_33_0 and not isNil(var_33_1) and arg_30_1.var_.characterEffect1094ui_story then
				arg_30_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_33_4 = 0
			local var_33_5 = 0.125

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_4 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_6 = arg_30_1:GetWordFromCfg(111102007)
				local var_33_7 = arg_30_1:FormatText(var_33_6.content)

				arg_30_1.text_.text = var_33_7

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_9 = 5 <= 0 and var_33_5 or var_33_5 * (utf8.len(var_33_7) / 5)

				if (5 <= 0 and var_33_5 or var_33_5 * (utf8.len(var_33_7) / 5)) > 0 and var_33_5 < var_33_9 then
					arg_30_1.talkMaxDuration = var_33_9

					if var_33_9 + var_33_4 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_9 + var_33_4
					end
				end

				arg_30_1.text_.text = var_33_7
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111102", "111102007", "story_v_out_111102.awb") ~= 0 then
					local var_33_10 = manager.audio:GetVoiceLength("story_v_out_111102", "111102007", "story_v_out_111102.awb") / 1000

					if var_33_10 + var_33_4 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_10 + var_33_4
					end

					if var_33_6.prefab_name ~= "" and arg_30_1.actors_[var_33_6.prefab_name] ~= nil then
						local var_33_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_6.prefab_name].transform, "story_v_out_111102", "111102007", "story_v_out_111102.awb")

						arg_30_1:RecordAudio("111102007", var_33_11)
						arg_30_1:RecordAudio("111102007", var_33_11)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_111102", "111102007", "story_v_out_111102.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_111102", "111102007", "story_v_out_111102.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_12 = math.max(var_33_5, arg_30_1.talkMaxDuration)

			if var_33_4 <= arg_30_1.time_ and arg_30_1.time_ < var_33_4 + var_33_12 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_4) / var_33_12

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_4 + var_33_12 and arg_30_1.time_ < var_33_4 + var_33_12 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
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

		arg_30_1:InitPlayNodeList()
	end,
	Play111102008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 111102008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play111102009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(arg_34_1.actors_["1094ui_story"]) and arg_34_1.var_.characterEffect1094ui_story == nil then
				arg_34_1.var_.characterEffect1094ui_story = arg_34_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_0 = 0.2

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 and not isNil(arg_34_1.actors_["1094ui_story"]) then
				if arg_34_1.var_.characterEffect1094ui_story and not isNil(arg_34_1.actors_["1094ui_story"]) then
					arg_34_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_34_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_34_1.time_ - 0) / var_37_0)
				end
			end

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 and not isNil(arg_34_1.actors_["1094ui_story"]) and arg_34_1.var_.characterEffect1094ui_story then
				arg_34_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_34_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_37_1 = 0
			local var_37_2 = 0.7

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_34_1.callingController_:SetSelectedState("normal")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_3 = arg_34_1:FormatText(arg_34_1:GetWordFromCfg(111102008).content)

				arg_34_1.text_.text = var_37_3

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_5 = 28 <= 0 and var_37_2 or var_37_2 * (utf8.len(var_37_3) / 28)

				if (28 <= 0 and var_37_2 or var_37_2 * (utf8.len(var_37_3) / 28)) > 0 and var_37_2 < var_37_5 then
					arg_34_1.talkMaxDuration = var_37_5

					if var_37_5 + var_37_1 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_5 + var_37_1
					end
				end

				arg_34_1.text_.text = var_37_3
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_6 = math.max(var_37_2, arg_34_1.talkMaxDuration)

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_6 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_1) / var_37_6

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_1 + var_37_6 and arg_34_1.time_ < var_37_1 + var_37_6 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play111102009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 111102009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play111102010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["1094ui_story"]) and arg_38_1.var_.characterEffect1094ui_story == nil then
				arg_38_1.var_.characterEffect1094ui_story = arg_38_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_0 = 0.2

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["1094ui_story"]) then
				if arg_38_1.var_.characterEffect1094ui_story and not isNil(arg_38_1.actors_["1094ui_story"]) then
					arg_38_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_38_1.time_ - 0) / var_41_0)
				end
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["1094ui_story"]) and arg_38_1.var_.characterEffect1094ui_story then
				arg_38_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_41_1 = 0
			local var_41_2 = 0.75

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_3 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(111102009).content)

				arg_38_1.text_.text = var_41_3

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_5 = 30 <= 0 and var_41_2 or var_41_2 * (utf8.len(var_41_3) / 30)

				if (30 <= 0 and var_41_2 or var_41_2 * (utf8.len(var_41_3) / 30)) > 0 and var_41_2 < var_41_5 then
					arg_38_1.talkMaxDuration = var_41_5

					if var_41_5 + var_41_1 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_5 + var_41_1
					end
				end

				arg_38_1.text_.text = var_41_3
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_6 = math.max(var_41_2, arg_38_1.talkMaxDuration)

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_6 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_1) / var_41_6

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_1 + var_41_6 and arg_38_1.time_ < var_41_1 + var_41_6 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play111102010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 111102010
		arg_42_1.duration_ = 5

		local var_42_0 = {
			ja = 3.5,
			ko = 5,
			zh = 4,
			en = 4.566
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play111102011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_2")
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_45_0 = arg_42_1.actors_["1084ui_story"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect1084ui_story == nil then
				arg_42_1.var_.characterEffect1084ui_story = var_45_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_1 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_1 and not isNil(var_45_0) then
				if arg_42_1.var_.characterEffect1084ui_story and not isNil(var_45_0) then
					arg_42_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= 0 + var_45_1 and arg_42_1.time_ < 0 + var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect1084ui_story then
				arg_42_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_45_3 = arg_42_1.actors_["1084ui_story"].transform

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos1084ui_story = var_45_3.localPosition

				arg_42_1:ShowWeapon(arg_42_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_45_4 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_4 then
				var_45_3.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_42_1.time_ - 0) / var_45_4)
				var_45_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_45_3.position).x, (manager.ui.mainCamera.transform.position - var_45_3.position).y, (manager.ui.mainCamera.transform.position - var_45_3.position).z)
				var_45_3.localEulerAngles.z = 0
				var_45_3.localEulerAngles.x = 0
				var_45_3.localEulerAngles = var_45_3.localEulerAngles
			end

			if arg_42_1.time_ >= 0 + var_45_4 and arg_42_1.time_ < 0 + var_45_4 + arg_45_0 then
				var_45_3.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_45_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_45_3.position).x, (manager.ui.mainCamera.transform.position - var_45_3.position).y, (manager.ui.mainCamera.transform.position - var_45_3.position).z)
				var_45_3.localEulerAngles.z = 0
				var_45_3.localEulerAngles.x = 0
				var_45_3.localEulerAngles = var_45_3.localEulerAngles
			end

			local var_45_5 = 0
			local var_45_6 = 0.6

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_5 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_7 = arg_42_1:GetWordFromCfg(111102010)
				local var_45_8 = arg_42_1:FormatText(var_45_7.content)

				arg_42_1.text_.text = var_45_8

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_10 = 25 <= 0 and var_45_6 or var_45_6 * (utf8.len(var_45_8) / 25)

				if (25 <= 0 and var_45_6 or var_45_6 * (utf8.len(var_45_8) / 25)) > 0 and var_45_6 < var_45_10 then
					arg_42_1.talkMaxDuration = var_45_10

					if var_45_10 + var_45_5 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_10 + var_45_5
					end
				end

				arg_42_1.text_.text = var_45_8
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111102", "111102010", "story_v_out_111102.awb") ~= 0 then
					local var_45_11 = manager.audio:GetVoiceLength("story_v_out_111102", "111102010", "story_v_out_111102.awb") / 1000

					if var_45_11 + var_45_5 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_11 + var_45_5
					end

					if var_45_7.prefab_name ~= "" and arg_42_1.actors_[var_45_7.prefab_name] ~= nil then
						local var_45_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_7.prefab_name].transform, "story_v_out_111102", "111102010", "story_v_out_111102.awb")

						arg_42_1:RecordAudio("111102010", var_45_12)
						arg_42_1:RecordAudio("111102010", var_45_12)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_111102", "111102010", "story_v_out_111102.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_111102", "111102010", "story_v_out_111102.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_13 = math.max(var_45_6, arg_42_1.talkMaxDuration)

			if var_45_5 <= arg_42_1.time_ and arg_42_1.time_ < var_45_5 + var_45_13 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_5) / var_45_13

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_5 + var_45_13 and arg_42_1.time_ < var_45_5 + var_45_13 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play111102011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 111102011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play111102012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["1084ui_story"]) and arg_46_1.var_.characterEffect1084ui_story == nil then
				arg_46_1.var_.characterEffect1084ui_story = arg_46_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_0 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["1084ui_story"]) then
				if arg_46_1.var_.characterEffect1084ui_story and not isNil(arg_46_1.actors_["1084ui_story"]) then
					arg_46_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_46_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_46_1.time_ - 0) / var_49_0)
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["1084ui_story"]) and arg_46_1.var_.characterEffect1084ui_story then
				arg_46_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_46_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_49_1 = 0
			local var_49_2 = 0.525

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_3 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(111102011).content)

				arg_46_1.text_.text = var_49_3

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_5 = 21 <= 0 and var_49_2 or var_49_2 * (utf8.len(var_49_3) / 21)

				if (21 <= 0 and var_49_2 or var_49_2 * (utf8.len(var_49_3) / 21)) > 0 and var_49_2 < var_49_5 then
					arg_46_1.talkMaxDuration = var_49_5

					if var_49_5 + var_49_1 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_5 + var_49_1
					end
				end

				arg_46_1.text_.text = var_49_3
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_6 = math.max(var_49_2, arg_46_1.talkMaxDuration)

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_6 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_1) / var_49_6

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_1 + var_49_6 and arg_46_1.time_ < var_49_1 + var_49_6 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play111102012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 111102012
		arg_50_1.duration_ = 4

		local var_50_0 = {
			ja = 4,
			ko = 2.1,
			zh = 2.5,
			en = 2.266
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play111102013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action2_2")
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_53_0 = arg_50_1.actors_["1094ui_story"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1094ui_story == nil then
				arg_50_1.var_.characterEffect1094ui_story = var_53_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_1 = 0.2

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_1 and not isNil(var_53_0) then
				if arg_50_1.var_.characterEffect1094ui_story and not isNil(var_53_0) then
					arg_50_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= 0 + var_53_1 and arg_50_1.time_ < 0 + var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1094ui_story then
				arg_50_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_53_3 = 0
			local var_53_4 = 0.25

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_3 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_5 = arg_50_1:GetWordFromCfg(111102012)
				local var_53_6 = arg_50_1:FormatText(var_53_5.content)

				arg_50_1.text_.text = var_53_6

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_8 = 10 <= 0 and var_53_4 or var_53_4 * (utf8.len(var_53_6) / 10)

				if (10 <= 0 and var_53_4 or var_53_4 * (utf8.len(var_53_6) / 10)) > 0 and var_53_4 < var_53_8 then
					arg_50_1.talkMaxDuration = var_53_8

					if var_53_8 + var_53_3 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_8 + var_53_3
					end
				end

				arg_50_1.text_.text = var_53_6
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111102", "111102012", "story_v_out_111102.awb") ~= 0 then
					local var_53_9 = manager.audio:GetVoiceLength("story_v_out_111102", "111102012", "story_v_out_111102.awb") / 1000

					if var_53_9 + var_53_3 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_9 + var_53_3
					end

					if var_53_5.prefab_name ~= "" and arg_50_1.actors_[var_53_5.prefab_name] ~= nil then
						local var_53_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_5.prefab_name].transform, "story_v_out_111102", "111102012", "story_v_out_111102.awb")

						arg_50_1:RecordAudio("111102012", var_53_10)
						arg_50_1:RecordAudio("111102012", var_53_10)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_111102", "111102012", "story_v_out_111102.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_111102", "111102012", "story_v_out_111102.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_11 = math.max(var_53_4, arg_50_1.talkMaxDuration)

			if var_53_3 <= arg_50_1.time_ and arg_50_1.time_ < var_53_3 + var_53_11 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_3) / var_53_11

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_3 + var_53_11 and arg_50_1.time_ < var_53_3 + var_53_11 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play111102013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 111102013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play111102014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(arg_54_1.actors_["1094ui_story"]) and arg_54_1.var_.characterEffect1094ui_story == nil then
				arg_54_1.var_.characterEffect1094ui_story = arg_54_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_0 = 0.2

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 and not isNil(arg_54_1.actors_["1094ui_story"]) then
				if arg_54_1.var_.characterEffect1094ui_story and not isNil(arg_54_1.actors_["1094ui_story"]) then
					arg_54_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_54_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_54_1.time_ - 0) / var_57_0)
				end
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["1094ui_story"]) and arg_54_1.var_.characterEffect1094ui_story then
				arg_54_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_54_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_57_1 = 0
			local var_57_2 = 0.825

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_3 = arg_54_1:FormatText(arg_54_1:GetWordFromCfg(111102013).content)

				arg_54_1.text_.text = var_57_3

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_5 = 33 <= 0 and var_57_2 or var_57_2 * (utf8.len(var_57_3) / 33)

				if (33 <= 0 and var_57_2 or var_57_2 * (utf8.len(var_57_3) / 33)) > 0 and var_57_2 < var_57_5 then
					arg_54_1.talkMaxDuration = var_57_5

					if var_57_5 + var_57_1 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_5 + var_57_1
					end
				end

				arg_54_1.text_.text = var_57_3
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_6 = math.max(var_57_2, arg_54_1.talkMaxDuration)

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_6 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_1) / var_57_6

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_1 + var_57_6 and arg_54_1.time_ < var_57_1 + var_57_6 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play111102014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 111102014
		arg_58_1.duration_ = 2.73

		local var_58_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.733,
			en = 2.2
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
				arg_58_0:Play111102015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_61_0 = arg_58_1.actors_["1094ui_story"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1094ui_story == nil then
				arg_58_1.var_.characterEffect1094ui_story = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_1 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_1 and not isNil(var_61_0) then
				if arg_58_1.var_.characterEffect1094ui_story and not isNil(var_61_0) then
					arg_58_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= 0 + var_61_1 and arg_58_1.time_ < 0 + var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1094ui_story then
				arg_58_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_61_3 = 0
			local var_61_4 = 0.2

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_3 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_5 = arg_58_1:GetWordFromCfg(111102014)
				local var_61_6 = arg_58_1:FormatText(var_61_5.content)

				arg_58_1.text_.text = var_61_6

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_8 = 8 <= 0 and var_61_4 or var_61_4 * (utf8.len(var_61_6) / 8)

				if (8 <= 0 and var_61_4 or var_61_4 * (utf8.len(var_61_6) / 8)) > 0 and var_61_4 < var_61_8 then
					arg_58_1.talkMaxDuration = var_61_8

					if var_61_8 + var_61_3 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_3
					end
				end

				arg_58_1.text_.text = var_61_6
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111102", "111102014", "story_v_out_111102.awb") ~= 0 then
					local var_61_9 = manager.audio:GetVoiceLength("story_v_out_111102", "111102014", "story_v_out_111102.awb") / 1000

					if var_61_9 + var_61_3 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_9 + var_61_3
					end

					if var_61_5.prefab_name ~= "" and arg_58_1.actors_[var_61_5.prefab_name] ~= nil then
						local var_61_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_5.prefab_name].transform, "story_v_out_111102", "111102014", "story_v_out_111102.awb")

						arg_58_1:RecordAudio("111102014", var_61_10)
						arg_58_1:RecordAudio("111102014", var_61_10)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_111102", "111102014", "story_v_out_111102.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_111102", "111102014", "story_v_out_111102.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_11 = math.max(var_61_4, arg_58_1.talkMaxDuration)

			if var_61_3 <= arg_58_1.time_ and arg_58_1.time_ < var_61_3 + var_61_11 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_3) / var_61_11

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_3 + var_61_11 and arg_58_1.time_ < var_61_3 + var_61_11 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play111102015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 111102015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
			arg_62_1.auto_ = false
		end

		function arg_62_1.playNext_(arg_64_0)
			arg_62_1.onStoryFinished_()
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["1094ui_story"]) and arg_62_1.var_.characterEffect1094ui_story == nil then
				arg_62_1.var_.characterEffect1094ui_story = arg_62_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_0 = 0.2

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["1094ui_story"]) then
				if arg_62_1.var_.characterEffect1094ui_story and not isNil(arg_62_1.actors_["1094ui_story"]) then
					arg_62_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_62_1.time_ - 0) / var_65_0)
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["1094ui_story"]) and arg_62_1.var_.characterEffect1094ui_story then
				arg_62_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_65_1 = 0
			local var_65_2 = 0.9

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_3 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(111102015).content)

				arg_62_1.text_.text = var_65_3

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_5 = 36 <= 0 and var_65_2 or var_65_2 * (utf8.len(var_65_3) / 36)

				if (36 <= 0 and var_65_2 or var_65_2 * (utf8.len(var_65_3) / 36)) > 0 and var_65_2 < var_65_5 then
					arg_62_1.talkMaxDuration = var_65_5

					if var_65_5 + var_65_1 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + var_65_1
					end
				end

				arg_62_1.text_.text = var_65_3
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_6 = math.max(var_65_2, arg_62_1.talkMaxDuration)

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_6 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_1) / var_65_6

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_1 + var_65_6 and arg_62_1.time_ < var_65_1 + var_65_6 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D06b"
	},
	voices = {
		"story_v_out_111102.awb"
	}
}
